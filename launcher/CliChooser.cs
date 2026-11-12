namespace PriorityAgent;

public enum AgentCliKind
{
    Grok,
    Cursor,
    OpenCode,
    Refuse,
}

public sealed record FoundCli(AgentCliKind Kind, string Path);

public enum CliChooserAction
{
    Launch,
    OfferZeroMenu,
    OfferWhich,
    AskInstallNow,
    Refuse,
}

public sealed record CliChooserResult(
    CliChooserAction Action,
    FoundCli? Launch,
    AgentCliKind? MissingKind,
    string Message,
    bool Download,
    int ExitCode);

/// <summary>
/// Issue #569 / FR-004: same choice rules as the MSI chooser, without downloads (FR-003).
/// Cursor probe paths align with FR #568 (cursor-agent\agent.cmd; never Cursor.exe GUI or .grok\bin\agent.exe).
/// </summary>
public static class CliChooser
{
    public const string NotFoundLine =
        "agent CLI not found (expected grok.exe, cursor-agent\\agent.cmd, or opencode.exe).";
    public const string InstallNowPrompt = "Install it now?";
    public const string ZeroMenu =
        "None installed. Offer Grok, Cursor, OpenCode, or refuse.";
    public const string WhichPrompt =
        "Two or more agent CLIs are installed. Ask which to launch. Do not pick by token fuel.";

    /// <summary>FR #568: Cursor agent CLI candidates (not the Cursor IDE GUI).</summary>
    public static IReadOnlyList<string> CursorAgentCandidatePaths(string localAppData) =>
        new[]
        {
            Path.Combine(localAppData, "cursor-agent", "agent.cmd"),
            Path.Combine(localAppData, "cursor-agent", "agent.exe"),
        };

    /// <summary>FR #568: .grok\bin\agent.exe is never Cursor.</summary>
    public static bool IsRejectedCursorPath(string? path)
    {
        if (string.IsNullOrWhiteSpace(path)) return true;
        string n = path.Replace('/', '\\');
        if (n.Contains(@"\.grok\bin\agent.exe", StringComparison.OrdinalIgnoreCase)
            || n.EndsWith(@"\.grok\bin\agent.cmd", StringComparison.OrdinalIgnoreCase)
            || n.EndsWith(@"\.grok\bin\agent", StringComparison.OrdinalIgnoreCase))
            return true;
        // Cursor IDE GUI is not the agent CLI.
        if (n.EndsWith(@"\Programs\cursor\Cursor.exe", StringComparison.OrdinalIgnoreCase)
            || n.EndsWith(@"\cursor\Cursor.exe", StringComparison.OrdinalIgnoreCase))
            return true;
        return false;
    }

    public static string? ResolveCursorAgent(string localAppData, IEnumerable<string?>? overrides = null)
    {
        foreach (string? o in overrides ?? Array.Empty<string?>())
        {
            if (string.IsNullOrWhiteSpace(o) || !File.Exists(o)) continue;
            if (IsRejectedCursorPath(o)) continue;
            return Path.GetFullPath(o);
        }
        foreach (string p in CursorAgentCandidatePaths(localAppData))
        {
            if (File.Exists(p) && !IsRejectedCursorPath(p))
                return Path.GetFullPath(p);
        }
        return null;
    }

    /// <summary>Hours loop always relaunches the chosen exe (FR #570 / MRB #577), never a hardcoded grok-only gate.</summary>
    public static string HoursRelaunchExe(FoundCli launch) => launch.Path;

    public static AgentCliKind? ParsePick(string? raw)
    {
        string t = (raw ?? "").Trim().ToLowerInvariant();
        if (t.Length == 0) return null;
        if (t is "refuse" or "not now" or "n" or "4") return AgentCliKind.Refuse;
        if (t is "grok" or "1") return AgentCliKind.Grok;
        if (t is "cursor" or "2") return AgentCliKind.Cursor;
        if (t is "opencode" or "3") return AgentCliKind.OpenCode;
        return null;
    }

    public static CliChooserResult Decide(
        IReadOnlyList<FoundCli> installed,
        bool stdinRedirected,
        AgentCliKind? pick,
        bool? installNow)
    {
        var list = installed ?? Array.Empty<FoundCli>();
        FoundCli? Match(AgentCliKind kind) =>
            list.FirstOrDefault(c => c.Kind == kind);

        if (pick == AgentCliKind.Refuse)
            return Refuse();

        if (pick is AgentCliKind wanted && wanted != AgentCliKind.Refuse)
        {
            var hit = Match(wanted);
            if (hit != null)
                return Launch(hit);
            return MissingPick(wanted, stdinRedirected, installNow);
        }

        if (list.Count == 1)
            return Launch(list[0]);

        if (list.Count == 0)
        {
            if (stdinRedirected)
                return Refuse();
            return new CliChooserResult(CliChooserAction.OfferZeroMenu, null, null, ZeroMenu, false, 0);
        }

        if (stdinRedirected)
            return Refuse();
        return new CliChooserResult(CliChooserAction.OfferWhich, null, null, WhichPrompt, false, 0);
    }

    static CliChooserResult Launch(FoundCli cli) =>
        new(CliChooserAction.Launch, cli, null, cli.Path, false, 0);

    static CliChooserResult Refuse() =>
        new(CliChooserAction.Refuse, null, null, NotFoundLine, false, 1);

    static CliChooserResult MissingPick(AgentCliKind wanted, bool stdinRedirected, bool? installNow)
    {
        if (stdinRedirected)
            return Refuse();
        if (installNow == false)
            return Refuse();
        if (installNow == true)
            return Refuse();
        return new CliChooserResult(
            CliChooserAction.AskInstallNow, null, wanted, InstallNowPrompt, false, 0);
    }
}
