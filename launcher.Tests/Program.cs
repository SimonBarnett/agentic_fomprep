using PriorityAgent;
using System.Diagnostics;
using System.Text;

var checks = new List<(string Name, Action Run)>
{
    ("project config overrides customer config", TestConfigPrecedence),
    ("CLI decisions override config", TestDecisionOverrides),
    ("console discovery filters and selects", TestConsoleSelection),
    ("unverified configured consoles retain airc; absent console disables it", TestDiscoveryFailure),
    ("airc=no renders no airc context", TestNoAircContext),
    ("airc=yes writes session-only skills and DCC", TestAircContext),
    ("realistic airc skills stay off the command line", TestCommandLineSize),
    ("published launcher dry runs preserve config and protect connection canaries", TestLauncherDryRuns),
    ("README documents unverified-console fallback, not live NAMES", TestReadmeAircDiscovery),
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
    finally { DeleteTempDirectory(root); }
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
    Assert(AircSupport.MachineFromConsole("name_console\n") == null, "console regex accepted a trailing newline");
    Assert(!AircSupport.MachineChannelsFromReport("""{"machines":{"name\n":{}}}""").Any(),
        "machine validation accepted a trailing newline");
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
    finally { DeleteTempDirectory(root); }
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
    finally { DeleteTempDirectory(root); }
}

static void TestLauncherDryRuns()
{
    string? launcherExe = Environment.GetEnvironmentVariable("PRIORITY_AGENT_TEST_EXE");
    string? fakeCli = Environment.GetEnvironmentVariable("PRIORITY_AGENT_TEST_CLI_DIR");
    if (string.IsNullOrWhiteSpace(launcherExe) || string.IsNullOrWhiteSpace(fakeCli))
    {
        Console.WriteLine("SKIP launcher integration tests (set PRIORITY_AGENT_TEST_EXE and PRIORITY_AGENT_TEST_CLI_DIR)");
        return;
    }

    string root = NewTemp();
    try
    {
        string cloneRoot = Path.Combine(root, "root");
        CreateClone(root, "SimonBarnett", "agentic_fomprep", Path.Combine(cloneRoot, "agentic_fomprep"),
            new Dictionary<string, string>
            {
                ["AGENTS.md"] = "# Test agent\n",
                ["launcher/agent-rules.md"] = "# Priority rules\n\n{{AIRC_SECTION}}\n",
                [".grok/skills/test/SKILL.md"] = "# Test skill\n",
            });
        CreateClone(root, "SimonBarnett", "fixture", Path.Combine(cloneRoot, "fixture"),
            new Dictionary<string, string> { ["SC263182/README.md"] = "# Integration project\n" });
        string aircFixture = Path.Combine(root, "airc");
        Directory.CreateDirectory(aircFixture);
        File.WriteAllText(Path.Combine(aircFixture, "bobiverse-airc-commands.md"), "# Commands skill\n");
        File.WriteAllText(Path.Combine(aircFixture, "bobiverse-airc.md"), "# Architecture skill\n");
        string cliRoot = Path.Combine(root, "cli");
        string ghDir = Path.Combine(cliRoot, "gh");
        string grokDir = Path.Combine(cliRoot, "grok");
        CopyFakeCli(fakeCli, ghDir, "gh.exe");
        CopyFakeCli(fakeCli, grokDir, "grok.exe");
        CopyGitExecutable(ghDir);

        string prioritySkills = Path.Combine(cloneRoot, "agentic_fomprep", ".grok", "skills").Replace('\\', '/');
        string original = $"[skills]\npaths = [\"{prioritySkills}\", \"C:/bobiverse/airc/.grok/skills\"]\n";
        const string canary = "do-not-read-or-print-this-canary";
        ScenarioResult noAirc;
        using (PrepareConnectionFile(root, canary))
            noAirc = RunLauncherScenario(root, launcherExe, cloneRoot, ghDir, grokDir, original, null, false);
        AssertScenarioClean(noAirc, canary, original, "airc=no");
        Assert(noAirc.Stdout.Contains("bobiverse airc skills path", StringComparison.OrdinalIgnoreCase),
            "airc=no did not print the global-config warning");
        Assert(noAirc.SessionRules.All(r => !r.Contains("bobiverse-airc", StringComparison.OrdinalIgnoreCase)
            && !r.Contains("DCCLISTEN", StringComparison.Ordinal)), "airc=no session contained airc guidance");

        ScenarioResult aircYes = RunLauncherScenario(root, launcherExe, cloneRoot, ghDir, grokDir, original,
            "--airc-console testbox_console", false);
        AssertScenarioClean(aircYes, canary, original, "airc=yes");
        Assert(aircYes.Stdout.Contains("console not verified", StringComparison.OrdinalIgnoreCase),
            "launcher did not explain that the configured console was unverified");
        Assert(aircYes.SessionRules.Length == 1
            && aircYes.SessionRules[0].Contains("selected from --airc-console and was not verified as connected", StringComparison.Ordinal)
            && aircYes.SessionRules[0].Contains("bobiverse-airc-commands", StringComparison.Ordinal)
            && aircYes.AircFiles.Select(File.ReadAllText).Any(f => f.Contains("DCCLISTEN", StringComparison.Ordinal)),
            "airc=yes did not write correctly sourced session-only airc rules");
        Assert(aircYes.AircFiles.Length == 3, "airc files were not confined to the session airc folder");

        ScenarioResult fetchFailure = RunLauncherScenario(root, launcherExe, cloneRoot, ghDir, grokDir, original,
            "--airc-console testbox_console", true);
        AssertScenarioClean(fetchFailure, canary, original, "airc skill fetch failure");
        Assert(fetchFailure.Stdout.Contains("airc: no (continuing without airc)", StringComparison.Ordinal),
            "non-interactive airc skill fetch failure did not continue without airc");
        Assert(fetchFailure.SessionRules.Length == 1
            && !fetchFailure.SessionRules[0].Contains("bobiverse-airc", StringComparison.OrdinalIgnoreCase),
            "failed airc skill fetch left airc instructions in session rules");
    }
    finally { DeleteTempDirectory(root); }
}

