using PriorityAgent;
using System.Text;
using System.Text.Json;
using System.Text.RegularExpressions;

var checks = new List<(string Name, Action Run)>
{
    ("project wcf overrides customer; legacy airc warns", TestWcfConfigPrecedenceAndLegacy),
    ("direct and relay modes load and render", TestDirectAndRelayModes),
    ("session instances file has no secrets", TestSessionInstancesNoSecrets),
    ("airc source files and template are gone", TestAircFilesGone),
    ("README documents WCF client only", TestReadmeWcfOnly),
    ("agent-rules use WCF_SECTION not AIRC_SECTION", TestAgentRulesWcfPlaceholder),
    ("command line size guard still works", TestCommandLineSize),
    ("dirty clone plus stub uses the dirty clone", TestDirtyClonePreferredOverStub),
    ("dirty clone only is usable", TestDirtyCloneOnly),
    ("no real clone lists every rejected candidate", TestNoRealCloneFatalListsCandidates),
    ("AI root prefers existing C:\\AI over later drives", TestAiRootPrefersExistingC),
    ("AI root skips missing D: and creates on first ready drive", TestAiRootCreatesOnFirstReady),
    ("AI root search lists AI and repos across ready drives", TestAiRootBuildSearchRoots),
};

int failures = 0;
foreach (var (name, run) in checks)
{
    try { run(); Console.WriteLine($"PASS {name}"); }
    catch (Exception ex) { failures++; Console.Error.WriteLine($"FAIL {name}: {ex.Message}"); }
}
return failures == 0 ? 0 : 1;

static void TestWcfConfigPrecedenceAndLegacy()
{
    string root = NewTemp();
    try
    {
        string customer = Path.Combine(root, "customer"), project = Path.Combine(customer, "project");
        Directory.CreateDirectory(project);
        File.WriteAllText(Path.Combine(customer, ".priority-agent.json"),
            """{"airc":true,"airc_console":"flamingo_console","wcf":[{"id":"cust","serverUrl":"https://cust.example.invalid","mode":"direct"}]}""");
        File.WriteAllText(Path.Combine(project, ".priority-agent.json"),
            """{"airc":false,"wcf":[{"id":"proj","serverUrl":"https://proj.example.invalid","mode":"relay"}]}""");
        WcfConfig config = WcfSupport.LoadConfig(project, customer);
        Assert(config.Instances.Count == 1 && config.Instances[0].Id == "proj", "project wcf must replace customer");
        Assert(config.Instances[0].Mode == "relay", "project relay mode lost");
        Assert(config.LegacyAircWarnings.Count >= 1, "legacy airc fields must warn");
        Assert(config.LegacyAircWarnings.Any(w => w.Contains("ignored", StringComparison.OrdinalIgnoreCase)),
            "legacy warning must say ignored");

        // Customer-only with legacy keys still loads and warns; does not enable airc anything.
        WcfConfig customerOnly = WcfSupport.LoadConfig(null, customer);
        Assert(customerOnly.Instances.Count == 1 && customerOnly.Instances[0].Id == "cust", "customer wcf lost");
        Assert(customerOnly.LegacyAircWarnings.Count >= 1, "customer legacy airc must warn");
    }
    finally { DeleteTempDirectory(root); }
}

static void TestDirectAndRelayModes()
{
    string root = NewTemp();
    try
    {
        string dir = Path.Combine(root, "cust");
        Directory.CreateDirectory(dir);
        File.WriteAllText(Path.Combine(dir, ".priority-agent.json"), """
            {
              "wcf": [
                { "id": "saas", "serverUrl": "https://prioritydev.example.invalid/", "mode": "direct" },
                { "id": "hrs", "url": "http://priority.lan.example.invalid", "mode": "relay" },
                { "id": "bad", "serverUrl": "ftp://nope.example.invalid", "mode": "direct" },
                { "id": "badmode", "serverUrl": "https://ok.example.invalid", "mode": "warp" }
              ]
            }
            """);
        WcfConfig config = WcfSupport.LoadConfig(null, dir);
        Assert(config.Instances.Count == 3, $"expected 3 valid instances, got {config.Instances.Count}");
        Assert(config.Instances.Any(i => i.Id == "saas" && i.Mode == "direct"
            && i.ServerUrl == "https://prioritydev.example.invalid"), "direct instance wrong");
        Assert(config.Instances.Any(i => i.Id == "hrs" && i.Mode == "relay"), "relay instance wrong");
        Assert(config.Instances.Any(i => i.Id == "badmode" && i.Mode == "direct"), "bad mode must fall back to direct");

        string file = WcfSupport.WriteSessionInstancesFile(root, config.Instances);
        string rules = WcfSupport.RenderSessionRules("before{{WCF_SECTION}}after", config.Instances, file);
        Assert(rules.Contains("Priority WCF client", StringComparison.Ordinal)
            && rules.Contains("mode=`direct`", StringComparison.Ordinal)
            && rules.Contains("mode=`relay`", StringComparison.Ordinal)
            && rules.Contains("priority_wcf.py", StringComparison.Ordinal)
            && rules.Contains("WINRUN", StringComparison.Ordinal)
            && rules.Contains("OData", StringComparison.Ordinal)
            && !rules.Contains("DCCLISTEN", StringComparison.Ordinal)
            && !rules.Contains("{{WCF_SECTION}}", StringComparison.Ordinal)
            && !rules.Contains("{{AIRC_SECTION}}", StringComparison.Ordinal),
            "rules must cover WCF direct/relay and forbid old paths");
        Assert(rules.StartsWith("before", StringComparison.Ordinal) && rules.EndsWith("after", StringComparison.Ordinal),
            "template bookends lost");
    }
    finally { DeleteTempDirectory(root); }
}

