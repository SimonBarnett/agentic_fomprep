using PriorityAgent;

var checks = new List<(string Name, Action Run)>
{
    ("project config overrides customer config", TestConfigPrecedence),
    ("CLI decisions override config", TestDecisionOverrides),
    ("console discovery filters and selects", TestConsoleSelection),
    ("airc=no renders no airc context", TestNoAircContext),
    ("airc=yes renders skills and DCC", TestAircContext),
    ("password file check does not disclose contents", TestPasswordCanary),
};

int failures = 0;
foreach (var (name, run) in checks)
{
    try { run(); Console.WriteLine($"PASS {name}"); }
    catch (Exception ex) { failures++; Console.Error.WriteLine($"FAIL {name}: {ex.Message}"); }
}
return failures == 0 ? 0 : 1;

static void TestConfigPrecedence()
{
    string root = NewTemp();
    try
    {
        string customer = Path.Combine(root, "customer"), project = Path.Combine(customer, "project");
        Directory.CreateDirectory(project);
        File.WriteAllText(Path.Combine(customer, ".priority-agent.json"), """{"airc":true,"airc_console":"flamingo_console"}""");
        File.WriteAllText(Path.Combine(project, ".priority-agent.json"), """{"airc":false}""");
        AircConfig config = AircSupport.LoadConfig(project, customer);
        Assert(config.Enabled == false, "project airc value did not override customer");
        Assert(config.Console == "flamingo_console", "customer console should be inherited when project omits it");
        Assert(config.EnabledSource == Path.Combine(project, ".priority-agent.json"), "wrong airc config source");
        Assert(config.ConsoleSource == Path.Combine(customer, ".priority-agent.json"), "wrong console config source");
    }
    finally { Directory.Delete(root, true); }
}

static void TestDecisionOverrides()
{
    Assert(!AircSupport.ResolveEnabled(false, false, true, false, null), "--no-airc did not override config");
    Assert(AircSupport.ResolveEnabled(true, false, false, false, null), "--airc did not override config");
    Assert(AircSupport.ResolveEnabled(null, true, false, false, null), "--airc-console did not enable airc");
    Assert(!AircSupport.ResolveEnabled(null, false, null, false, null), "non-interactive default should be no");
    Assert(!AircSupport.ResolveEnabled(null, false, false, false, null), "non-interactive false config was ignored");
    Assert(AircSupport.ResolveEnabled(null, false, true, false, null), "non-interactive config default was ignored");
    Assert(!AircSupport.ResolveEnabled(null, false, true, true, configured => false), "interactive prompt could not override config");
    Assert(AircSupport.ResolveEnabled(null, false, false, true, configured => true), "interactive prompt could not opt in over config");
}

static void TestConsoleSelection()
{
    var consoles = AircSupport.NormalizeConsoles(new[] { "@flamingo_console", "win-mpre8vi4u6u_console", "user_consolex", "flamingo_console" });
    Assert(consoles.SequenceEqual(new[] { "flamingo_console", "win-mpre8vi4u6u_console" }), "invalid or duplicate console was included");
    string? selected = AircSupport.ChooseConsole(consoles, "win-mpre8vi4u6u_console", null, false, null);
    Assert(selected == "win-mpre8vi4u6u_console", "configured connected console was not preselected");
    selected = AircSupport.ChooseConsole(consoles, "win-mpre8vi4u6u_console", null, true,
        (available, preferred) => available.Contains(preferred!) ? "flamingo_console" : null);
    Assert(selected == "flamingo_console", "interactive selection could not override the preselection");
    selected = AircSupport.ChooseConsole(consoles, null, "flamingo_console", false, null);
    Assert(selected == "flamingo_console", "CLI console override was not selected");
    Assert(AircSupport.ChooseConsole(Array.Empty<string>(), null, null, false, null) == null, "empty list selected a console");
    Assert(AircSupport.MachineFromConsole("flamingo_console") == "flamingo", "machine id extraction failed");
    Assert(AircSupport.MachineChannelsFromReport("""{"machines":{"flamingo":{},"bad/name":{},"win-mpre8vi4u6u":{}}}""")
        .SequenceEqual(new[] { "#flamingo", "#win-mpre8vi4u6u" }), "report machine channels were not validated");
    var names = AircSupport.ConsolesFromNames(new[]
    {
        ":irc 353 test = #wonderland :@flamingo_console +visitor",
        ":irc 353 test = #flamingo :win-mpre8vi4u6u_console",
    });
    Assert(names.SequenceEqual(new[] { "flamingo_console", "win-mpre8vi4u6u_console" }), "IRC NAMES parser failed");
}