static void TestReadmeAircDiscovery()
{
    string readme = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "fixtures", "launcher-README.md"));
    Assert(readme.Contains("console not verified", StringComparison.Ordinal),
        "README must document the unverified configured-console fallback");
    Assert(!readme.Contains("then uses a read-only IRC `NAMES` lookup", StringComparison.Ordinal),
        "README numbered flow still claims a live NAMES picker that Discover() cannot perform");
}

static void TestDiscoveryFailure()
{
    string root = NewTemp();
    try
    {
        foreach (var discovery in new[]
        {
            AircConsoleDiscoveryResult.AvailableWith(Array.Empty<string>()),
            AircConsoleDiscoveryResult.Unavailable("IRC server requires authentication")
        })
        {
            bool configuredSelected = AircSupport.TrySelectListedConsole(true, discovery, "configured_console", null,
                false, null, out string? configuredConsole, out string configuredReason);
            Assert(configuredSelected && configuredConsole == "configured_console", "configured console was not trusted when listing was unavailable or empty");
            Assert(configuredReason.StartsWith("console not verified:", StringComparison.Ordinal), "configured console was not marked unverified");

            bool explicitSelected = AircSupport.TrySelectListedConsole(true, discovery, "configured_console", "explicit_console",
                false, null, out string? explicitConsole, out string explicitReason);
            Assert(explicitSelected && explicitConsole == "explicit_console", "CLI console override was not trusted when listing was unavailable or empty");
            Assert(explicitReason.StartsWith("console not verified:", StringComparison.Ordinal), "CLI console was not marked unverified");

            AircSessionFiles configuredFiles = AircSupport.WriteSessionFiles(Path.Combine(root, Guid.NewGuid().ToString("N")),
                new[] { "airc commands", "airc architecture" }, "DCCLISTEN for {{AIRC_CONSOLE}}", configuredConsole!);
            string configuredRules = AircSupport.RenderSessionRules(
                File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "fixtures", "agent-rules.md")),
                true, configuredConsole, "local fixture", configuredFiles,
                consoleVerified: false, consoleSource: ".priority-agent.json");
            Assert(configuredRules.Contains(configuredConsole!) && configuredRules.Contains(configuredFiles.DccGuide)
                && File.ReadAllText(configuredFiles.DccGuide).Contains(configuredConsole!),
                "configured console discovery fallback did not load airc session context");
            Assert(configuredRules.Contains("selected from .priority-agent.json and was not verified as connected", StringComparison.Ordinal)
                && !configuredRules.Contains("read-only IRC NAMES lookup", StringComparison.Ordinal),
                "unverified console provenance was described as a NAMES lookup");

            bool noneSelected = AircSupport.TrySelectListedConsole(true, discovery, null, null,
                false, null, out string? noneConsole, out string noConsoleReason);
            Assert(!noneSelected && noneConsole == null && !string.IsNullOrWhiteSpace(noConsoleReason),
                "airc should be disabled with a warning reason when discovery has no console and no nick is configured");
            string noAircRules = AircSupport.RenderSessionRules(
                File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "fixtures", "agent-rules.md")),
                false, null, "", null);
            Assert(!noAircRules.Contains("bobiverse-airc", StringComparison.OrdinalIgnoreCase)
                && !noAircRules.Contains("_console", StringComparison.OrdinalIgnoreCase)
                && !noAircRules.Contains("DCCLISTEN", StringComparison.Ordinal),
                "no-console fallback left airc instructions enabled");
        }
    }
    finally { DeleteTempDirectory(root); }
    Assert(!AircSupport.TrySelectListedConsole(true, AircConsoleDiscoveryResult.Unavailable("listing unavailable"),
        "bad nick", null, false, null, out _, out _), "invalid configured nick was trusted");
    Assert(!AircSupport.IsValidConsole("name_console PRIVMSG #channel"), "strict console validation accepted an injected suffix");
    var unavailable = AircConsoleDiscovery.Discover();
    Assert(!unavailable.Available && unavailable.Error.Contains("requires authentication", StringComparison.OrdinalIgnoreCase),
        "real discovery should explain why anonymous NAMES is unavailable");
}

