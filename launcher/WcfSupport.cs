using System.Text;
using System.Text.Json;
using System.Text.RegularExpressions;

namespace PriorityAgent;

/// <summary>One Priority SaaS WCF allowlist row (no credentials / tokens).</summary>
public sealed record WcfInstance(
    string Id,
    string Host,
    string Tenant,
    string Company,
    string User,
    string TokenFile,
    int Language,
    bool AllowLive,
    string OdataBase);

/// <summary>Loaded SaaS WCF allowlist plus legacy-airc / wrong-schema warnings.</summary>
public sealed record WcfConfig(
    IReadOnlyList<WcfInstance> Instances,
    string? SourcePath,
    IReadOnlyList<string> LegacyAircWarnings);

/// <summary>
/// FR #348: Priority Agent uses fom-prep <c>v2/apps/priority-saas-wcf</c>
/// (<c>bin/priority-wcf.mjs</c>), not airc remote-shell and not bobiverse #6026
/// <c>priority_wcf.py</c>. Credentials never live in allowlist JSON or logs.
/// </summary>
public static class WcfSupport
{
    public const string RemovedAircMessage =
        "removed; use the WCF client (v2/apps/priority-saas-wcf bin/priority-wcf.mjs; instances.json allowlist + tokenFile / PRIORITY_SAAS_TOKEN)";

    public const string ClientPath = "v2/apps/priority-saas-wcf/bin/priority-wcf.mjs";
    public const string ClientSkill = "priority-saas-wcf";

    static readonly Regex IdOk = new(@"\A[A-Za-z0-9][A-Za-z0-9_.-]{0,63}\z", RegexOptions.CultureInvariant);

