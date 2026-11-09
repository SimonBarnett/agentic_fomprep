using System.Text;
using System.Text.Json;
using System.Text.RegularExpressions;

namespace PriorityAgent;

/// <summary>One Priority WCF instance for the agent (no credentials).</summary>
public sealed record WcfInstance(string Id, string ServerUrl, string Mode);

/// <summary>Loaded .priority-agent.json WCF settings plus legacy-airc warnings.</summary>
public sealed record WcfConfig(
    IReadOnlyList<WcfInstance> Instances,
    string? SourcePath,
    IReadOnlyList<string> LegacyAircWarnings);

/// <summary>
/// FR #348: Priority Agent uses the bobiverse Priority WCF client (direct + relay),
/// not airc remote-shell. Credentials never live in this JSON or in logs.
/// </summary>
public static class WcfSupport
{
    public const string RemovedAircMessage =
        "removed; use the WCF client (.priority-agent.json wcf instances: serverUrl + mode direct|relay)";

    static readonly Regex ModeOk = new(@"\A(direct|relay)\z", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant);
    static readonly Regex IdOk = new(@"\A[A-Za-z0-9][A-Za-z0-9_.-]{0,63}\z", RegexOptions.CultureInvariant);

    public static WcfConfig LoadConfig(string? projectDir, string? customerDir)
    {
        WcfConfig? project = ReadConfig(projectDir);
        WcfConfig? customer = ReadConfig(customerDir);
        var warnings = new List<string>();
        if (project != null) warnings.AddRange(project.LegacyAircWarnings);
        if (customer != null) warnings.AddRange(customer.LegacyAircWarnings);
        // Project wcf list fully replaces customer when present (including empty array).
        if (project != null && project.SourcePath != null && FileMentionsWcf(project.SourcePath))
        {
            return new WcfConfig(project.Instances, project.SourcePath, Dedup(warnings));
        }
        if (customer != null)
            return new WcfConfig(customer.Instances, customer.SourcePath, Dedup(warnings));
        return new WcfConfig(Array.Empty<WcfInstance>(), null, Dedup(warnings));
    }

    static bool FileMentionsWcf(string path)
    {
        try
        {
            string text = File.ReadAllText(path);
            return text.Contains("\"wcf\"", StringComparison.OrdinalIgnoreCase)
                || text.Contains("\"wcfInstances\"", StringComparison.OrdinalIgnoreCase);
        }
        catch { return false; }
    }

    static IReadOnlyList<string> Dedup(List<string> warnings) =>
        warnings.Distinct(StringComparer.Ordinal).ToList();

    static WcfConfig? ReadConfig(string? directory)
    {
        if (string.IsNullOrWhiteSpace(directory)) return null;
        string path = Path.Combine(directory, ".priority-agent.json");
        if (!File.Exists(path)) return null;
        try
        {
            using var doc = JsonDocument.Parse(File.ReadAllText(path));
            if (doc.RootElement.ValueKind != JsonValueKind.Object)
                return new WcfConfig(Array.Empty<WcfInstance>(), path, Array.Empty<string>());

            var warnings = new List<string>();
            if (doc.RootElement.TryGetProperty("airc", out _)
                || doc.RootElement.TryGetProperty("airc_console", out _))
            {
                warnings.Add(
                    $"legacy airc / airc_console in {path} ignored; use wcf instances (serverUrl + mode)");
            }

            var instances = new List<WcfInstance>();
            if (doc.RootElement.TryGetProperty("wcfInstances", out var arr)
                && arr.ValueKind == JsonValueKind.Array)
            {
                foreach (var item in arr.EnumerateArray())
                    TryAddInstance(instances, item);
            }
            else if (doc.RootElement.TryGetProperty("wcf", out var wcf))
            {
                if (wcf.ValueKind == JsonValueKind.Array)
                {
                    foreach (var item in wcf.EnumerateArray())
                        TryAddInstance(instances, item);
                }
                else if (wcf.ValueKind == JsonValueKind.Object)
                {
                    if (wcf.TryGetProperty("instances", out var nested)
                        && nested.ValueKind == JsonValueKind.Array)
                    {
                        foreach (var item in nested.EnumerateArray())
                            TryAddInstance(instances, item);
                    }
                    else
                    {
                        TryAddInstance(instances, wcf);
                    }
                }
            }

            return new WcfConfig(instances, path, warnings);
        }
        catch (JsonException)
        {
            return null;
        }
        catch (IOException)
        {
            return null;
        }
    }