static void TestNoAircContext()
{
    string template = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "fixtures", "agent-rules.md"));
    string rendered = AircSupport.RenderSessionRules(template, false, null, "", "", "");
    Assert(rendered.Contains("Priority agent rules") && rendered.Contains("Harvest rule"), "non-airc template content missing");
    Assert(!rendered.Contains("bobiverse-airc", StringComparison.OrdinalIgnoreCase), "airc skills appeared when disabled");
    Assert(!rendered.Contains("_console", StringComparison.OrdinalIgnoreCase), "console instructions appeared when disabled");
    Assert(!rendered.Contains("DCCLISTEN", StringComparison.Ordinal), "DCC instructions appeared when disabled");
}

static void TestAircContext()
{
    string fixtureRoot = Path.Combine(AppContext.BaseDirectory, "fixtures");
    string commands = File.ReadAllText(Path.Combine(fixtureRoot, "bobiverse-airc-commands", "SKILL.md"));
    string architecture = File.ReadAllText(Path.Combine(fixtureRoot, "bobiverse-airc", "SKILL.md"));
    string dcc = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "fixtures", "airc-dcc.md"));
    string rendered = AircSupport.RenderSessionRules("{{AIRC_SECTION}}", true, "testbox_console", "GitHub @ test-sha",
        commands + Environment.NewLine + architecture, dcc);
    Assert(rendered.Contains(commands) && rendered.Contains(architecture), "both airc skill fixtures were not loaded");
    Assert(rendered.Contains("testbox_console") && rendered.Contains("#testbox"), "chosen console placeholders were not rendered");
    Assert(rendered.Contains("bobiverse-airc-troubleshooting/SKILL.md"), "troubleshooting path reference missing");
    Assert(!rendered.Contains("Fixture troubleshooting content"), "troubleshooting content should not be loaded");
    Assert(rendered.Contains("DCCLISTEN") && rendered.Contains("tls=1") && rendered.Contains("via=dcc")
        && rendered.Contains("Test-AircDccDoneSha256") && rendered.Contains("falling back to IRC"), "DCC instructions missing");
    Assert(rendered.Contains("DCCLISTEN") && rendered.Contains("testbox_console") && !rendered.Contains("{{AIRC_CONSOLE}}"),
        "DCC instructions were not targeted to the selected console");
}

static void TestPasswordCanary()
{
    string root = NewTemp();
    try
    {
        string path = Path.Combine(root, "customer-connections.txt");
        const string canary = "do-not-read-or-print-this-canary";
        File.WriteAllText(path, canary);
        var old = Console.Out;
        using var output = new StringWriter();
        bool exists;
        try
        {
            Console.SetOut(output);
            exists = AircSupport.ConnectionFileExists(path);
        }
        finally { Console.SetOut(old); }
        Assert(exists, "connection file existence check failed");
        Assert(!output.ToString().Contains(canary, StringComparison.Ordinal), "connection file content was disclosed");
    }
    finally { Directory.Delete(root, true); }
}

static string NewTemp()
{
    string path = Path.Combine(Path.GetTempPath(), "priority-agent-tests-" + Guid.NewGuid().ToString("N"));
    Directory.CreateDirectory(path);
    return path;
}

static void Assert(bool condition, string message)
{
    if (!condition) throw new InvalidOperationException(message);
}
