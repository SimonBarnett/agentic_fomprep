namespace PriorityAgent;

/// <summary>Shared launcher helpers (command line, connections status, session files).</summary>
public static class LauncherSupport
{
    public const int MaxWindowsCommandLineLength = 32_000;

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
