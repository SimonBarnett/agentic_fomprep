using System.Text.Json;
using System.Text.RegularExpressions;

namespace PriorityAgent;

public sealed record AircConfig(bool? Enabled, string? Console, string? EnabledSource, string? ConsoleSource);
public sealed record AircSessionFiles(string CommandsSkill, string ArchitectureSkill, string DccGuide);

public static class AircSupport
{
    public const int MaxWindowsCommandLineLength = 32_000;
    static readonly Regex ConsoleNick = new(@"\A[A-Za-z0-9][A-Za-z0-9_-]*_console\z", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant);
    static readonly Regex MachineId = new(@"\A[A-Za-z0-9][A-Za-z0-9_-]*\z", RegexOptions.CultureInvariant);

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

    public static bool IsValidConsole(string? console) =>
        !string.IsNullOrWhiteSpace(console) && ConsoleNick.IsMatch(console.Trim());

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

    public static string ConnectionFileStatus(string customer, string path, bool exists) =>
        $"connections file for {customer} {(exists ? "exists" : "MISSING - ask Haitch for it")}: {path} (contents not read)";

    public static void WriteSessionMetadata(string sessionDirectory, string rules, object launchMetadata)
    {
        Directory.CreateDirectory(sessionDirectory);
        File.WriteAllText(Path.Combine(sessionDirectory, "rules.md"), rules);
        File.WriteAllText(Path.Combine(sessionDirectory, "launch.json"),
            System.Text.Json.JsonSerializer.Serialize(launchMetadata, new System.Text.Json.JsonSerializerOptions { WriteIndented = true }));
    }

    public static bool TrySelectListedConsole(
        bool enabled,
        AircConsoleDiscoveryResult discovery,
        string? configured,
        string? requested,
        bool interactive,
        Func<IReadOnlyList<string>, string?, string?>? ask,
        out string? console,
        out string reason)
    {
        console = null;
        if (!enabled) { reason = "airc disabled"; return false; }
        string? preferred = !string.IsNullOrWhiteSpace(requested) ? requested.Trim()
            : !string.IsNullOrWhiteSpace(configured) ? configured.Trim() : null;
        if (!discovery.Available)
        {
            if (preferred != null && IsValidConsole(preferred))
            {
                console = preferred;
                reason = "console not verified: " + discovery.Error;
                return true;
            }
            reason = preferred == null ? discovery.Error : "invalid configured airc console nick";
            return false;
        }
        if (discovery.Consoles.Count == 0)
        {
            if (preferred != null && IsValidConsole(preferred))
            {
                console = preferred;
                reason = "console not verified: no *_console connected on irc.ntsa.uk";
                return true;
            }
            reason = preferred == null ? "no *_console connected on irc.ntsa.uk" : "invalid configured airc console nick";
            return false;
        }
        console = ChooseConsole(discovery.Consoles, configured, requested, interactive, ask);
        if (console == null)
        {
            reason = requested == null ? "no console selected" : "requested console is not connected";
            return false;
        }
        reason = "";
        return true;
    }

    public static AircSessionFiles WriteSessionFiles(
        string sessionDirectory,
        IReadOnlyList<string> skillContents,
        string dccTemplate,
        string console)
    {
        if (skillContents.Count != 2) throw new ArgumentException("Exactly two airc skills are required.", nameof(skillContents));
        if (MachineFromConsole(console) == null) throw new ArgumentException("Invalid airc console nick.", nameof(console));
        string skillRoot = Path.Combine(sessionDirectory, "airc");
        string commandsPath = Path.Combine(skillRoot, "bobiverse-airc-commands", "SKILL.md");
        string architecturePath = Path.Combine(skillRoot, "bobiverse-airc", "SKILL.md");
        string dccPath = Path.Combine(skillRoot, "airc-dcc.md");
        Directory.CreateDirectory(Path.GetDirectoryName(commandsPath)!);
        Directory.CreateDirectory(Path.GetDirectoryName(architecturePath)!);
        File.WriteAllText(commandsPath, skillContents[0]);
        File.WriteAllText(architecturePath, skillContents[1]);
        File.WriteAllText(dccPath, dccTemplate.Replace("{{AIRC_CONSOLE}}", console, StringComparison.Ordinal));
        return new AircSessionFiles(commandsPath, architecturePath, dccPath);
    }

