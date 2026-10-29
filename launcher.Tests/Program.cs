using PriorityAgent;

var checks = new List<(string Name, Action Run)>
{
    ("project config overrides customer config", TestConfigPrecedence),
    ("CLI decisions override config", TestDecisionOverrides),
    ("console discovery filters and selects", TestConsoleSelection),
    ("unavailable or empty discovery safely disables airc context", TestDiscoveryFailure),
    ("airc=no renders no airc context", TestNoAircContext),
    ("airc=yes writes session-only skills and DCC", TestAircContext),
    ("realistic airc skills stay off the command line", TestCommandLineSize),
    ("airc session setup does not mutate Grok config", TestGlobalConfigUnchanged),
    ("password canary stays out of launch artifacts", TestPasswordCanary),
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
    string rendered = AircSupport.RenderSessionRules(template, false, null, "", null);
    Assert(rendered.Contains("Priority agent rules") && rendered.Contains("Harvest rule"), "non-airc template content missing");
    Assert(!rendered.Contains("bobiverse-airc", StringComparison.OrdinalIgnoreCase), "airc skills appeared when disabled");
    Assert(!rendered.Contains("_console", StringComparison.OrdinalIgnoreCase), "console instructions appeared when disabled");
    Assert(!rendered.Contains("DCCLISTEN", StringComparison.Ordinal), "DCC instructions appeared when disabled");
}

static void TestAircContext()
{
    string root = NewTemp();
    try
    {
        string fixtureRoot = Path.Combine(AppContext.BaseDirectory, "fixtures");
        string commands = File.ReadAllText(Path.Combine(fixtureRoot, "bobiverse-airc-commands", "SKILL.md"));
        string architecture = File.ReadAllText(Path.Combine(fixtureRoot, "bobiverse-airc", "SKILL.md"));
        string dcc = File.ReadAllText(Path.Combine(fixtureRoot, "airc-dcc.md"));
        AircSessionFiles files = AircSupport.WriteSessionFiles(root, new[] { commands, architecture }, dcc, "testbox_console");
        string rendered = AircSupport.RenderSessionRules("{{AIRC_SECTION}}", true, "testbox_console", "GitHub @ test-sha", files);
        Assert(File.ReadAllText(files.CommandsSkill) == commands && File.ReadAllText(files.ArchitectureSkill) == architecture,
            "both airc skill files were not written");
        Assert(rendered.Contains(files.CommandsSkill) && rendered.Contains(files.ArchitectureSkill)
            && rendered.Contains(files.DccGuide), "session rule paths were not included");
        string renderedDcc = File.ReadAllText(files.DccGuide);
        Assert(renderedDcc.Contains("DCCLISTEN") && renderedDcc.Contains("testbox_console"), "DCC guidance was not targeted");
        Assert(!rendered.Contains("Fixture troubleshooting content"), "troubleshooting content should not be loaded");
        Assert(rendered.Contains("bobiverse-airc-troubleshooting/SKILL.md"), "troubleshooting path reference missing");
    }
    finally { Directory.Delete(root, true); }
}

static void TestCommandLineSize()
{
    string root = NewTemp();
    try
    {
        string commands = "# bobiverse-airc-commands\n" + string.Concat(Enumerable.Repeat("Remote command protocol and safe diagnostics. ", 260));
        string architecture = "# bobiverse-airc\n" + string.Concat(Enumerable.Repeat("Console architecture and channel operations. ", 260));
        Assert(commands.Length + architecture.Length >= 23_000, "large skill fixtures must total at least 23 KB");
        string dcc = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "fixtures", "airc-dcc.md"));
        AircSessionFiles files = AircSupport.WriteSessionFiles(root, new[] { commands, architecture }, dcc, "testbox_console");
        string rules = AircSupport.RenderSessionRules(
            File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "fixtures", "agent-rules.md")),
            true, "testbox_console", "GitHub @ test-sha", files);
        var args = AircSupport.BuildGrokArguments(root, Guid.NewGuid().ToString(), rules,
            "Priority session with airc context " + new string('x', 500), false);
        int length = AircSupport.WindowsCommandLineLength("C:\\Program Files\\Grok\\grok.exe", args);
        Assert(length < 32_000, $"assembled command line is {length} characters");
        bool rejectedOversize = false;
        try { AircSupport.ValidateWindowsCommandLine("grok.exe", new[] { new string('x', 32_001) }, "test launch"); }
        catch (InvalidOperationException ex) { rejectedOversize = ex.Message.Contains("test launch command line", StringComparison.Ordinal); }
        Assert(rejectedOversize, "oversized command line did not fail clearly");
        Assert(!args.Contains(commands) && !args.Contains(architecture), "large airc skill text was passed on argv");
        Assert(File.ReadAllText(files.CommandsSkill).Length + File.ReadAllText(files.ArchitectureSkill).Length >= 23_000,
            "large skill files were not written in full");
    }
    finally { Directory.Delete(root, true); }
}

