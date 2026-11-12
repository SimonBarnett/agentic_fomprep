using PriorityAgent;
using System.Text;
using System.Text.Json;
using System.Text.RegularExpressions;

var checks = new List<(string Name, Action Run)>
{
    ("project wcf overrides customer; legacy airc warns", TestWcfConfigPrecedenceAndLegacy),
    ("saas allowlist loads and renders priority-wcf.mjs rules", TestSaasAllowlistAndRules),
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
    ("saved MEDATECH empty answer binds MEDATECH; prompt has [MEDATECH] not OS user", TestSavedLoginEmptyAnswer),
    ("--hours-user OTHER wins over saved MEDATECH", TestHoursUserWinsOverSaved),
    ("MRB-434: space login and access_token row are not suggested", TestInvalidSavedLoginIgnored),
    ("session metadata userLoginSource saved on empty Enter", TestSessionSourceSaved),
    ("--hours-user matching whoami records flag", TestSessionSourceFlagMatchesWhoami),
    ("MRB-439 hostile: typed login is client even when equals saved", TestSessionSourceTypedIsClient),
    ("MRB-439 hostile: identity has no token keys", TestSessionIdentityNoSecrets),
    ("MRB-444 hostile: hours-routing has on_behalf_of not user and no token keys", TestHoursRoutingNoSecrets),
    ("FR-387: --hours-user OTHERUSER vs whoami MEDATECH exits 2 and does not start grok", TestHoursUserDisagreesWithWhoami),
    ("MRB-438: matching --hours-user continues; missing whoami does not block", TestHoursUserMatchesOrAbsentWhoami),
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
            """{"airc":true,"airc_console":"flamingo_console","wcf":[{"id":"cust","host":"cust.example.invalid","tenant":"tcust","company":"CCUST","user":"u@c","tokenFile":"C:\\\\passwords\\\\cust.json","allowLive":false}]}""");
        File.WriteAllText(Path.Combine(project, ".priority-agent.json"),
            """{"airc":false,"wcf":[{"id":"proj","host":"proj.example.invalid","tenant":"tproj","company":"CPROJ","user":"u@p","tokenFile":"C:\\\\passwords\\\\proj.json","allowLive":false}]}""");
        WcfConfig config = WcfSupport.LoadConfig(project, customer);
        Assert(config.Instances.Count == 1 && config.Instances[0].Id == "proj", "project wcf must replace customer");
        Assert(config.Instances[0].Host == "proj.example.invalid" && config.Instances[0].Tenant == "tproj", "project saas fields lost");
        Assert(config.LegacyAircWarnings.Count >= 1, "legacy airc fields must warn");
        Assert(config.LegacyAircWarnings.Any(w => w.Contains("ignored", StringComparison.OrdinalIgnoreCase)),
            "legacy warning must say ignored");

        WcfConfig customerOnly = WcfSupport.LoadConfig(null, customer);
        Assert(customerOnly.Instances.Count == 1 && customerOnly.Instances[0].Id == "cust", "customer wcf lost");
        Assert(customerOnly.LegacyAircWarnings.Count >= 1, "customer legacy airc must warn");
    }
    finally { DeleteTempDirectory(root); }
}