static FileStream PrepareConnectionFile(string root, string canary)
{
    string passwords = Path.Combine(root, "passwords");
    Directory.CreateDirectory(passwords);
    var file = new FileStream(Path.Combine(passwords, "fixture-connections.txt"),
        FileMode.Create, FileAccess.ReadWrite, FileShare.None);
    byte[] content = Encoding.UTF8.GetBytes(canary);
    file.Write(content);
    file.Flush();
    return file;
}

static ScenarioResult RunLauncherScenario(string root, string launcherExe, string cloneRoot,
    string ghDir, string grokDir, string originalConfig, string? aircArgs, bool failSkillFetch)
{
    string scenario = Path.Combine(root, "scenario-" + Guid.NewGuid().ToString("N"));
    string home = Path.Combine(scenario, "home");
    string local = Path.Combine(scenario, "local");
    Directory.CreateDirectory(Path.Combine(home, ".grok"));
    Directory.CreateDirectory(local);
    string config = Path.Combine(home, ".grok", "config.toml");
    File.WriteAllText(config, originalConfig);
    var start = new ProcessStartInfo(launcherExe)
    {
        UseShellExecute = false,
        RedirectStandardOutput = true,
        RedirectStandardError = true,
        RedirectStandardInput = true,
        WorkingDirectory = cloneRoot,
    };
    foreach (string arg in new[]
    {
        "--dry-run", "--customer", "fixture", "--project", "SC263182", "--root", cloneRoot,
        "--passwords-dir", Path.Combine(root, "passwords"), "--no-pause", "--no-fuel-check",
    })
        start.ArgumentList.Add(arg);
    if (!string.IsNullOrWhiteSpace(aircArgs))
        foreach (string arg in aircArgs.Split(' ', StringSplitOptions.RemoveEmptyEntries)) start.ArgumentList.Add(arg);
    start.Environment["USERPROFILE"] = home;
    start.Environment["HOME"] = home;
    start.Environment["LOCALAPPDATA"] = local;
    start.Environment["XDG_DATA_HOME"] = local;
    start.Environment["PATH"] = string.Join(Path.PathSeparator, new[] { ghDir, grokDir, start.Environment["PATH"] ?? "" });
    start.Environment["PRIORITY_AGENT_TEST_GH"] = Path.Combine(ghDir, "gh.exe");
    start.Environment["PRIORITY_AGENT_TEST_GROK"] = Path.Combine(grokDir, "grok.exe");
    start.Environment["FAKE_GH_FAIL_SKILLS"] = failSkillFetch ? "1" : "0";
    start.Environment["FAKE_GROK_COMMAND"] = launcherExe + " --mcp-catalog";
    start.Environment["FAKE_AIRC_FIXTURE_DIR"] = Path.Combine(root, "airc");
    using Process process = Process.Start(start) ?? throw new InvalidOperationException("Could not start published launcher");
    Task<string> stdoutTask = process.StandardOutput.ReadToEndAsync();
    Task<string> stderrTask = process.StandardError.ReadToEndAsync();
    process.WaitForExit();
    string stdout = stdoutTask.GetAwaiter().GetResult();
    string stderr = stderrTask.GetAwaiter().GetResult();
    Assert(process.ExitCode == 0, $"published launcher dry run exited {process.ExitCode}: {stdout}\n{stderr}");

    string sessionsDir = Path.Combine(local, "PriorityAgent", "sessions");
    string[] sessionDirs = Directory.Exists(sessionsDir) ? Directory.GetDirectories(sessionsDir) : Array.Empty<string>();
    Assert(sessionDirs.Length == 1, $"expected one real launcher session, found {sessionDirs.Length}");
    string[] rules = sessionDirs.Select(d => File.ReadAllText(Path.Combine(d, "rules.md"))).ToArray();
    string[] metadata = sessionDirs.Select(d => File.ReadAllText(Path.Combine(d, "launch.json"))).ToArray();
    string[] aircFiles = Directory.Exists(Path.Combine(sessionDirs[0], "airc"))
        ? Directory.GetFiles(Path.Combine(sessionDirs[0], "airc"), "*", SearchOption.AllDirectories)
        : Array.Empty<string>();
    string logDir = Path.Combine(local, "PriorityAgent", "logs");
    string[] logs = Directory.Exists(logDir) ? Directory.GetFiles(logDir).Select(File.ReadAllText).ToArray() : Array.Empty<string>();
    return new ScenarioResult(stdout, stderr, File.ReadAllBytes(config), rules, metadata, aircFiles, logs);
}

