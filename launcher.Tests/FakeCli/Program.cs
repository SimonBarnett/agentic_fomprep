using System.Text;

string executable = Path.GetFileNameWithoutExtension(Environment.ProcessPath ?? "");
string[] argv = Environment.GetCommandLineArgs().Skip(1).ToArray();
if (executable.Equals("gh", StringComparison.OrdinalIgnoreCase))
{
    if (argv.Contains("user/repos?affiliation=owner&per_page=100"))
    {
        Console.WriteLine("fixture\tSimonBarnett/fixture\tmain\tlauncher integration fixture");
        return 0;
    }
    if (argv.Any(a => a.StartsWith("repos/SimonBarnett/bobiverse/contents/", StringComparison.Ordinal)))
    {
        if (Environment.GetEnvironmentVariable("FAKE_GH_FAIL_SKILLS") == "1") return 1;
        string endpoint = argv.First(a => a.StartsWith("repos/SimonBarnett/bobiverse/contents/", StringComparison.Ordinal));
        string name = endpoint.Contains("bobiverse-airc-commands", StringComparison.Ordinal)
            ? "bobiverse-airc-commands.md" : "bobiverse-airc.md";
        string content = File.ReadAllText(Path.Combine(
            Environment.GetEnvironmentVariable("FAKE_AIRC_FIXTURE_DIR")!, name));
        Console.WriteLine(Convert.ToBase64String(Encoding.UTF8.GetBytes(content)));
        return 0;
    }
    return 1;
}

if (executable.Equals("grok", StringComparison.OrdinalIgnoreCase)
    && argv.SequenceEqual(new[] { "mcp", "list" }))
{
    Console.WriteLine("priority-catalog: " + Environment.GetEnvironmentVariable("FAKE_GROK_COMMAND"));
    return 0;
}
if (executable.Equals("grok", StringComparison.OrdinalIgnoreCase)
    && argv.SequenceEqual(new[] { "mcp", "doctor", "priority-catalog" }))
{
    Console.WriteLine("priority-catalog (stdio)\nhandshake OK");
    return 0;
}

return 1;