static void TestSessionInstancesNoSecrets()
{
    string root = NewTemp();
    try
    {
        var instances = new[]
        {
            new WcfInstance("dev", "https://prioritydev.example.invalid", "direct"),
        };
        string path = WcfSupport.WriteSessionInstancesFile(root, instances);
        string text = File.ReadAllText(path);
        Assert(!Regex.IsMatch(text, @"password|credentialTarget|Bearer\s+[A-Za-z0-9_-]{20,}|secret",
            RegexOptions.IgnoreCase), "session wcf file must not look like secrets");
        using var doc = JsonDocument.Parse(text);
        Assert(doc.RootElement.GetProperty("instances")[0].GetProperty("serverUrl").GetString()
            == "https://prioritydev.example.invalid", "serverUrl missing from session file");
        Assert(doc.RootElement.GetProperty("instances")[0].GetProperty("mode").GetString() == "direct",
            "mode missing from session file");
    }
    finally { DeleteTempDirectory(root); }
}

static void TestAircFilesGone()
{
    string launcherDir = Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..", "launcher"));
    if (!Directory.Exists(launcherDir))
        launcherDir = Path.GetFullPath(Path.Combine(Directory.GetCurrentDirectory(), "launcher"));
    Assert(Directory.Exists(launcherDir), $"launcher dir not found near tests ({launcherDir})");
    Assert(WcfSupport.AircSourceFilesGone(launcherDir),
        "AircSupport.cs / AircConsoleDiscovery.cs / airc-dcc.md must be removed from launcher/");
    Assert(!File.Exists(Path.Combine(launcherDir, "AircSupport.cs")), "AircSupport.cs still present");
    Assert(File.Exists(Path.Combine(launcherDir, "WcfSupport.cs")), "WcfSupport.cs missing");
}

static void TestReadmeWcfOnly()
{
    string readme = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "fixtures", "launcher-README.md"));
    Assert(readme.Contains("WCF", StringComparison.Ordinal) && readme.Contains("priority_wcf", StringComparison.OrdinalIgnoreCase)
        || readme.Contains("serverUrl", StringComparison.Ordinal),
        "README must document WCF serverUrl / client");
    Assert(readme.Contains("\"mode\": \"direct\"", StringComparison.Ordinal)
        && readme.Contains("\"mode\": \"relay\"", StringComparison.Ordinal),
        "README must show direct and relay examples");
    Assert(!readme.Contains("airc_consoles", StringComparison.Ordinal)
        && !readme.Contains("Does this session need airc", StringComparison.Ordinal)
        && !readme.Contains("bobiverse-airc-commands", StringComparison.Ordinal),
        "README must not document the old airc discovery / session skills path");
    Assert(readme.Contains("removed", StringComparison.OrdinalIgnoreCase)
        || readme.Contains("ignored", StringComparison.OrdinalIgnoreCase),
        "README should mention legacy airc ignore / removed flags");
}

static void TestAgentRulesWcfPlaceholder()
{
    string rules = File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "fixtures", "agent-rules.md"));
    Assert(rules.Contains("{{WCF_SECTION}}", StringComparison.Ordinal), "agent-rules need {{WCF_SECTION}}");
    Assert(!rules.Contains("{{AIRC_SECTION}}", StringComparison.Ordinal), "agent-rules must drop {{AIRC_SECTION}}");
    Assert(Regex.IsMatch(rules, @"rules-version:\s*(\d+)")
        && int.Parse(Regex.Match(rules, @"rules-version:\s*(\d+)").Groups[1].Value) >= 7,
        "rules-version must bump with WCF section");
}

static void TestCommandLineSize()
{
    string root = NewTemp();
    try
    {
        string rules = WcfSupport.RenderSessionRules("{{WCF_SECTION}}",
            new[] { new WcfInstance("dev", "https://prioritydev.example.invalid", "direct") },
            Path.Combine(root, "wcf-instances.json"));
        var args = LauncherSupport.BuildGrokArguments(root, Guid.NewGuid().ToString(), rules,
            "Priority session " + new string('x', 500), false);
        int length = LauncherSupport.WindowsCommandLineLength("C:\\Program Files\\Grok\\grok.exe", args);
        Assert(length < LauncherSupport.MaxWindowsCommandLineLength, "WCF rules blew the argv budget");
        try { LauncherSupport.ValidateWindowsCommandLine("grok.exe", new[] { new string('x', 32_001) }, "test launch"); Assert(false, "expected throw"); }
        catch (InvalidOperationException) { /* expected */ }
    }
    finally { DeleteTempDirectory(root); }
}