static void AssertScenarioClean(ScenarioResult result, string canary, string originalConfig, string scenario)
{
    Assert(result.Config.SequenceEqual(Encoding.UTF8.GetBytes(originalConfig)),
        $"{scenario} changed config.toml");
    string[] artifacts = new[] { result.Stdout, result.Stderr }.Concat(result.SessionRules)
        .Concat(result.SessionMetadata).Concat(result.Logs).ToArray();
    Assert(artifacts.All(x => !x.Contains(canary, StringComparison.Ordinal)),
        $"{scenario} exposed the connection-file canary in output or launcher artifacts");
}

static void CopyFakeCli(string sourceDir, string destinationDir, string exeName)
{
    Directory.CreateDirectory(destinationDir);
    foreach (string file in Directory.GetFiles(sourceDir))
    {
        string name = Path.GetFileName(file);
        if (name.EndsWith(".exe", StringComparison.OrdinalIgnoreCase) || name.Equals("FakeCli", StringComparison.Ordinal))
            name = exeName;
        string destination = Path.Combine(destinationDir, name);
        File.Copy(file, destination, true);
        if (!OperatingSystem.IsWindows() && (name.EndsWith(".exe", StringComparison.OrdinalIgnoreCase) || name == exeName))
            File.SetUnixFileMode(destination, UnixFileMode.UserRead | UnixFileMode.UserWrite | UnixFileMode.UserExecute
                | UnixFileMode.GroupRead | UnixFileMode.GroupExecute | UnixFileMode.OtherRead | UnixFileMode.OtherExecute);
    }
}

