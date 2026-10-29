using System.Text.Json;
using System.Text.RegularExpressions;

namespace PriorityAgent;

public sealed record AircConfig(bool? Enabled, string? Console, string? EnabledSource, string? ConsoleSource);

public static class AircSupport
{
    static readonly Regex ConsoleNick = new(@"^[A-Za-z0-9][A-Za-z0-9_-]*_console$", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant);
    static readonly Regex MachineId = new(@"^[A-Za-z0-9][A-Za-z0-9_-]*$", RegexOptions.CultureInvariant);

    public static AircConfig LoadConfig(string? projectDir, string? customerDir)
    {
        AircConfig? project = ReadConfig(projectDir);
        AircConfig? customer = ReadConfig(customerDir);
        return new AircConfig(
            project?.Enabled ?? customer?.Enabled,
            project?.Console ?? customer?.Console,
            project?.Enabled.HasValue == true ? project.EnabledSource : customer?.EnabledSource,
            project?.Console != null ? project.ConsoleSource : customer?.ConsoleSource);
    }

    static AircConfig? ReadConfig(string? directory)
    {
        if (string.IsNullOrWhiteSpace(directory)) return null;
        string path = Path.Combine(directory, ".priority-agent.json");
        if (!File.Exists(path)) return null;
        try
        {
            using var doc = JsonDocument.Parse(File.ReadAllText(path));
            if (doc.RootElement.ValueKind != JsonValueKind.Object) return null;
            bool? enabled = doc.RootElement.TryGetProperty("airc", out var airc)
                && (airc.ValueKind == JsonValueKind.True || airc.ValueKind == JsonValueKind.False)
                    ? airc.GetBoolean() : null;
            string? console = doc.RootElement.TryGetProperty("airc_console", out var nick)
                && nick.ValueKind == JsonValueKind.String ? nick.GetString() : null;
            return new AircConfig(enabled, console, enabled.HasValue ? path : null, console != null ? path : null);
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

    public static bool ResolveEnabled(bool? commandLine, bool hasConsoleOverride, bool? configured, bool interactive, Func<bool?, bool>? ask)
    {
        if (hasConsoleOverride) return true;
        if (commandLine.HasValue) return commandLine.Value;
        if (!interactive) return configured ?? false;
        return ask?.Invoke(configured) ?? configured ?? false;
    }

    public static List<string> NormalizeConsoles(IEnumerable<string> candidates) =>
        candidates.Select(x => x.Trim().TrimStart('~', '&', '@', '%', '+'))
            .Where(x => ConsoleNick.IsMatch(x))
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .OrderBy(x => x, StringComparer.OrdinalIgnoreCase)
            .ToList();

    public static string? ChooseConsole(
        IEnumerable<string> candidates,
        string? preferred,
        string? requested,
        bool interactive,
        Func<IReadOnlyList<string>, string?, string?>? ask)
    {
        var consoles = NormalizeConsoles(candidates);
        if (!string.IsNullOrWhiteSpace(requested))
            return consoles.FirstOrDefault(x => x.Equals(requested.Trim(), StringComparison.OrdinalIgnoreCase));
        string? preselected = consoles.FirstOrDefault(x => x.Equals(preferred?.Trim(), StringComparison.OrdinalIgnoreCase));
        if (!interactive) return preselected ?? (consoles.Count == 1 ? consoles[0] : null);
        if (consoles.Count == 0) return null;
        return ask?.Invoke(consoles, preselected);
    }

    public static string? MachineFromConsole(string? console)
    {
        if (string.IsNullOrWhiteSpace(console) || !ConsoleNick.IsMatch(console)) return null;
        return console[..^"_console".Length];
    }

    public static List<string> MachineChannelsFromReport(string reportJson)
    {
        using var doc = JsonDocument.Parse(reportJson);
        if (!doc.RootElement.TryGetProperty("machines", out var machines) || machines.ValueKind != JsonValueKind.Object)
            return new();
        return machines.EnumerateObject()
            .Select(p => p.Name)
            .Where(x => MachineId.IsMatch(x))
            .Select(x => "#" + x)
            .Distinct(StringComparer.OrdinalIgnoreCase)
            .Take(100)
            .ToList();
    }

    public static List<string> ConsolesFromNames(IEnumerable<string> ircLines)
    {
        var nicks = new List<string>();
        foreach (string line in ircLines)
        {
            int marker = line.IndexOf(" 353 ", StringComparison.Ordinal);
            int names = line.LastIndexOf(':');
            if (marker < 0 || names < 0) continue;
            nicks.AddRange(line[(names + 1)..].Split(' ', StringSplitOptions.RemoveEmptyEntries));
        }
        return NormalizeConsoles(nicks);
    }

    public static bool ConnectionFileExists(string path) => File.Exists(path);

    public static string RenderSessionRules(
        string template, bool enabled, string? console, string source, string skills, string dcc)
    {
        string section = "";
        if (enabled)
        {
            string machine = MachineFromConsole(console) ?? throw new InvalidDataException("Invalid airc console nick");
            const string troubleshooting = "airc/.grok/skills/bobiverse-airc-troubleshooting/SKILL.md";
            section = """

## Airc session-only context

- Selected target: `{{AIRC_CONSOLE}}` on channel `#{{AIRC_MACHINE}}`. Send remote shell PRIVMSGs only to this selected console; do not address any other console.
- Console machine id: `{{AIRC_MACHINE}}`. The console selection came from a read-only IRC NAMES lookup.
- Source: SimonBarnett/bobiverse `{{AIRC_SOURCE}}`. Troubleshooting is not preloaded; read `{{AIRC_TROUBLESHOOTING}}` only if the console misbehaves.
- The following are the only airc skills loaded for this session:

{{AIRC_SKILLS}}

{{AIRC_DCC}}
""".Replace("{{AIRC_SOURCE}}", source, StringComparison.Ordinal)
                .Replace("{{AIRC_TROUBLESHOOTING}}", troubleshooting, StringComparison.Ordinal)
                .Replace("{{AIRC_SKILLS}}", skills, StringComparison.Ordinal)
                .Replace("{{AIRC_DCC}}", dcc, StringComparison.Ordinal)
                .Replace("{{AIRC_CONSOLE}}", console!, StringComparison.Ordinal)
                .Replace("{{AIRC_MACHINE}}", machine, StringComparison.Ordinal);
        }
        return template.Replace("{{AIRC_SECTION}}", section, StringComparison.Ordinal);
    }
}
