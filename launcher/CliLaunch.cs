namespace PriorityAgent;

/// <summary>
/// FR #570 / FR-005: build start arguments for Grok, Cursor, or OpenCode.
/// Grok keeps the existing RunGrok argument shape. Cursor and OpenCode never
/// receive Grok MCP / --cwd / --session-id / --rules flags. When a CLI's help
/// does not advertise a workspace flag, only Process WorkingDirectory is set.
/// </summary>
public static class CliLaunch
{
    public static readonly string[] GrokOnlyFlags =
    {
        "--cwd", "--session-id", "--rules", "--max-turns",
        "mcp", "--mcp-catalog",
    };

    public static bool TryParseKind(string? raw, out CliKind kind)
    {
        kind = CliKind.Grok;
        if (string.IsNullOrWhiteSpace(raw)) return false;
        switch (raw.Trim().ToLowerInvariant())
        {
            case "grok": kind = CliKind.Grok; return true;
            case "cursor": kind = CliKind.Cursor; return true;
            case "opencode":
            case "open-code":
            case "open_code":
                kind = CliKind.OpenCode; return true;
            default: return false;
        }
    }

    public static string KindName(CliKind kind) => kind switch
    {
        CliKind.Cursor => "cursor",
        CliKind.OpenCode => "opencode",
        _ => "grok",
    };

    /// <summary>
    /// Resolve the exe for a choice. Cursor must be cursor-agent\agent.cmd, never
    /// %USERPROFILE%\.grok\bin\agent.exe (FR-003 / FR #568).
    /// </summary>
    public static string? ResolveExecutable(CliKind kind, string home, IEnumerable<string?>? overrides = null)
    {
        foreach (string? o in overrides ?? Array.Empty<string?>())
        {
            if (!string.IsNullOrWhiteSpace(o) && File.Exists(o)) return Path.GetFullPath(o);
        }
        return kind switch
        {
            CliKind.Grok => FirstExisting(
                Path.Combine(home, ".grok", "bin", "grok.exe")),
            CliKind.Cursor => FirstExisting(
                Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "cursor-agent", "agent.cmd"),
                Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "cursor-agent", "agent.exe")),
            CliKind.OpenCode => FirstExisting(
                Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "opencode", "opencode.exe"),
                Path.Combine(home, "opencode", "opencode.exe"),
                Path.Combine(home, ".opencode", "bin", "opencode.exe")),
            _ => null,
        };
    }

    static string? FirstExisting(params string[] paths)
    {
        foreach (string p in paths)
        {
            if (!string.IsNullOrWhiteSpace(p) && File.Exists(p)) return Path.GetFullPath(p);
        }
        return null;
    }

    public static bool HelpMentions(string helpText, params string[] needles)
    {
        if (string.IsNullOrEmpty(helpText)) return false;
        foreach (string n in needles)
        {
            if (helpText.Contains(n, StringComparison.OrdinalIgnoreCase)) return true;
        }
        return false;
    }

    /// <summary>
    /// Build argv for the chosen CLI. WorkingDirectory on the process must still be set to workDir.
    /// </summary>
    public static List<string> BuildArguments(
        CliKind kind,
        string workDir,
        string sessionId,
        string rules,
        string brief,
        bool smoke,
        string? helpText = null,
        bool hoursRelaunch = false,
        string? hoursPrompt = null)
    {
        return kind switch
        {
            CliKind.Grok => BuildGrok(workDir, sessionId, rules, brief, smoke, hoursRelaunch, hoursPrompt),
            CliKind.Cursor => BuildCursor(workDir, brief, smoke, helpText, hoursRelaunch, hoursPrompt),
            CliKind.OpenCode => BuildOpenCode(workDir, brief, smoke, helpText, hoursRelaunch, hoursPrompt),
            _ => new List<string>(),
        };
    }

    static List<string> BuildGrok(
        string workDir, string sessionId, string rules, string brief, bool smoke,
        bool hoursRelaunch, string? hoursPrompt)
    {
        if (hoursRelaunch)
        {
            var resume = new List<string> { "--cwd", workDir, "--resume", sessionId, "--trust", "--rules", rules };
            if (!string.IsNullOrEmpty(hoursPrompt)) resume.Add(hoursPrompt);
            return resume;
        }
        return LauncherSupport.BuildGrokArguments(workDir, sessionId, rules, brief, smoke);
    }

    static List<string> BuildCursor(
        string workDir, string brief, bool smoke, string? helpText,
        bool hoursRelaunch, string? hoursPrompt)
    {
        var args = new List<string>();
        string help = helpText ?? "";
        // FR #570: only add flags advertised in --help; unknown help => work dir only (PSI.WorkingDirectory).
        if (!string.IsNullOrEmpty(help) && HelpMentions(help, "--workspace"))
        {
            args.Add("--workspace");
            args.Add(workDir);
        }
        if (!string.IsNullOrEmpty(help) && HelpMentions(help, "--trust"))
            args.Add("--trust");
        if (hoursRelaunch && !string.IsNullOrEmpty(help) && HelpMentions(help, "--resume"))
            args.Add("--resume");
        if (smoke && !string.IsNullOrEmpty(help) && HelpMentions(help, "--print"))
            args.Add("--print");
        string prompt = hoursRelaunch && !string.IsNullOrEmpty(hoursPrompt) ? hoursPrompt! : brief;
        if (!string.IsNullOrWhiteSpace(prompt) && !string.IsNullOrEmpty(help))
            args.Add(prompt);
        AssertNoGrokOnlyFlags(args);
        return args;
    }

    static List<string> BuildOpenCode(
        string workDir, string brief, bool smoke, string? helpText,
        bool hoursRelaunch, string? hoursPrompt)
    {
        var args = new List<string>();
        string help = helpText ?? "";
        if (!string.IsNullOrEmpty(help))
        {
            // Prefer OpenCode's own --dir. Never pass Grok --cwd (GrokOnlyFlags / FR #570).
            if (HelpMentions(help, "--dir ", "--dir\t", "--dir=", " --dir"))
            {
                args.Add("--dir");
                args.Add(workDir);
            }
            // else: work directory only via ProcessStartInfo.WorkingDirectory
        }
        string prompt = hoursRelaunch && !string.IsNullOrEmpty(hoursPrompt) ? hoursPrompt! : brief;
        if (!string.IsNullOrWhiteSpace(prompt) && !string.IsNullOrEmpty(help))
            args.Add(prompt);
        _ = smoke;
        AssertNoGrokOnlyFlags(args);
        return args;
    }

    public static void AssertNoGrokOnlyFlags(IEnumerable<string> args)
    {
        foreach (string a in args)
        {
            foreach (string bad in GrokOnlyFlags)
            {
                if (a.Equals(bad, StringComparison.OrdinalIgnoreCase))
                    throw new InvalidOperationException("FR #570: Cursor/OpenCode argv must not include Grok flag " + bad);
            }
        }
    }

    public static bool ArgsContainGrokOnlyFlag(IEnumerable<string> args)
    {
        foreach (string a in args)
        {
            foreach (string bad in GrokOnlyFlags)
            {
                if (a.Equals(bad, StringComparison.OrdinalIgnoreCase)) return true;
            }
        }
        return false;
    }
}