    static void TryAddInstance(List<WcfInstance> list, JsonElement item)
    {
        if (item.ValueKind != JsonValueKind.Object) return;
        string id = ReadString(item, "id") ?? ReadString(item, "name") ?? "";
        string url = ReadString(item, "serverUrl")
            ?? ReadString(item, "server_url")
            ?? ReadString(item, "url")
            ?? "";
        string mode = (ReadString(item, "mode") ?? "direct").Trim().ToLowerInvariant();
        if (string.IsNullOrWhiteSpace(url)) return;
        if (!Uri.TryCreate(url.Trim(), UriKind.Absolute, out var uri)
            || (uri.Scheme != Uri.UriSchemeHttp && uri.Scheme != Uri.UriSchemeHttps))
            return;
        if (!ModeOk.IsMatch(mode)) mode = "direct";
        if (string.IsNullOrWhiteSpace(id)) id = uri.Host;
        id = id.Trim();
        if (!IdOk.IsMatch(id)) return;
        // Never keep credential-shaped keys even if someone put them in JSON.
        list.Add(new WcfInstance(id, uri.GetLeftPart(UriPartial.Path).TrimEnd('/'), mode));
    }

    static string? ReadString(JsonElement obj, string name) =>
        obj.TryGetProperty(name, out var el) && el.ValueKind == JsonValueKind.String
            ? el.GetString()
            : null;

    public static string NormalizeMode(string? mode)
    {
        string m = (mode ?? "direct").Trim().ToLowerInvariant();
        return ModeOk.IsMatch(m) ? m : "direct";
    }

    /// <summary>Write session-only instance list (id, serverUrl, mode only).</summary>
    public static string WriteSessionInstancesFile(string sessionDirectory, IReadOnlyList<WcfInstance> instances)
    {
        Directory.CreateDirectory(sessionDirectory);
        string path = Path.Combine(sessionDirectory, "wcf-instances.json");
        var payload = new
        {
            client = "bobiverse airc/scripts/priority_wcf.py (FR #6035 / #6026)",
            note = "Credentials come from CredMan / the local connections file; never from this JSON.",
            instances = instances.Select(i => new { id = i.Id, serverUrl = i.ServerUrl, mode = i.Mode }).ToArray(),
        };
        File.WriteAllText(path, JsonSerializer.Serialize(payload, new JsonSerializerOptions { WriteIndented = true }));
        return path;
    }

    public static string RenderSessionRules(
        string template,
        IReadOnlyList<WcfInstance> instances,
        string? instancesFilePath)
    {
        var sb = new StringBuilder();
        sb.AppendLine();
        sb.AppendLine("## Priority WCF client");
        sb.AppendLine();
        sb.AppendLine("- Do Priority work (tables, columns, procedures, forms, reports, interfaces;");
        sb.AppendLine("  prepare forms, reports and procedures) through the bobiverse Priority WCF client");
        sb.AppendLine("  (`airc/scripts/priority_wcf.py`, FR #6035 / #6026). Do **not** use an airc remote shell,");
        sb.AppendLine("  WINRUN/WINACTIV, the Priority web SDK (`priority-web-sdk`), or OData for that work.");
        sb.AppendLine("- Credentials never go in `.priority-agent.json`, argv, logs or IRC. Use CredMan /");
        sb.AppendLine("  the local connections file on this machine only.");
        sb.AppendLine("- `direct` mode: HTTPS to a reachable Priority host. `relay` mode: the same client");
        sb.AppendLine("  via the on-LAN airc box transport for internal-only servers.");
        if (instances.Count == 0)
        {
            sb.AppendLine("- No WCF instances are configured for this session. Ask Simon for");
            sb.AppendLine("  `.priority-agent.json` entries: `{ \"wcf\": [ { \"id\": \"...\", \"serverUrl\": \"https://...\", \"mode\": \"direct\" } ] }`.");
        }
        else
        {
            if (!string.IsNullOrWhiteSpace(instancesFilePath))
                sb.AppendLine($"- Session instance file (no secrets): `{instancesFilePath}`.");
            sb.AppendLine("- Configured instances:");
            foreach (var i in instances)
                sb.AppendLine($"  - `{i.Id}` serverUrl=`{i.ServerUrl}` mode=`{i.Mode}`");
        }
        string section = sb.ToString();
        return template
            .Replace("{{WCF_SECTION}}", section, StringComparison.Ordinal)
            .Replace("{{AIRC_SECTION}}", "", StringComparison.Ordinal);
    }

    public static bool AircSourceFilesGone(string launcherDirectory)
    {
        string[] gone =
        {
            "AircSupport.cs",
            "AircConsoleDiscovery.cs",
            "airc-dcc.md",
        };
        return gone.All(name => !File.Exists(Path.Combine(launcherDirectory, name)));
    }
}