    /// <summary>Default allowlist path (override with PRIORITY_SAAS_WCF_INSTANCES).</summary>
    public static string DefaultInstancesPath()
    {
        string? env = Environment.GetEnvironmentVariable("PRIORITY_SAAS_WCF_INSTANCES");
        if (!string.IsNullOrWhiteSpace(env)) return env.Trim();
        return Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.UserProfile),
            ".priority-saas-wcf",
            "instances.json");
    }

    public static WcfConfig LoadConfig(string? projectDir, string? customerDir)
    {
        var warnings = new List<string>();
        // 1) Explicit project/customer pointer or embedded SaaS-shaped list in .priority-agent.json
        WcfConfig? project = ReadPriorityAgentConfig(projectDir, warnings);
        if (project != null && project.SourcePath != null && project.Instances.Count >= 0
            && FileMentionsWcf(project.SourcePath))
        {
            // Project file that mentions wcf fully replaces customer + default for this session.
            return new WcfConfig(project.Instances, project.SourcePath, Dedup(warnings));
        }
        WcfConfig? customer = ReadPriorityAgentConfig(customerDir, warnings);
        if (customer != null && customer.SourcePath != null && FileMentionsWcf(customer.SourcePath)
            && customer.Instances.Count > 0)
        {
            return new WcfConfig(customer.Instances, customer.SourcePath, Dedup(warnings));
        }
        // 2) Shared SaaS allowlist file
        string shared = DefaultInstancesPath();
        WcfConfig? fromFile = ReadInstancesFile(shared, warnings);
        if (fromFile != null)
            return new WcfConfig(fromFile.Instances, fromFile.SourcePath, Dedup(warnings));
        // Still surface legacy airc warnings from project/customer even when no instances.
        if (project != null) warnings.AddRange(project.LegacyAircWarnings);
        if (customer != null) warnings.AddRange(customer.LegacyAircWarnings);
        return new WcfConfig(Array.Empty<WcfInstance>(), null, Dedup(warnings));
    }

    static bool FileMentionsWcf(string path)
    {
        try
        {
            string text = File.ReadAllText(path);
            return text.Contains("\"wcf\"", StringComparison.OrdinalIgnoreCase)
                || text.Contains("\"wcfInstances\"", StringComparison.OrdinalIgnoreCase)
                || text.Contains("\"wcfInstancesPath\"", StringComparison.OrdinalIgnoreCase)
                || text.Contains("\"prioritySaasWcfInstances\"", StringComparison.OrdinalIgnoreCase)
                || text.Contains("\"instances\"", StringComparison.OrdinalIgnoreCase);
        }
        catch { return false; }
    }

    static IReadOnlyList<string> Dedup(List<string> warnings) =>
        warnings.Distinct(StringComparer.Ordinal).ToList();

    static WcfConfig? ReadPriorityAgentConfig(string? directory, List<string> warnings)
    {
        if (string.IsNullOrWhiteSpace(directory)) return null;
        string path = Path.Combine(directory, ".priority-agent.json");
        if (!File.Exists(path)) return null;
        try
        {
            using var doc = JsonDocument.Parse(File.ReadAllText(path));
            if (doc.RootElement.ValueKind != JsonValueKind.Object)
                return new WcfConfig(Array.Empty<WcfInstance>(), path, Array.Empty<string>());

            var localWarn = new List<string>();
            if (doc.RootElement.TryGetProperty("airc", out _)
                || doc.RootElement.TryGetProperty("airc_console", out _))
            {
                localWarn.Add(
                    $"legacy airc / airc_console in {path} ignored; use priority-saas-wcf instances.json allowlist");
            }

            // Pointer to allowlist file
            string? pointed =
                ReadString(doc.RootElement, "wcfInstancesPath")
                ?? ReadString(doc.RootElement, "prioritySaasWcfInstances");
            if (!string.IsNullOrWhiteSpace(pointed))
            {
                string resolved = Path.IsPathRooted(pointed)
                    ? pointed
                    : Path.GetFullPath(Path.Combine(directory, pointed));
                var fromPtr = ReadInstancesFile(resolved, localWarn);
                warnings.AddRange(localWarn);
                if (fromPtr != null)
                    return new WcfConfig(fromPtr.Instances, fromPtr.SourcePath, Dedup(localWarn));
                return new WcfConfig(Array.Empty<WcfInstance>(), path, Dedup(localWarn));
            }

            var instances = new List<WcfInstance>();
            if (doc.RootElement.TryGetProperty("wcfInstances", out var arr)
                && arr.ValueKind == JsonValueKind.Array)
            {
                foreach (var item in arr.EnumerateArray())
                    TryAddInstance(instances, item, localWarn, path);
            }
            else if (doc.RootElement.TryGetProperty("wcf", out var wcf))
            {
                if (wcf.ValueKind == JsonValueKind.Array)
                {
                    foreach (var item in wcf.EnumerateArray())
                        TryAddInstance(instances, item, localWarn, path);
                }
                else if (wcf.ValueKind == JsonValueKind.Object)
                {
                    if (wcf.TryGetProperty("instances", out var nested)
                        && nested.ValueKind == JsonValueKind.Array)
                    {
                        foreach (var item in nested.EnumerateArray())
                            TryAddInstance(instances, item, localWarn, path);
                    }
                    else
                    {
                        TryAddInstance(instances, wcf, localWarn, path);
                    }
                }
            }
            else if (doc.RootElement.TryGetProperty("instances", out var top)
                     && top.ValueKind == JsonValueKind.Array)
            {
                foreach (var item in top.EnumerateArray())
                    TryAddInstance(instances, item, localWarn, path);
            }

            warnings.AddRange(localWarn);
            return new WcfConfig(instances, path, Dedup(localWarn));
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

    static WcfConfig? ReadInstancesFile(string path, List<string> warnings)
    {
        if (string.IsNullOrWhiteSpace(path) || !File.Exists(path)) return null;
        try
        {
            using var doc = JsonDocument.Parse(File.ReadAllText(path));
            JsonElement root = doc.RootElement;
            JsonElement arr;
            if (root.ValueKind == JsonValueKind.Object
                && root.TryGetProperty("instances", out var nested)
                && nested.ValueKind == JsonValueKind.Array)
            {
                arr = nested;
            }
            else if (root.ValueKind == JsonValueKind.Array)
            {
                arr = root;
            }
            else
            {
                return new WcfConfig(Array.Empty<WcfInstance>(), path, Array.Empty<string>());
            }
            var instances = new List<WcfInstance>();
            var localWarn = new List<string>();
            foreach (var item in arr.EnumerateArray())
                TryAddInstance(instances, item, localWarn, path);
            warnings.AddRange(localWarn);
            return new WcfConfig(instances, path, Dedup(localWarn));
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

    static void TryAddInstance(
        List<WcfInstance> list,
        JsonElement item,
        List<string> warnings,
        string sourcePath)
    {
        if (item.ValueKind != JsonValueKind.Object) return;

        // Reject bobiverse #6026 shape (serverUrl + mode) — FR #348 requires SaaS allowlist.
        if (item.TryGetProperty("serverUrl", out _)
            || item.TryGetProperty("server_url", out _)
            || (item.TryGetProperty("mode", out _)
                && !item.TryGetProperty("host", out _)
                && !item.TryGetProperty("tenant", out _)))
        {
            warnings.Add(
                $"ignored bobiverse #6026-shaped WCF row in {sourcePath}; use SaaS allowlist fields host/tenant/tokenFile (priority-wcf.mjs)");
            return;
        }

        string id = (ReadString(item, "id") ?? ReadString(item, "name") ?? "").Trim();
        string host = (ReadString(item, "host") ?? "").Trim();
        string tenant = (ReadString(item, "tenant") ?? "").Trim();
        string company = (ReadString(item, "company") ?? ReadString(item, "dname") ?? "").Trim();
        string user = (ReadString(item, "user") ?? "").Trim();
        string tokenFile = (ReadString(item, "tokenFile") ?? ReadString(item, "token_file") ?? "").Trim();
        string odata = (ReadString(item, "odataBase") ?? ReadString(item, "odata_base") ?? "").Trim();
        int language = 3;
        if (item.TryGetProperty("language", out var langEl))
        {
            if (langEl.ValueKind == JsonValueKind.Number && langEl.TryGetInt32(out var li))
                language = li;
        }
        bool allowLive = false;
        if (item.TryGetProperty("allowLive", out var liveEl)
            && (liveEl.ValueKind == JsonValueKind.True || liveEl.ValueKind == JsonValueKind.False))
        {
            allowLive = liveEl.GetBoolean();
        }

        if (string.IsNullOrWhiteSpace(id) || !IdOk.IsMatch(id)) return;
        if (string.IsNullOrWhiteSpace(host) || string.IsNullOrWhiteSpace(tenant)) return;
        // tokenFile may be empty when PRIORITY_SAAS_TOKEN is used for the process.
        list.Add(new WcfInstance(id, host, tenant, company, user, tokenFile, language, allowLive, odata));
    }

    static string? ReadString(JsonElement obj, string name) =>
        obj.TryGetProperty(name, out var el) && el.ValueKind == JsonValueKind.String
            ? el.GetString()
            : null;

    /// <summary>Write session-only allowlist copy (no tokens / passwords).</summary>
    public static string WriteSessionInstancesFile(string sessionDirectory, IReadOnlyList<WcfInstance> instances)
    {
        Directory.CreateDirectory(sessionDirectory);
        string path = Path.Combine(sessionDirectory, "wcf-instances.json");
        var payload = new
        {
            client = ClientPath,
            skill = ClientSkill,
            note = "Tokens from tokenFile / PRIORITY_SAAS_TOKEN only; never from this JSON or .priority-agent.json.",
            instances = instances.Select(i => new
            {
                id = i.Id,
                host = i.Host,
                tenant = i.Tenant,
                company = i.Company,
                user = i.User,
                tokenFile = i.TokenFile,
                language = i.Language,
                allowLive = i.AllowLive,
                odataBase = i.OdataBase,
            }).ToArray(),
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
        sb.AppendLine("## Priority WCF client (fom-prep)");
        sb.AppendLine();
        sb.AppendLine("- Do Priority work (forms, form/procedure/report prepare, procs) through the");
        sb.AppendLine($"  fom-prep client `{ClientPath}` and skill `{ClientSkill}` (PR #338 / #346).");
        sb.AppendLine("  Do **not** use an airc remote shell, WINRUN/WINACTIV, raw `priority-web-sdk`,");
        sb.AppendLine("  OData for that work, or bobiverse `airc/scripts/priority_wcf.py` (#6026).");
        sb.AppendLine("- Allowlist: `%USERPROFILE%\\.priority-saas-wcf\\instances.json` (or env");
        sb.AppendLine("  `PRIORITY_SAAS_WCF_INSTANCES`). Tokens via `tokenFile` under `C:\\passwords\\`");
        sb.AppendLine("  or process env `PRIORITY_SAAS_TOKEN`. Never store tokens in git or `.priority-agent.json`.");
        sb.AppendLine("- Example: `node v2/apps/priority-saas-wcf/bin/priority-wcf.mjs whoami --instance <id>`");
        sb.AppendLine("- Example: `node v2/apps/priority-saas-wcf/bin/priority-wcf.mjs batch --request <file> --instance <id>`");
        sb.AppendLine("- An empty answer at the Priority USERLOGIN prompt accepts the saved login when one is offered.");
        if (instances.Count == 0)
        {
            sb.AppendLine("- No WCF instances are configured for this session. Ask Simon to add an");
            sb.AppendLine("  allowlist row (id/host/tenant/company/user/tokenFile/allowLive) or set");
            sb.AppendLine("  `wcfInstancesPath` in `.priority-agent.json`.");
        }
        else
        {
            if (!string.IsNullOrWhiteSpace(instancesFilePath))
                sb.AppendLine($"- Session allowlist copy (no secrets): `{instancesFilePath}`.");
            sb.AppendLine("- Configured instances:");
            foreach (var i in instances)
            {
                sb.AppendLine(
                    $"  - `{i.Id}` host=`{i.Host}` tenant=`{i.Tenant}` company=`{i.Company}` allowLive=`{i.AllowLive}`");
            }
        }
        sb.AppendLine();
        sb.AppendLine("## Harvest on the WCF client (FR #348)");
        sb.AppendLine();
        sb.AppendLine("- Every session that uses `priority-wcf` ends with a harvest through Bobiverse intake");
        sb.AppendLine("  `https://bob.ntsa.uk/bob/v1/intake` via `tools\\Report-FomprepIntakeIssue.ps1`");
        sb.AppendLine("  (`-Kind issue|fr|skill|harvest`) and `tools\\Invoke-FomprepHarvest.ps1`.");
        sb.AppendLine("  Never `gh issue create` / `gh pr create` for harvest; never push to main.");
        sb.AppendLine("- Bugs / failed calls: `-Kind issue`. Lessons / skill fixes: `-Kind skill` or `harvest`.");
        sb.AppendLine("  If nothing went wrong, still harvest an explicit \"no findings\" so silence is not a report.");
        sb.AppendLine("- Destinations: generic Priority -> `repo=SimonBarnett/agentic_fomprep`;");
        sb.AppendLine("  customer-specific -> that customer's repo root; SO/SC facts -> that folder under the");
        sb.AppendLine("  customer repo (path in the body).");
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