static void TestDirtyClonePreferredOverStub()
{
    var sightings = new[]
    {
        new CloneSighting(@"D:\ai\agentic_fomprep", CloneKind.Stub),
        new CloneSighting(@"C:\ai\agentic_fomprep", CloneKind.Dirty),
    };
    string? chosen = CloneResolve.SelectUsable(sightings, out string? reason);
    Assert(chosen == @"C:\ai\agentic_fomprep", "dirty real clone should win over an empty stub");
    Assert(reason != null && reason.Contains("dirty", StringComparison.OrdinalIgnoreCase), "reason should say dirty / skip pull");
}

static void TestDirtyCloneOnly()
{
    var sightings = new[] { new CloneSighting(@"C:\ai\agentic_fomprep", CloneKind.Dirty) };
    string? chosen = CloneResolve.SelectUsable(sightings, out string? reason);
    Assert(chosen == @"C:\ai\agentic_fomprep", "lone dirty clone must be usable");
    Assert(reason != null && reason.Contains("skip pull", StringComparison.OrdinalIgnoreCase), "dirty clone must skip pull");
}

static void TestNoRealCloneFatalListsCandidates()
{
    var sightings = new[]
    {
        new CloneSighting(@"D:\ai\agentic_fomprep", CloneKind.Stub),
        new CloneSighting(@"C:\ai\agentic_fomprep", CloneKind.Missing),
        new CloneSighting(@"D:\repos\agentic_fomprep", CloneKind.WrongOrigin),
    };
    Assert(CloneResolve.SelectUsable(sightings, out _) == null, "no usable clone should be selected");
    string fatal = CloneResolve.FatalUnavailable("SimonBarnett/agentic_fomprep", sightings);
    Assert(fatal.Contains("empty stub", StringComparison.OrdinalIgnoreCase)
        && fatal.Contains("missing", StringComparison.OrdinalIgnoreCase)
        && fatal.Contains("origin is not this repo", StringComparison.OrdinalIgnoreCase)
        && fatal.Contains("D:\\ai\\agentic_fomprep", StringComparison.Ordinal)
        && fatal.Contains("C:\\ai\\agentic_fomprep", StringComparison.Ordinal),
        "FATAL must name every candidate and why it was rejected");
}

static void TestAiRootPrefersExistingC()
{
    var existing = new HashSet<string>(StringComparer.OrdinalIgnoreCase) { @"C:\AI" };
    string created = "";
    string root = AiRoot.Resolve(
        driveReady: c => c is 'C' or 'E',
        exists: p => existing.Contains(p),
        create: p => created = p);
    Assert(string.Equals(root, Path.GetFullPath(@"C:\AI"), StringComparison.OrdinalIgnoreCase),
        "should prefer existing C:\\AI when C and E are ready and D is missing");
    Assert(created == "", "must not create when an AI root already exists");
}

static void TestAiRootCreatesOnFirstReady()
{
    string created = "";
    string root = AiRoot.Resolve(
        driveReady: c => c is 'C' or 'E',
        exists: _ => false,
        create: p => created = p);
    Assert(string.Equals(created, @"C:\AI", StringComparison.OrdinalIgnoreCase),
        "with no existing AI folder, create on first ready drive (C) even when E also exists");
    Assert(string.Equals(root, Path.GetFullPath(@"C:\AI"), StringComparison.OrdinalIgnoreCase),
        "resolved root should be C:\\AI");
}

static void TestAiRootBuildSearchRoots()
{
    string[] roots = AiRoot.BuildSearchRoots(
        @"C:\AI",
        driveReady: c => c is 'C' or 'E',
        exists: p => p.Equals(@"C:\AI", StringComparison.OrdinalIgnoreCase)
            || p.Equals(@"E:\AI", StringComparison.OrdinalIgnoreCase)
            || p.Equals(@"E:\repos", StringComparison.OrdinalIgnoreCase));
    Assert(roots.Length >= 3, "expected preferred + E:\\AI + E:\\repos");
    Assert(string.Equals(roots[0], Path.GetFullPath(@"C:\AI"), StringComparison.OrdinalIgnoreCase),
        "preferred clone root must be first");
    Assert(roots.Any(r => r.Equals(Path.GetFullPath(@"E:\AI"), StringComparison.OrdinalIgnoreCase)),
        "must include other ready AI roots");
    Assert(roots.Any(r => r.Equals(Path.GetFullPath(@"E:\repos"), StringComparison.OrdinalIgnoreCase)),
        "must include existing repos roots");
    Assert(!roots.Any(r => r.StartsWith(@"D:\", StringComparison.OrdinalIgnoreCase)),
        "must not invent paths on drives that are not ready");
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