static void TestGlobalConfigUnchanged()
{
    string root = NewTemp();
    string? oldHome = Environment.GetEnvironmentVariable("HOME");
    string? oldUserProfile = Environment.GetEnvironmentVariable("USERPROFILE");
    try
    {
        string home = Path.Combine(root, "home");
        Directory.CreateDirectory(Path.Combine(home, ".grok"));
        Environment.SetEnvironmentVariable("HOME", home);
        Environment.SetEnvironmentVariable("USERPROFILE", home);
        string config = Path.Combine(home, ".grok", "config.toml");
        const string original = "[skills]\npaths = [\"C:/existing/skills\"]\n";
        File.WriteAllText(config, original);
        string fixtureRoot = Path.Combine(AppContext.BaseDirectory, "fixtures");
        string commands = File.ReadAllText(Path.Combine(fixtureRoot, "bobiverse-airc-commands", "SKILL.md"));
        string architecture = File.ReadAllText(Path.Combine(fixtureRoot, "bobiverse-airc", "SKILL.md"));
        string dcc = File.ReadAllText(Path.Combine(fixtureRoot, "airc-dcc.md"));
        string template = File.ReadAllText(Path.Combine(fixtureRoot, "agent-rules.md"));
        _ = AircSupport.RenderSessionRules(template, false, null, "", null);
        AircSessionFiles files = AircSupport.WriteSessionFiles(Path.Combine(root, "airc-yes"),
            new[] { commands, architecture }, dcc, "testbox_console");
        _ = AircSupport.RenderSessionRules(template, true, "testbox_console", "GitHub @ sha", files);
        Assert(File.ReadAllText(config) == original, "airc session generation changed global config.toml");
    }
    finally
    {
        Environment.SetEnvironmentVariable("HOME", oldHome);
        Environment.SetEnvironmentVariable("USERPROFILE", oldUserProfile);
        Directory.Delete(root, true);
    }
}

static void TestDiscoveryFailure()
{
    foreach (var discovery in new[]
    {
        AircConsoleDiscoveryResult.AvailableWith(Array.Empty<string>()),
        AircConsoleDiscoveryResult.Unavailable("IRC server requires authentication")
    })
    {
        bool selected = AircSupport.TrySelectListedConsole(true, discovery, "configured_console", "explicit_console",
            false, null, out string? console, out string reason);
        Assert(!selected && console == null, "unlisted explicit/configured console was accepted");
        Assert(!string.IsNullOrWhiteSpace(reason), "discovery failure reason was omitted");
        string rules = AircSupport.RenderSessionRules(
            File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "fixtures", "agent-rules.md")),
            false, null, "", null);
        Assert(!rules.Contains("bobiverse-airc", StringComparison.OrdinalIgnoreCase)
            && !rules.Contains("_console", StringComparison.OrdinalIgnoreCase)
            && !rules.Contains("DCCLISTEN", StringComparison.Ordinal), "failed discovery left airc instructions enabled");
    }
    var unavailable = AircConsoleDiscovery.Discover();
    Assert(!unavailable.Available && unavailable.Error.Contains("requires authentication", StringComparison.OrdinalIgnoreCase),
        "real discovery should explain why anonymous NAMES is unavailable");
}

static void TestPasswordCanary()
{
    string root = NewTemp();
    try
    {
        string path = Path.Combine(root, "customer-connections.txt");
        const string canary = "do-not-read-or-print-this-canary";
        File.WriteAllText(path, canary);
        var stdout = new StringWriter();
        var stderr = new StringWriter();
        var oldOut = Console.Out;
        var oldError = Console.Error;
        string rules = AircSupport.RenderSessionRules(
            File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "fixtures", "agent-rules.md")),
            false, null, "", null);
        string sessionDirectory = Path.Combine(root, "sessions", Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(sessionDirectory);
        string rulesPath = Path.Combine(sessionDirectory, "rules.md");
        string launchPath = Path.Combine(sessionDirectory, "launch.json");
        string logPath = Path.Combine(root, "launcher.log");
        try
        {
            using var locked = new FileStream(path, FileMode.Open, FileAccess.ReadWrite, FileShare.None);
            Console.SetOut(stdout);
            Console.SetError(stderr);
            bool exists = AircSupport.ConnectionFileExists(path);
            Assert(exists, "connection file existence check failed");
            string status = AircSupport.ConnectionFileStatus("customer", path, exists);
            Console.WriteLine(status);
            AircSupport.WriteSessionMetadata(sessionDirectory, rules, new { connectionFile = path, airc = false });
            File.WriteAllText(logPath, stdout.ToString());
        }
        finally { Console.SetOut(oldOut); Console.SetError(oldError); }
        var artifacts = new[] { stdout.ToString(), stderr.ToString(), File.ReadAllText(rulesPath),
            File.ReadAllText(launchPath), File.ReadAllText(logPath) };
        Assert(artifacts.All(x => !x.Contains(canary, StringComparison.Ordinal)),
            "connection canary appeared in output or launch artifacts");
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