static void CopyGitExecutable(string destinationDir)
{
    if (OperatingSystem.IsWindows()) return;
    foreach (string directory in (Environment.GetEnvironmentVariable("PATH") ?? "").Split(Path.PathSeparator))
    {
        string source = Path.Combine(directory.Trim('"'), "git");
        if (!File.Exists(source)) continue;
        string destination = Path.Combine(destinationDir, "git.exe");
        File.Copy(source, destination, true);
        if (!OperatingSystem.IsWindows())
            File.SetUnixFileMode(destination, UnixFileMode.UserRead | UnixFileMode.UserWrite | UnixFileMode.UserExecute
                | UnixFileMode.GroupRead | UnixFileMode.GroupExecute | UnixFileMode.OtherRead | UnixFileMode.OtherExecute);
        return;
    }
    throw new InvalidOperationException("Could not locate git for launcher integration test");
}

static void CreateClone(string root, string owner, string repo, string clonePath, Dictionary<string, string> files)
{
    string seed = Path.Combine(root, "seed", owner, repo);
    string remote = Path.Combine(root, "remote", owner, repo + ".git");
    Directory.CreateDirectory(seed);
    Directory.CreateDirectory(Path.GetDirectoryName(remote)!);
    RunGit(root, "init", "--bare", remote);
    RunGit(seed, "init", "-b", "main");
    RunGit(seed, "config", "user.email", "test@example.invalid");
    RunGit(seed, "config", "user.name", "Integration Test");
    foreach ((string path, string content) in files)
    {
        string target = Path.Combine(seed, path.Replace('/', Path.DirectorySeparatorChar));
        Directory.CreateDirectory(Path.GetDirectoryName(target)!);
        File.WriteAllText(target, content);
    }
    RunGit(seed, "add", ".");
    RunGit(seed, "commit", "-m", "fixture");
    RunGit(seed, "remote", "add", "origin", remote);
    RunGit(seed, "push", "-u", "origin", "main");
    RunGit(root, "--git-dir", remote, "symbolic-ref", "HEAD", "refs/heads/main");
    Directory.CreateDirectory(Path.GetDirectoryName(clonePath)!);
    RunGit(root, "clone", remote, clonePath);
    RunGit(clonePath, "remote", "set-url", "origin", Path.GetFullPath(remote).Replace('\\', '/'));
}

static void RunGit(string cwd, params string[] args)
{
    var start = new ProcessStartInfo("git")
    {
        WorkingDirectory = cwd,
        RedirectStandardOutput = true,
        RedirectStandardError = true,
    };
    foreach (string arg in args) start.ArgumentList.Add(arg);
    using Process process = Process.Start(start) ?? throw new InvalidOperationException("Could not start git");
    string stdout = process.StandardOutput.ReadToEnd();
    string stderr = process.StandardError.ReadToEnd();
    process.WaitForExit();
    if (process.ExitCode != 0) throw new InvalidOperationException($"git {string.Join(' ', args)} failed: {stdout}\n{stderr}");
}

static string NewTemp()
{
    string path = Path.Combine(Path.GetTempPath(), "priority-agent-tests-" + Guid.NewGuid().ToString("N"));
    Directory.CreateDirectory(path);
    return path;
}

static void DeleteTempDirectory(string path)
{
    try
    {
        if (!Directory.Exists(path)) return;
        foreach (string file in Directory.EnumerateFiles(path, "*", SearchOption.AllDirectories))
        {
            try { File.SetAttributes(file, File.GetAttributes(file) & ~FileAttributes.ReadOnly); }
            catch (Exception ex) { Console.Error.WriteLine($"WARN cleanup attributes for {file}: {ex.Message}"); }
        }
        foreach (string directory in Directory.EnumerateDirectories(path, "*", SearchOption.AllDirectories))
        {
            try { File.SetAttributes(directory, File.GetAttributes(directory) & ~FileAttributes.ReadOnly); }
            catch (Exception ex) { Console.Error.WriteLine($"WARN cleanup attributes for {directory}: {ex.Message}"); }
        }
        Directory.Delete(path, true);
    }
    catch (Exception ex)
    {
        Console.Error.WriteLine($"WARN cleanup {path}: {ex.Message}");
    }
}

static void Assert(bool condition, string message)
{
    if (!condition) throw new InvalidOperationException(message);
}

sealed record ScenarioResult(string Stdout, string Stderr, byte[] Config, string[] SessionRules,
    string[] SessionMetadata, string[] AircFiles, string[] Logs);
