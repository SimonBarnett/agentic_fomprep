// FR #568: detect Grok / Cursor / OpenCode without mistaking Grok's agent.exe for Cursor.
namespace PriorityAgent;

public enum CliKind
{
    Grok,
    Cursor,
    OpenCode,
}

public sealed record CliDetectResult(CliKind Kind, bool Present, string? Path, string Reason);

public static class CliDetect
{
    public static string GrokExe(string userProfile) =>
        Path.Combine(userProfile, ".grok", "bin", "grok.exe");

    public static string GrokAgentExe(string userProfile) =>
        Path.Combine(userProfile, ".grok", "bin", "agent.exe");

    public static string CursorAgentCmd(string localAppData) =>
        Path.Combine(localAppData, "cursor-agent", "agent.cmd");

    public static string OpenCodeExe(string userProfile) =>
        Path.Combine(userProfile, ".opencode", "bin", "opencode.exe");

    public static CliDetectResult DetectGrok(string userProfile)
    {
        string path = GrokExe(userProfile);
        if (File.Exists(path))
            return new(CliKind.Grok, true, path, "grok.exe");
        return new(CliKind.Grok, false, null, "missing grok.exe under .grok\\bin");
    }

    public static CliDetectResult DetectCursor(string userProfile, string localAppData)
    {
        string grokAgent = GrokAgentExe(userProfile);
        string cmd = CursorAgentCmd(localAppData);
        if (File.Exists(cmd))
            return new(CliKind.Cursor, true, cmd, "cursor-agent\\agent.cmd");
        if (File.Exists(grokAgent))
            return new(CliKind.Cursor, false, null, "reject .grok\\bin\\agent.exe as Cursor");
        return new(CliKind.Cursor, false, null, "missing cursor-agent\\agent.cmd");
    }

    public static CliDetectResult DetectOpenCode(string userProfile)
    {
        string path = OpenCodeExe(userProfile);
        if (File.Exists(path))
            return new(CliKind.OpenCode, true, path, "opencode.exe");
        return new(CliKind.OpenCode, false, null, "missing .opencode\\bin\\opencode.exe");
    }
}