    public static string RenderSessionRules(
        string template, bool enabled, string? console, string source, AircSessionFiles? files,
        bool consoleVerified = true, string consoleSource = "")
    {
        string section = "";
        if (enabled)
        {
            string machine = MachineFromConsole(console) ?? throw new InvalidDataException("Invalid airc console nick");
            const string troubleshooting = "airc/.grok/skills/bobiverse-airc-troubleshooting/SKILL.md";
            if (files == null) throw new ArgumentNullException(nameof(files));
            section = """

## Airc session-only context

- Selected target: `{{AIRC_CONSOLE}}` on channel `#{{AIRC_MACHINE}}`. Send remote shell PRIVMSGs only to this selected console; do not address any other console.
- Console machine id: `{{AIRC_MACHINE}}`. {{AIRC_VERIFICATION}}
- Source: SimonBarnett/bobiverse `{{AIRC_SOURCE}}`. Troubleshooting is not preloaded; read `{{AIRC_TROUBLESHOOTING}}` only if the console misbehaves.
- Read these session-only airc files before working: `{{AIRC_COMMANDS_SKILL}}`, `{{AIRC_ARCHITECTURE_SKILL}}`, and `{{AIRC_DCC_GUIDE}}`.
""".Replace("{{AIRC_SOURCE}}", source, StringComparison.Ordinal)
                .Replace("{{AIRC_VERIFICATION}}", consoleVerified
                    ? "The console selection came from a read-only IRC NAMES lookup."
                    : $"The console was selected from {consoleSource} and was not verified as connected.", StringComparison.Ordinal)
                .Replace("{{AIRC_TROUBLESHOOTING}}", troubleshooting, StringComparison.Ordinal)
                .Replace("{{AIRC_COMMANDS_SKILL}}", files.CommandsSkill, StringComparison.Ordinal)
                .Replace("{{AIRC_ARCHITECTURE_SKILL}}", files.ArchitectureSkill, StringComparison.Ordinal)
                .Replace("{{AIRC_DCC_GUIDE}}", files.DccGuide, StringComparison.Ordinal)
                .Replace("{{AIRC_CONSOLE}}", console!, StringComparison.Ordinal)
                .Replace("{{AIRC_MACHINE}}", machine, StringComparison.Ordinal);
        }
        return template.Replace("{{AIRC_SECTION}}", section, StringComparison.Ordinal);
    }

    public static List<string> BuildGrokArguments(string workDir, string sessionId, string rules, string brief, bool smoke)
    {
        var args = new List<string> { "--cwd", workDir, "--session-id", sessionId, "--trust", "--rules", rules };
        if (smoke) args.AddRange(new[] { "--max-turns", "4", "-p" });
        args.Add(brief);
        return args;
    }

    public static int WindowsCommandLineLength(string executable, IEnumerable<string> arguments) =>
        string.Join(' ', new[] { QuoteWindowsArgument(executable) }.Concat(arguments.Select(QuoteWindowsArgument))).Length + 1;

    public static int ValidateWindowsCommandLine(string executable, IEnumerable<string> arguments, string operation)
    {
        int length = WindowsCommandLineLength(executable, arguments);
        if (length > MaxWindowsCommandLineLength)
            throw new InvalidOperationException($"{operation} command line is {length} characters; Windows limit guard is {MaxWindowsCommandLineLength}. Reduce the prompt or rules content.");
        return length;
    }

    static string QuoteWindowsArgument(string value)
    {
        if (value.Length > 0 && !value.Any(char.IsWhiteSpace) && !value.Contains('"')) return value;
        var result = new System.Text.StringBuilder("\"");
        int slashes = 0;
        foreach (char c in value)
        {
            if (c == '\\') { slashes++; continue; }
            if (c == '"')
            {
                result.Append('\\', slashes * 2 + 1).Append('"');
                slashes = 0;
                continue;
            }
            result.Append('\\', slashes).Append(c);
            slashes = 0;
        }
        result.Append('\\', slashes * 2).Append('"');
        return result.ToString();
    }
}