static void TestSaasAllowlistAndRules()
{
    string root = NewTemp();
    try
    {
        string dir = Path.Combine(root, "cust");
        Directory.CreateDirectory(dir);
        File.WriteAllText(Path.Combine(dir, ".priority-agent.json"), """
            {
              "wcf": [
                { "id": "saas", "host": "p.priority-connect.online", "tenant": "ten", "company": "CO", "user": "u@e", "tokenFile": "C:\\\\passwords\\\\t.json", "allowLive": false },
                { "id": "legacy", "serverUrl": "https://prioritydev.example.invalid/", "mode": "direct" },
                { "id": "bad", "host": "", "tenant": "x" }
              ]
            }
            """);
        WcfConfig config = WcfSupport.LoadConfig(null, dir);
        Assert(config.Instances.Count == 1 && config.Instances[0].Id == "saas", $"expected 1 saas instance, got {config.Instances.Count}");
        Assert(config.LegacyAircWarnings.Any(w => w.Contains("#6026", StringComparison.Ordinal) || w.Contains("ignored", StringComparison.OrdinalIgnoreCase)),
            "legacy serverUrl row must warn");

        string file = WcfSupport.WriteSessionInstancesFile(root, config.Instances);
        string rules = WcfSupport.RenderSessionRules("before{{WCF_SECTION}}after", config.Instances, file);
        Assert(rules.Contains("priority-wcf.mjs", StringComparison.Ordinal)
            && rules.Contains("priority-saas-wcf", StringComparison.Ordinal)
            && rules.Contains("bob.ntsa.uk/bob/v1/intake", StringComparison.Ordinal)
            && rules.Contains("Report-FomprepIntakeIssue", StringComparison.Ordinal)
            && rules.Contains("Invoke-FomprepHarvest", StringComparison.Ordinal)
            && rules.Contains("agentic_fomprep", StringComparison.Ordinal)
            && rules.Contains("SO/SC", StringComparison.Ordinal)
            && rules.Contains("gh issue create", StringComparison.Ordinal)
            && rules.Contains("Never", StringComparison.Ordinal)
            && rules.Contains("WINRUN", StringComparison.Ordinal)
            && rules.Contains("#6026", StringComparison.Ordinal)
            && !rules.Contains("DCCLISTEN", StringComparison.Ordinal)
            && !rules.Contains("{{WCF_SECTION}}", StringComparison.Ordinal)
            && !rules.Contains("{{AIRC_SECTION}}", StringComparison.Ordinal),
            "rules must name fom-prep client + harvest destinations and forbid old paths");
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
            new WcfInstance("dev", "p.priority-connect.online", "ten", "CO", "u@e", "C:\\\\passwords\\\\t.json", 3, false, ""),
        };
        string path = WcfSupport.WriteSessionInstancesFile(root, instances);
        string text = File.ReadAllText(path);
        Assert(!Regex.IsMatch(text, @"\bpassword\b|credentialTarget|Bearer\s+[A-Za-z0-9_-]{20,}|access_token|\bsecret\b",
            RegexOptions.IgnoreCase), "session wcf file must not look like secrets");
        using var doc = JsonDocument.Parse(text);
        Assert(doc.RootElement.GetProperty("client").GetString()!.Contains("priority-wcf.mjs", StringComparison.Ordinal),
            "session file must name priority-wcf.mjs");
        Assert(doc.RootElement.GetProperty("instances")[0].GetProperty("host").GetString()
            == "p.priority-connect.online", "host missing from session file");
        Assert(doc.RootElement.GetProperty("instances")[0].GetProperty("tenant").GetString() == "ten",
            "tenant missing from session file");
        Assert(!doc.RootElement.GetProperty("instances")[0].TryGetProperty("serverUrl", out _),
            "session file must not use serverUrl schema");
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
    Assert(readme.Contains("priority-wcf.mjs", StringComparison.Ordinal)
        && readme.Contains("priority-saas-wcf", StringComparison.Ordinal)
        && readme.Contains("tokenFile", StringComparison.Ordinal),
        "README must document fom-prep priority-wcf.mjs allowlist");
    Assert(!Regex.IsMatch(readme, "[\\x00-\\x08\\x0B\\x0C\\x0E-\\x1F]"),
        "README must not contain C0 control characters (BEL/BS/VT)");
    Assert(readme.Contains("host, tenant, company", StringComparison.Ordinal)
        && readme.Contains("bin/priority-wcf.mjs", StringComparison.Ordinal)
        && readme.Contains("v2/apps/priority-saas-wcf", StringComparison.Ordinal),
        "README SaaS field names / client path must be intact");
    Assert(!readme.Contains("\"mode\": \"direct\"", StringComparison.Ordinal)
        && !readme.Contains("\"mode\": \"relay\"", StringComparison.Ordinal),
        "README must not show bobiverse direct/relay as the client route");
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
            new[] { new WcfInstance("dev", "p.priority-connect.online", "ten", "CO", "u@e", "C:\\tok\\t.json", 3, false, "") },
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

static void TestSavedLoginEmptyAnswer()
{
    string root = NewTemp();
    string? previous = Environment.GetEnvironmentVariable(LastUserFile.EnvPath);
    try
    {
        string path = Path.Combine(root, "last-user.json");
        File.WriteAllText(path,
            """{"saas1":{"userLogin":"MEDATECH","company":"CO","identifiedAt":"2026-11-12T00:00:00Z","source":"whoami"}}""");
        Environment.SetEnvironmentVariable(LastUserFile.EnvPath, path);
        string? saved = LastUserFile.ReadUserLogin("saas1");
        Assert(saved == "MEDATECH", "saved login must be MEDATECH");
        string prompt = LastUserFile.FormatPrompt(saved);
        Assert(prompt.Contains("[MEDATECH]", StringComparison.Ordinal), prompt);
        string os = Environment.UserName ?? "";
        if (!os.Equals("MEDATECH", StringComparison.OrdinalIgnoreCase))
            Assert(!prompt.Contains(os, StringComparison.OrdinalIgnoreCase), "prompt must not contain OS user " + os);
        string? requested = LastUserFile.ChooseRequestedUser(null, "", saved);
        var bound = BobHours.BindSessionOwner(null, requested);
        Assert(bound.Ok && bound.UserLogin == "MEDATECH", bound.Detail + "/" + bound.UserLogin);
    }
    finally
    {
        Environment.SetEnvironmentVariable(LastUserFile.EnvPath, previous);
        DeleteTempDirectory(root);
    }
}

static void TestHoursUserWinsOverSaved()
{
    string? requested = LastUserFile.ChooseRequestedUser("OTHER", "", "MEDATECH");
    Assert(requested == "OTHER", "flag must win, got " + requested);
    var bound = BobHours.BindSessionOwner(null, requested);
    Assert(bound.Ok && bound.UserLogin == "OTHER", bound.Detail);
}

static void TestInvalidSavedLoginIgnored()
{
    string root = NewTemp();
    string? previous = Environment.GetEnvironmentVariable(LastUserFile.EnvPath);
    try
    {
        string path = Path.Combine(root, "last-user.json");
        File.WriteAllText(path,
            """{"saas1":{"userLogin":"bad login","access_token":"nope"},"saas2":{"userLogin":"OKUSER"}}""");
        Environment.SetEnvironmentVariable(LastUserFile.EnvPath, path);
        Assert(LastUserFile.ReadUserLogin("saas1") == null, "space login must not be suggested");
        string prompt = LastUserFile.FormatPrompt(LastUserFile.ReadUserLogin("saas1"));
        Assert(!prompt.Contains("[", StringComparison.Ordinal), prompt);
        Assert(LastUserFile.ReadUserLogin("saas2") == "OKUSER", "valid sibling key must still read");
        Assert(LastUserFile.ChooseRequestedUser(null, "", LastUserFile.ReadUserLogin("saas1")) == null,
            "empty Enter must not bind a refused login");
    }
    finally
    {
        Environment.SetEnvironmentVariable(LastUserFile.EnvPath, previous);
        DeleteTempDirectory(root);
    }
}

<<<<<<< HEAD
static void TestSessionSourceSaved()
{
    string root = NewTemp();
    try
    {
        Assert(SessionLoginMeta.ClassifySource(null, "", "MEDATECH") == SessionLoginMeta.SourceSaved,
            "empty Enter must classify saved");
        SessionLoginMeta.WriteIdentity(root, "MEDATECH", SessionLoginMeta.SourceSaved);
        using var id = JsonDocument.Parse(File.ReadAllText(Path.Combine(root, "identity.json")));
        Assert(id.RootElement.GetProperty("priorityUserLogin").GetString() == "MEDATECH", "login");
        Assert(id.RootElement.GetProperty("userLoginSource").GetString() == "saved", "source");
        var routing = new BobHours.CustomerHoursConfig(true, "", "cust", "SC1", "", "", "ok");
        SessionLoginMeta.WriteHoursRoutingLogin(root, "MEDATECH", routing);
        using var hours = JsonDocument.Parse(File.ReadAllText(Path.Combine(root, "hours-routing.json")));
        Assert(hours.RootElement.GetProperty("on_behalf_of").GetString() == "MEDATECH", "hours login");
        Assert(!hours.RootElement.TryGetProperty("user", out _), "must not rename webhook user field");
    }
    finally { DeleteTempDirectory(root); }
}

static void TestSessionSourceFlagMatchesWhoami()
{
    Assert(SessionLoginMeta.ClassifySource("MEDATECH", "", "MEDATECH") == SessionLoginMeta.SourceFlag,
        "matching --hours-user must still be flag");
}

static void TestSessionSourceTypedIsClient()
{
    Assert(SessionLoginMeta.ClassifySource(null, "MEDATECH", "MEDATECH") == SessionLoginMeta.SourceClient,
        "typed answer must be client even when it matches saved");
    Assert(SessionLoginMeta.ClassifySource(null, "OTHER", "MEDATECH") == SessionLoginMeta.SourceClient,
        "typed OTHER must be client");
}

static void TestSessionIdentityNoSecrets()
{
    string root = NewTemp();
    try
    {
        SessionLoginMeta.WriteIdentity(root, "MEDATECH", SessionLoginMeta.SourceFlag);
        string text = File.ReadAllText(Path.Combine(root, "identity.json"));
        Assert(!text.Contains("access_token", StringComparison.Ordinal)
            && !text.Contains("refresh_token", StringComparison.Ordinal)
            && !text.Contains("password", StringComparison.OrdinalIgnoreCase),
            "identity must not look like secrets: " + text);
        Assert(text.Contains("\"userLoginSource\":\"flag\"", StringComparison.Ordinal)
            || text.Contains("\"userLoginSource\": \"flag\"", StringComparison.Ordinal),
            "source flag missing: " + text);
    }
    finally { DeleteTempDirectory(root); }
}

static void TestHoursRoutingNoSecrets()
{
    string root = NewTemp();
    try
    {
        var routing = new BobHours.CustomerHoursConfig(true, "", "cust", "SC1", "", "", "ok");
        SessionLoginMeta.WriteHoursRoutingLogin(root, "MEDATECH", routing);
        string text = File.ReadAllText(Path.Combine(root, "hours-routing.json"));
        Assert(text.Contains("on_behalf_of", StringComparison.Ordinal), text);
        Assert(!text.Contains("\"user\"", StringComparison.Ordinal), "must not rename webhook user field: " + text);
        Assert(!text.Contains("access_token", StringComparison.Ordinal)
            && !text.Contains("password", StringComparison.OrdinalIgnoreCase),
            "hours-routing must not look like secrets: " + text);
    }
    finally { DeleteTempDirectory(root); }
}

static void TestHoursUserDisagreesWithWhoami()
{
    string root = NewTemp();
    string? previous = Environment.GetEnvironmentVariable(LastUserFile.EnvPath);
    try
    {
        string path = Path.Combine(root, "last-user.json");
        string original = """{"saas1":{"userLogin":"MEDATECH","company":"CO","identifiedAt":"2026-11-12T00:00:00Z","source":"whoami"}}""";
        File.WriteAllText(path, original);
        Environment.SetEnvironmentVariable(LastUserFile.EnvPath, path);
        string? whoami = LastUserFile.ReadUserLogin("saas1");
        Assert(whoami == "MEDATECH", "whoami fixture must be MEDATECH");
        LastUserFile.GrokStartCount = 0;
        var check = LastUserFile.CheckFlagAgainstWhoami("OTHERUSER", whoami);
        Assert(!check.Ok && check.ExitCode == 2, check.Detail);
        Assert(check.Detail.Contains("OTHERUSER", StringComparison.Ordinal)
            && check.Detail.Contains("MEDATECH", StringComparison.Ordinal), check.Detail);
        if (check.Ok)
            LastUserFile.NoteGrokStart();
        Assert(LastUserFile.GrokStartCount == 0, "grok start count must stay 0");
        Assert(File.ReadAllText(path) == original, "last-user.json must still contain MEDATECH");
        Assert(File.ReadAllText(path).Contains("MEDATECH", StringComparison.Ordinal), "MEDATECH must remain");
        Assert(!File.ReadAllText(path).Contains("OTHERUSER", StringComparison.Ordinal), "flag must not be written");
    }
    finally
    {
        Environment.SetEnvironmentVariable(LastUserFile.EnvPath, previous);
        DeleteTempDirectory(root);
    }
}

static void TestHoursUserMatchesOrAbsentWhoami()
{
    var match = LastUserFile.CheckFlagAgainstWhoami("MEDATECH", "MEDATECH");
    Assert(match.Ok && match.ExitCode == 0, match.Detail);
    var absent = LastUserFile.CheckFlagAgainstWhoami("OTHERUSER", null);
    Assert(absent.Ok && absent.ExitCode == 0, "no whoami pair must not exit 2: " + absent.Detail);
    var noFlag = LastUserFile.CheckFlagAgainstWhoami(null, "MEDATECH");
    Assert(noFlag.Ok, noFlag.Detail);
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
