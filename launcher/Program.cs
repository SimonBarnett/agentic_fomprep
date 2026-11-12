// Priority Agent launcher - starts a Grok coding agent for Priority ERP work.
// Always fast-forwards SimonBarnett/agentic_fomprep and loads its MCP + skills,
// then lets you pick general / customer / project context and optional WCF instances.
// It never creates customer repos or project folders (Haitch does) and never reads credential files.
using System.Diagnostics;
using System.Net.Http;
using System.Reflection;
using System.Text;
using System.Text.Json;
using System.Text.RegularExpressions;

namespace PriorityAgent;

sealed record Customer(string Name, string FullName, string DefaultBranch, string Description);

static class Program
{
    const string Owner = "SimonBarnett";
    const string FomprepRepo = "agentic_fomprep";
    const string Topic = "priority-customer";
    const string McpName = "priority-catalog";
    const string FuelUrl = "https://bob.ntsa.uk/bob/v1/report";

    static bool DryRun, ListOnly, Smoke, General, NoPause, NoFuel;
    static string? CustomerArg, ProjectArg, CheckHoursDir, SessionArg;
    static string? HoursUserArg, HoursEntryIdArg;
    /// <summary>FR #570 / FR-004: --cli grok|cursor|opencode; when unset, MSI-style chooser (issue #569).</summary>
    static string? CliArg;
    static bool CliExplicit;
    static CliKind ChosenCli = CliKind.Grok;
    static string? ChosenExe;
    static string? ChosenHelpText;
    static List<FoundCli> DiscoveredClis = new();
    /// <summary>Explicit --root / PRIORITY_AGENT_ROOT; null means auto-resolve X:\AI.</summary>
    static string? CloneRootOverride = Environment.GetEnvironmentVariable("PRIORITY_AGENT_ROOT");
    static string CloneRoot = "";
    static string PasswordsDir = Environment.GetEnvironmentVariable("PRIORITY_AGENT_PASSWORDS") ?? @"C:\passwords";
    static string[] SearchRoots = Array.Empty<string>();
    static string LogFile = "";
    static int Fails;

    // FR #267: banner is X.Y.Z (InformationalVersion), not Assembly 4-part FileVersion.
    internal static string LauncherBannerVersion()
    {
        var info = Assembly.GetExecutingAssembly()
            .GetCustomAttribute<AssemblyInformationalVersionAttribute>()?.InformationalVersion;
        if (!string.IsNullOrWhiteSpace(info))
        {
            var core = info.Split('+')[0].Trim();
            if (Regex.IsMatch(core, @"^\d+\.\d+\.\d+"))
                return core;
        }
        var v = Assembly.GetExecutingAssembly().GetName().Version;
        return v is null ? "0.0.0" : $"{v.Major}.{v.Minor}.{v.Build}";
    }

    static int Main(string[] args)
    {
        try { return Run(args); }
        catch (Exception ex) { Err("FATAL: " + ex.Message); Log(ex.ToString()); Pause(); return 1; }
    }

    static int Run(string[] args)
    {
        // MCP stdio server mode: stdout carries JSON-RPC only - nothing else may print.
        int mi = Array.FindIndex(args, a => a.Equals("--mcp-catalog", StringComparison.OrdinalIgnoreCase));
        if (mi >= 0)
        {
            string? dir = mi + 1 < args.Length && !args[mi + 1].StartsWith("--") ? args[mi + 1] : null;
            return CatalogMcp.Serve(dir ?? Environment.GetEnvironmentVariable("PRIORITY_CATALOG_DIR") ?? FindCatalogDir());
        }
        for (int i = 0; i < args.Length; i++)
        {
            string a = args[i].ToLowerInvariant();
            string Next() => i + 1 < args.Length ? args[++i] : throw new ArgumentException($"{a} needs a value");
            switch (a)
            {
                case "--dry-run": DryRun = true; break;
                case "--list": ListOnly = true; break;
                case "--smoke": Smoke = true; break;
                case "--general": General = true; break;
                case "--customer": CustomerArg = Next(); break;
                case "--project": ProjectArg = Next(); break;
                case "--root": CloneRootOverride = Next(); break;
                case "--no-pause": NoPause = true; break;
                case "--no-fuel-check": NoFuel = true; break;
                case "--airc":
                case "--no-airc":
                    Err($"--airc / --no-airc {WcfSupport.RemovedAircMessage}");
                    return 2;
                case "--airc-console":
                    if (i + 1 < args.Length && !args[i + 1].StartsWith("-", StringComparison.Ordinal))
                        i++;
                    Err($"--airc-console {WcfSupport.RemovedAircMessage}");
                    return 2;
                case "--passwords-dir": PasswordsDir = Next(); break;
                case "--check-hours": CheckHoursDir = Next(); break;
                case "--session": SessionArg = Next(); break;
                case "--hours-user": HoursUserArg = Next(); break;
                case "--hours-entry-id": HoursEntryIdArg = Next(); break;
                case "--cli": CliArg = Next(); break;
                case "-h": case "--help": case "/?": Help(); return 0;
                default: Err($"Unknown argument: {args[i]}"); Help(); return 2;
            }
        }
        if (ListOnly || DryRun || Smoke || CustomerArg != null || General) NoPause |= Console.IsInputRedirected;
        string? cliRaw = CliArg ?? Environment.GetEnvironmentVariable("PRIORITY_AGENT_CLI");
        CliExplicit = !string.IsNullOrWhiteSpace(cliRaw);
        if (CliExplicit)
        {
            if (!CliLaunch.TryParseKind(cliRaw, out ChosenCli))
            {
                Err($"Unknown --cli '{cliRaw}' (want grok, cursor, or opencode).");
                return 2;
            }
        }

        string localAppData = Environment.GetEnvironmentVariable("LOCALAPPDATA")
            ?? Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
        string logDir = Path.Combine(localAppData, "PriorityAgent", "logs");
        Directory.CreateDirectory(logDir);
        LogFile = Path.Combine(logDir, $"launcher-{DateTime.Now:yyyyMMdd}.log");
        try { Console.Title = "Priority Agent"; } catch { }

        Header($"Priority Agent launcher {LauncherBannerVersion()}  " +
               (DryRun ? "[DRY RUN] " : "") + (ListOnly ? "[LIST] " : "") + (Smoke ? "[SMOKE] " : ""));
        string logArgs = string.Join(' ', args);
        Log($"=== start args: {logArgs}");

        // AI workspace root: --root / PRIORITY_AGENT_ROOT, else find or create X:\AI (C→D→E…Z).
        if (!string.IsNullOrWhiteSpace(CloneRootOverride))
        {
            CloneRoot = Path.GetFullPath(CloneRootOverride.Trim());
            if (!Directory.Exists(CloneRoot))
            {
                Info($"creating clone root {CloneRoot}");
                Directory.CreateDirectory(CloneRoot);
            }
        }
        else
        {
            bool created = false;
            CloneRoot = AiRoot.Resolve(create: p =>
            {
                Info($"creating AI root {p}");
                Directory.CreateDirectory(p);
                created = true;
            });
            if (!created) Info($"AI root: {CloneRoot}");
        }
        SearchRoots = AiRoot.BuildSearchRoots(CloneRoot);
        Log($"clone root: {CloneRoot}; search: {string.Join(", ", SearchRoots)}");

        string? git = Which("git.exe", Environment.GetEnvironmentVariable("PRIORITY_AGENT_TEST_GIT"),
            @"C:\Program Files\Git\cmd\git.exe", @"D:\Program Files\Git\cmd\git.exe");
        string? gh = Which("gh.exe", Environment.GetEnvironmentVariable("PRIORITY_AGENT_TEST_GH"),
            @"C:\Program Files\GitHub CLI\gh.exe", @"D:\Program Files\GitHub CLI\gh.exe");
        string? grok = Which("grok.exe", Environment.GetEnvironmentVariable("PRIORITY_AGENT_TEST_GROK"),
            Path.Combine(Home, ".grok", "bin", "grok.exe"));
        string? cursorBin = CliChooser.ResolveCursorAgent(localAppData, new[]
        {
            Environment.GetEnvironmentVariable("PRIORITY_AGENT_TEST_CURSOR"),
        });
        string? opencodeBin = Which("opencode.exe",
            Environment.GetEnvironmentVariable("PRIORITY_AGENT_TEST_OPENCODE"),
            Path.Combine(Home, ".opencode", "bin", "opencode.exe"),
            Path.Combine(localAppData, "opencode", "opencode.exe"));
        DiscoveredClis = new List<FoundCli>();
        if (grok != null) DiscoveredClis.Add(new FoundCli(AgentCliKind.Grok, grok));
        if (cursorBin != null) DiscoveredClis.Add(new FoundCli(AgentCliKind.Cursor, cursorBin));
        if (opencodeBin != null) DiscoveredClis.Add(new FoundCli(AgentCliKind.OpenCode, opencodeBin));

        if (CliExplicit)
        {
            ChosenExe = CliLaunch.ResolveExecutable(ChosenCli, Home, new[]
            {
                Environment.GetEnvironmentVariable("PRIORITY_AGENT_TEST_CLI"),
                ChosenCli == CliKind.Grok ? Environment.GetEnvironmentVariable("PRIORITY_AGENT_TEST_GROK") : null,
                ChosenCli == CliKind.Grok ? grok : null,
            });
            Info($"git : {git ?? "MISSING"}\ngh  : {gh ?? "MISSING"}\ncli : {CliLaunch.KindName(ChosenCli)} = {ChosenExe ?? "MISSING"}");
        }
        else
        {
            Info($"git : {git ?? "MISSING"}\ngh  : {gh ?? "MISSING"}\ngrok: {grok ?? "MISSING"}\ncursor: {cursorBin ?? "MISSING"}\nopencode: {opencodeBin ?? "MISSING"}");
        }
        if (git == null || gh == null) { Err("git and gh are required."); Pause(); return 1; }
        Git = git; Gh = gh;

        if (CheckHoursDir != null)
        {
            if (string.IsNullOrWhiteSpace(SessionArg)) { Err("--check-hours needs --session <full uuid>"); return 2; }
            string checkSessionDir = Path.Combine(localAppData, "PriorityAgent", "sessions", SessionArg);
            Header("Hours check session " + SessionArg);
            Info("hours check uses the webhook list, not " + CheckHoursDir);
            bool ok = RunHoursGate(SessionArg, checkSessionDir, CustomerArg ?? "", ProjectArg ?? "", out string det);
            Check(ok, det); Summary(); Pause(); return ok ? 0 : 1;
        }

        // ---- 1. agentic_fomprep: always fast-forward --------------------------------
        Header("[1] General Priority skills: SimonBarnett/agentic_fomprep");
        string fomprep = EnsureClone(FomprepRepo, $"{Owner}/{FomprepRepo}", "main", alwaysPull: true, preferClean: false)
                         ?? throw new Exception("agentic_fomprep clone unavailable");
        string skillsDir = Path.Combine(fomprep, ".grok", "skills");
        int skillCount = Directory.Exists(skillsDir) ? Directory.GetDirectories(skillsDir).Count(d => File.Exists(Path.Combine(d, "SKILL.md"))) : 0;
        Check(skillCount > 0, $"skills in {skillsDir}: {skillCount}");

        // ---- 2. customers from GitHub topic ------------------------------------------
        Header($"[2] Customer repos (GitHub topic '{Topic}')");
        var customers = ListCustomers();
        Check(customers.Count > 0, $"{customers.Count} customer repo(s) tagged {Topic}");
        for (int i = 0; i < customers.Count; i++)
        {
            var loc = FindClone(customers[i].Name, customers[i].FullName);
            Console.WriteLine($"  {i + 1,2}. {customers[i].Name,-16} {(loc ?? "(not cloned yet)"),-28} {Trunc(customers[i].Description, 50)}");
        }

        Customer? cust = null;
        if (General) cust = null;
        else if (CustomerArg != null)
        {
            cust = customers.FirstOrDefault(c => c.Name.Equals(CustomerArg, StringComparison.OrdinalIgnoreCase) || c.FullName.Equals(CustomerArg, StringComparison.OrdinalIgnoreCase));
            if (cust == null) { Err($"'{CustomerArg}' is not a repo tagged {Topic}."); return Haitch($"new customer repo for {CustomerArg} (topic {Topic})"); }
        }
        else if (!ListOnly)
        {
            Console.WriteLine("\n   0. General Priority only (no customer)\n   N. New customer...");
            string pick = Ask("Pick customer [0-" + customers.Count + "/N]: ");
            if (pick.Equals("n", StringComparison.OrdinalIgnoreCase))
                return Haitch($"new customer repo for {Ask("Customer name: ")} (tag it {Topic})");
            if (int.TryParse(pick, out int n) && n >= 1 && n <= customers.Count) cust = customers[n - 1];
            else if (pick != "0" && pick != "") { Err("Invalid choice."); Pause(); return 2; }
        }
        if (ListOnly && cust == null) { Summary(); Pause(); return Fails == 0 ? 0 : 1; }

        // ---- 3. project / service-call folder ----------------------------------------
        string? custDir = null, project = null, projectDir = null;
        if (cust != null)
        {
            Header($"[3] Customer {cust.FullName}: project / service-call folders");
            custDir = EnsureClone(cust.Name, cust.FullName, cust.DefaultBranch, alwaysPull: !DryRun, preferClean: false);
            if (custDir == null) { Err("Customer clone unavailable."); Pause(); return 1; }
            var folders = Directory.GetDirectories(custDir).Select(Path.GetFileName).Where(n => n != null && !n.StartsWith('.'))
                                   .Cast<string>().OrderBy(n => n, StringComparer.OrdinalIgnoreCase).ToList();
            Check(true, $"{folders.Count} folder(s) in {custDir} (dot-folders skipped)");
            for (int i = 0; i < folders.Count; i++) Console.WriteLine($"  {i + 1,2}. {folders[i]}");

            if (ProjectArg != null)
            {
                project = folders.FirstOrDefault(f => f.Equals(ProjectArg, StringComparison.OrdinalIgnoreCase));
                if (project == null) { Err($"No folder '{ProjectArg}' in {cust.Name}."); return Haitch($"new project folder {ProjectArg} in {cust.FullName}"); }
            }
            else if (!ListOnly && CustomerArg == null)
            {
                Console.WriteLine("\n   0. Customer level only (no project)\n   N. New project / service call...");
                string pick = Ask("Pick project [0-" + folders.Count + "/N]: ");
                if (pick.Equals("n", StringComparison.OrdinalIgnoreCase))
                    return Haitch($"new project folder {Ask("Project / service-call name (e.g. SC263999): ")} in {cust.FullName}");
                if (int.TryParse(pick, out int n) && n >= 1 && n <= folders.Count) project = folders[n - 1];
                else if (pick != "0" && pick != "") { Err("Invalid choice."); Pause(); return 2; }
            }
            if (project != null) projectDir = Path.Combine(custDir, project);
            if (project != null && !BobHours.IsAuthoritativeProjectFolder(project))
                Warn("project folder '" + project + "' is not an SCxxxxxx or SOxxxxxx id. Left unchanged. Hours for this folder stay unresolved until an authoritative id is evidenced.");
        }
        BobHours.CustomerHoursConfig? hoursConfig = null;
        if (cust != null && project != null && projectDir != null && BobHours.IsAuthoritativeProjectFolder(project))
        {
            string? hoursText = null;
            string? projectText = null;
            string hoursPath = Path.Combine(custDir!, "hours.json");
            string projectPath = Path.Combine(projectDir, "project.md");
            if (File.Exists(hoursPath)) hoursText = File.ReadAllText(hoursPath);
            if (File.Exists(projectPath)) projectText = File.ReadAllText(projectPath);
            var loaded = BobHours.ReadCustomerHoursConfig(cust.Name, project, hoursText, projectText);
            if (!loaded.Ok) { Err(loaded.Detail); Pause(); return 2; }
            hoursConfig = loaded;
            Info("hours routing customer " + loaded.Customer + " project " + loaded.Project
                + " booking " + (loaded.PriorityProject.Length == 0 ? "(none)" : loaded.PriorityProject)
                + " wbs " + loaded.WbsStatus + " (not sent on the hours report)");
        }
        if (ListOnly) { Summary(); Pause(); return Fails == 0 ? 0 : 1; }

        // ---- 3b. WCF instance config (FR #348; replaces airc remote-shell) -------------
        WcfConfig wcfConfig = WcfSupport.LoadConfig(projectDir, custDir);
        foreach (string warning in wcfConfig.LegacyAircWarnings)
            Warn(warning);
        if (wcfConfig.Instances.Count == 0)
            Info("wcf: no SaaS allowlist instances (default %USERPROFILE%/.priority-saas-wcf/instances.json or .priority-agent.json); agent will ask Simon if Priority work needs one");
        else
        {
            Info($"wcf: {wcfConfig.Instances.Count} instance(s) from {wcfConfig.SourcePath}");
            foreach (var inst in wcfConfig.Instances)
                Console.WriteLine($"  - {inst.Id}  host={inst.Host} tenant={inst.Tenant} allowLive={inst.AllowLive}");
        }
        Log($"wcf instances: {wcfConfig.Instances.Count} from {wcfConfig.SourcePath ?? "(none)"}");

        // ---- 4. agent CLI chooser (issue #569) or explicit --cli, then launch ----------
        if (!CliExplicit)
        {
            Header("[4] Agent CLI");
            var chosen = ChooseAgentCli(DiscoveredClis);
            if (chosen.Action == CliChooserAction.Refuse || chosen.Launch == null)
            {
                Err(chosen.Message);
                Pause();
                return chosen.ExitCode == 0 ? 1 : chosen.ExitCode;
            }
            ChosenCli = ToCliKind(chosen.Launch.Kind);
            ChosenExe = CliChooser.HoursRelaunchExe(chosen.Launch);
            Info($"chosen: {CliLaunch.KindName(ChosenCli)} = {ChosenExe}");
        }
        else
            Header("[4] Agent (" + CliLaunch.KindName(ChosenCli) + ")");

        if (ChosenExe == null)
        {
            Err(ChosenCli == CliKind.Grok
                ? "grok CLI not found (expected %USERPROFILE%\\.grok\\bin\\grok.exe)."
                : ChosenCli == CliKind.Cursor
                    ? "Cursor agent not found (expected %LOCALAPPDATA%\\cursor-agent\\agent.cmd)."
                    : "OpenCode CLI not found (expected a standalone opencode.exe under LocalAppData\\opencode).");
            Pause();
            return 1;
        }
        if (ChosenCli == CliKind.Grok)
        {
            EnsureGrokMcp(ChosenExe, fomprep);
            EnsureGrokSkillsPath(skillsDir);
            if (!NoFuel) FuelCheck();
        }
        else
        {
            Info("FR #570: skipping Grok MCP registration for " + CliLaunch.KindName(ChosenCli));
            ChosenHelpText = CaptureCliHelp(ChosenExe);
        }

        string level = projectDir != null ? "project" : cust != null ? "customer" : "general";
        string workDir = projectDir ?? custDir ?? fomprep;
        string sessionId = Guid.NewGuid().ToString();
        string sessShort = Short(sessionId);
        DateTime launchedAt = DateTime.Now;
        string hoursRepo = cust?.FullName ?? $"{Owner}/{FomprepRepo}";
        string pwFile = cust != null ? Path.Combine(PasswordsDir, $"{cust.Name.ToLowerInvariant()}-connections.txt") : Path.Combine(PasswordsDir, "<repo>-connections.txt");
        string sessDirEarly = Path.Combine(Path.GetDirectoryName(logDir)!, "sessions");
        string sessionDirEarly = Path.Combine(sessDirEarly, sessionId);
        string hoursEntryFile = Path.Combine(sessionDirEarly, "hours-entry.json");
        var vars = new Dictionary<string, string>
        {
            ["LEVEL"] = level, ["FOMPREP_DIR"] = fomprep, ["WORK_DIR"] = workDir,
            ["CUSTOMER"] = cust?.Name ?? "(none - general Priority)", ["CUSTOMER_REPO"] = cust?.FullName ?? "(none)",
            ["CUSTOMER_DIR"] = custDir ?? "(none)", ["PROJECT"] = project ?? "(none)", ["PROJECT_DIR"] = projectDir ?? "(none - ask Simon)",
            ["PASSWORDS_FILE"] = pwFile, ["SESSION"] = sessionId, ["SESSION_SHORT"] = sessShort,
            ["HOURS_REPO"] = hoursRepo, ["HOURS_REPO_DIR"] = custDir ?? fomprep, ["HOURS_ENTRY_FILE"] = hoursEntryFile,
            ["TODAY"] = launchedAt.ToString("yyyy-MM-dd"),
        };
        string rules = LoadRules(fomprep, out string rulesSrc);
        string sessionDir = sessionDirEarly;
        Directory.CreateDirectory(sessionDir);
        string instanceId = wcfConfig.Instances.Count > 0 ? wcfConfig.Instances[0].Id : "";
        string? savedLogin = LastUserFile.ReadUserLogin(instanceId);
        string? whoamiLogin = Environment.GetEnvironmentVariable("PRIORITY_AGENT_TEST_WHOAMI");
        if (string.IsNullOrWhiteSpace(whoamiLogin))
            whoamiLogin = savedLogin;
        var flagWhoami = LastUserFile.CheckFlagAgainstWhoami(HoursUserArg, whoamiLogin);
        if (!flagWhoami.Ok)
        {
            Err(flagWhoami.Detail + " Agent not started.");
            Pause();
            return flagWhoami.ExitCode;
        }
        string? typedAnswer = null;
        // FR-004: never ReadLine when stdin is redirected; bind saved login or fail unavailable.
        // FR-003: interactive prompt offers [saved]; empty Enter binds saved.
        if (string.IsNullOrWhiteSpace(HoursUserArg) && !Console.IsInputRedirected)
            typedAnswer = Ask(LastUserFile.FormatPrompt(savedLogin));
        string? requestedUser = LastUserFile.ResolveLaunchUser(
            HoursUserArg, Console.IsInputRedirected, savedLogin, typedAnswer);
        string userLoginSource = SessionLoginMeta.ClassifySource(HoursUserArg, typedAnswer, savedLogin);
        var sessionOwner = BobHours.BindSessionOwner(ReadSessionOwner(sessionDir), requestedUser);
        if (!sessionOwner.Ok || string.IsNullOrEmpty(sessionOwner.UserLogin))
        {
            Err(sessionOwner.Detail + " Pass --hours-user for this launch. No default login is used.");
            Pause();
            return 2;
        }
        if (ReadSessionOwner(sessionDir) == null)
            SessionLoginMeta.WriteIdentity(sessionDir, sessionOwner.UserLogin, userLoginSource);
        if (hoursConfig is { } routing)
            SessionLoginMeta.WriteHoursRoutingLogin(sessionDir, sessionOwner.UserLogin, routing);
        vars["PRIORITY_USER"] = sessionOwner.UserLogin;
        string? wcfInstancesFile = null;
        if (wcfConfig.Instances.Count > 0)
            wcfInstancesFile = WcfSupport.WriteSessionInstancesFile(sessionDir, wcfConfig.Instances);
        rules = WcfSupport.RenderSessionRules(rules, wcfConfig.Instances, wcfInstancesFile);
        foreach (var kv in vars) rules = rules.Replace("{{" + kv.Key + "}}", kv.Value);
        Info($"rules: {rulesSrc} ({rules.Length} chars)");
        if (cust != null)
        {
            bool connectionsExist = LauncherSupport.ConnectionFileExists(pwFile);
            Check(connectionsExist, LauncherSupport.ConnectionFileStatus(cust.Name, pwFile, connectionsExist));
        }
        Info($"hours: session owner {sessionOwner.UserLogin}; idempotency_key priority-agent-{sessionId}; persist the returned id at {hoursEntryFile}");

        var brief = new StringBuilder();
        brief.AppendLine($"Priority agent session {sessionId} (launched {DateTime.Now:yyyy-MM-dd HH:mm} on {Environment.MachineName}).");
        brief.AppendLine($"Context level: {level}. Working directory: {workDir}.");
        brief.AppendLine($"General Priority repo: {fomprep} (SimonBarnett/agentic_fomprep @ {GitOut(fomprep, "rev-parse", "--short", "HEAD")}); MCP server '{McpName}' and its .grok/skills are loaded.");
        if (wcfConfig.Instances.Count > 0)
        {
            brief.AppendLine("Priority WCF client (fom-prep priority-wcf.mjs / priority-saas-wcf): use allowlist instances; never airc shell, WINRUN, raw web SDK, OData, or bobiverse priority_wcf.py (#6026).");
            foreach (var inst in wcfConfig.Instances)
                brief.AppendLine($"  WCF {inst.Id}: host={inst.Host} tenant={inst.Tenant} allowLive={inst.AllowLive}");
        }
        if (cust != null) brief.AppendLine($"Customer: {cust.Name} = {cust.FullName}, clone {custDir}. Connection secrets (never commit/echo): {pwFile}.");
        if (project != null) brief.AppendLine($"Project / service call: {project} at {projectDir}.");
        var readFirst = new List<string> { Path.Combine(fomprep, "AGENTS.md") };
        if (custDir != null) readFirst.AddRange(new[] { Path.Combine(custDir, "AGENTS.md"), Path.Combine(custDir, "README.md") });
        if (projectDir != null) readFirst.AddRange(new[] { Path.Combine(projectDir, "README.md"), Path.Combine(projectDir, "log.md") });
        brief.AppendLine("Read first (those that exist): " + string.Join("; ", readFirst));
        brief.Append(Smoke
            ? "SMOKE TEST: do not read or change any file and do not contact any customer system. You may call the priority-catalog tool list_catalog once (read-only, local). Reply in at most 8 lines: the context level, customer, project; the priority-catalog tools you have and whether that server is connected (with the skill count list_catalog returned); whether Priority skills are visible; and what your launcher rules say about connecting to this customer's systems. Then stop."
            : $"Follow the launcher rules (harvest rule, secrets, WCF client, MANDATORY hours webhook idempotency_key priority-agent-{sessionId}). Then briefly confirm the context and ask Simon what to work on.");

        string rulesFile = Path.Combine(sessionDir, "rules.md");
        var wcfMeta = wcfConfig.Instances.Select(i => new { id = i.Id, host = i.Host, tenant = i.Tenant, company = i.Company, allowLive = i.AllowLive }).ToArray();
        LauncherSupport.WriteSessionMetadata(sessionDir, rules, new
        {
            sessionId,
            level,
            customer = cust?.FullName,
            project,
            priorityUserLogin = sessionOwner.UserLogin,
            workDir,
            fomprep,
            cli = CliLaunch.KindName(ChosenCli),
            cliExe = ChosenExe,
            grok = ChosenCli == CliKind.Grok ? ChosenExe : null,
            wcf = wcfMeta,
            dryRun = DryRun,
            smoke = Smoke,
            at = DateTime.Now,
        });

        string routeCustomer = hoursConfig?.Customer ?? cust?.Name ?? "";
        string routeProject = hoursConfig?.Project ?? project ?? "";
        string hoursCustomer = routeCustomer.Length == 0 ? "Leave customer empty. " : "customer " + routeCustomer + ". ";
        string hoursProject = routeProject.Length == 0 ? "Leave project empty. " : "project " + routeProject + " (the folder name). ";
        string hoursPrompt = "HOURS NOT REPORTED. Priority agents MUST report their hours on https://bob.ntsa.uk/bob/v1/hours. "
            + "Reuse idempotency_key priority-agent-" + sessionId + ". "
            + "on_behalf_of is " + sessionOwner.UserLogin + " for this session only. " + hoursCustomer + hoursProject
            + "Do not send priority_project or wbs. Booking stays in project.md. "
            + "Persist that same login with the returned id in " + hoursEntryFile + ". "
            + "Do not invent start, end, or duration. Do not book Priority. Then stop.";
        var gargs = CliLaunch.BuildArguments(
            ChosenCli, workDir, sessionId, rules, brief.ToString(), Smoke, ChosenHelpText);
        var resumeArgs = CliLaunch.BuildArguments(
            ChosenCli, workDir, sessionId, rules, brief.ToString(), false, ChosenHelpText,
            hoursRelaunch: true, hoursPrompt: hoursPrompt);
        EnsureCommandLineSize(ChosenExe!, gargs, CliLaunch.KindName(ChosenCli) + " launch");
        EnsureCommandLineSize(ChosenExe!, resumeArgs, CliLaunch.KindName(ChosenCli) + " hours relaunch");
        string display = Quote(ChosenExe!) + " " + string.Join(' ', gargs.Select(a => a == rules ? $"<rules: {rulesFile}>" : Quote(a)));
        Console.WriteLine("\nLaunch command:\n  " + display.Replace("\r\n", "\\n").Replace("\n", "\\n"));
        Log("launch: " + display);
        Check(Directory.Exists(workDir), $"working directory exists: {workDir}");
        Console.WriteLine("Hours relaunch command (only if hours are missing on exit):\n  " + Quote(ChosenExe!) + " " +
            string.Join(' ', resumeArgs.Select(a => a == rules ? $"<rules: {rulesFile}>" : Quote(a))));

        if (DryRun) { Info("Dry run: agent not started."); Summary(); Pause(); return Fails == 0 ? 0 : 1; }

        if (Smoke && ChosenCli == CliKind.Grok) GrokInspect(ChosenExe!, workDir);
        Header(Smoke
            ? $"Starting {CliLaunch.KindName(ChosenCli)} (single-turn smoke)..."
            : $"Starting {CliLaunch.KindName(ChosenCli)}...");
        int code = RunChosenCli(ChosenExe!, workDir, gargs);
        if (Smoke)
        {
            Check(code == 0, "smoke launch exit code 0");
            bool ok = RunHoursGate(sessionId, sessionDir, hoursConfig?.Customer ?? cust?.Name ?? "", hoursConfig?.Project ?? project ?? "", out string det);
            Info($"hours enforcement probe (smoke writes no hours, so a missing id is expected and no live POST is made): {det}");
            Info(ok ? "hours present" : "-> a real session would now be relaunched with the hours prompt (--resume " + sessionId + ")");
            Summary(); Pause(); return code;
        }

        // ---- 5. mandatory hours ---------------------------------------------------------
        for (int attempt = 1; ; attempt++)
        {
            Header("[5] Hours check (mandatory)");
            if (RunHoursGate(sessionId, sessionDir, hoursConfig?.Customer ?? cust?.Name ?? "", hoursConfig?.Project ?? project ?? "", out string det)) { Check(true, det); break; }
            Color(ConsoleColor.Red, "\n  ################################################################");
            Color(ConsoleColor.Red, "  ##  HOURS NOT REPORTED - Priority agents MUST report their hours ##");
            Color(ConsoleColor.Red, "  ################################################################");
            Color(ConsoleColor.Red, "  " + det);
            try { Console.Beep(); } catch { }
            if (Console.IsInputRedirected) { Fails++; Err("non-interactive: cannot relaunch for hours."); break; }
            string ans = Ask($"Relaunching the agent to report hours (attempt {attempt}). Press Enter to continue (type SKIP to override, it gets logged): ");
            if (ans == "SKIP") { Log($"HOURS OVERRIDE: session {sessionId} closed without hours by user"); Warn("hours skipped by override; logged."); Fails++; break; }
            // FR #570: hours loop relaunches the chosen CLI, never a hardcoded grok.exe.
            code = RunChosenCli(ChosenExe!, workDir, resumeArgs);
        }
        Pause();
        return code;
    }

    static int RunChosenCli(string exe, string workDir, List<string> cliArgs)
    {
        ProcessStartInfo psi;
        // Cursor ships as agent.cmd; ArgumentList on a .cmd file needs cmd.exe /c.
        if (exe.EndsWith(".cmd", StringComparison.OrdinalIgnoreCase)
            || exe.EndsWith(".bat", StringComparison.OrdinalIgnoreCase))
        {
            psi = new ProcessStartInfo("cmd.exe") { UseShellExecute = false, WorkingDirectory = workDir };
            psi.ArgumentList.Add("/c");
            psi.ArgumentList.Add(exe);
        }
        else
        {
            psi = new ProcessStartInfo(exe) { UseShellExecute = false, WorkingDirectory = workDir };
        }
        foreach (var a in cliArgs) psi.ArgumentList.Add(a);
        if (ChosenCli == CliKind.Grok) LastUserFile.NoteGrokStart();
        using var p = Process.Start(psi)!;
        p.WaitForExit();
        Log($"{CliLaunch.KindName(ChosenCli)} exit {p.ExitCode}");
        Info($"{CliLaunch.KindName(ChosenCli)} exited ({p.ExitCode}).");
        return p.ExitCode;
    }

    /// <summary>FR #570: keep RunGrok name for Grok-only callers; forwards to RunChosenCli.</summary>
    static int RunGrok(string grok, string workDir, List<string> gargs) => RunChosenCli(grok, workDir, gargs);

    static string CaptureCliHelp(string exe)
    {
        try
        {
            var psi = new ProcessStartInfo(exe)
            {
                UseShellExecute = false,
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                CreateNoWindow = true,
            };
            psi.ArgumentList.Add("--help");
            using var p = Process.Start(psi);
            if (p == null) return "";
            string stdout = p.StandardOutput.ReadToEnd();
            string stderr = p.StandardError.ReadToEnd();
            p.WaitForExit(15_000);
            return stdout + "\n" + stderr;
        }
        catch (Exception ex)
        {
            Warn("FR #570: could not read " + exe + " --help (" + ex.GetType().Name + "); starting with work directory only.");
            return "";
        }
    }

    static string Short(string session) => session.Replace("-", "")[..Math.Min(8, session.Replace("-", "").Length)].ToLowerInvariant();

    // Issue #278: one closed webhook entry. Fixture env never contacts the network.
    // A live GET is a single attempt with no retry. Non-success is delivery unverified.
    static bool RunHoursGate(string sessionId, string? sessionDir, string expectedCustomer, string expectedProject, out string detail)
    {
        ReadPersistedHours(sessionDir, out string fileId, out string fileStart, out string fileOwner);
        string? persistedOwner = sessionDir == null ? null : ReadSessionOwner(sessionDir);
        var owner = BobHours.BindSessionOwner(persistedOwner, HoursUserArg);
        if (string.IsNullOrEmpty(persistedOwner))
        {
            detail = "session owner unavailable. No request sent.";
            return false;
        }
        if (!owner.Ok)
        {
            detail = owner.Detail + " No request sent.";
            return false;
        }
        if (fileOwner.Length > 0 && !string.Equals(fileOwner, owner.UserLogin, StringComparison.Ordinal))
        {
            detail = "hours entry owner does not match session owner. No request sent.";
            return false;
        }
        string user = owner.UserLogin;
        ReadHoursRouting(sessionDir, out string routedCustomer, out string routedProject, out string routedOwner);
        if (routedOwner.Length > 0 && !string.Equals(routedOwner, user, StringComparison.Ordinal))
        {
            detail = "hours routing owner does not match session owner. No request sent.";
            return false;
        }
        string entryId = (HoursEntryIdArg ?? Environment.GetEnvironmentVariable("PRIORITY_AGENT_HOURS_ENTRY_ID") ?? "").Trim();
        if (entryId.Length == 0) entryId = fileId;
        var expect = new BobHoursExpect(
            BobHours.IdempotencyKeyForSession(sessionId),
            entryId,
            user,
            routedCustomer.Length > 0 ? routedCustomer : expectedCustomer ?? "",
            routedProject.Length > 0 ? routedProject : expectedProject ?? "");
        var pre = BobHours.Precheck(expect);
        if (!pre.Ok) { detail = pre.Detail + " No request sent."; return false; }

        string? fixture = Environment.GetEnvironmentVariable("PRIORITY_AGENT_HOURS_JSON");
        string json;
        if (!string.IsNullOrWhiteSpace(fixture))
        {
            if (!File.Exists(fixture)) { detail = "hours fixture missing. No request sent."; return false; }
            json = File.ReadAllText(fixture);
        }
        else
        {
            DateTimeOffset? started = BobHours.TryParseInstant(fileStart, out var parsedStart) ? parsedStart : null;
            var window = BobHours.WindowForStart(started, DateTimeOffset.UtcNow);
            string query = BobHours.BuildListQuery(user, window.FromDay, window.ToDay);
            if (!TryFetchHoursList(query, out json, out detail)) return false;
        }
        var result = BobHours.Evaluate(json, expect);
        detail = result.Detail;
        return result.Ok;
    }

    static void ReadPersistedHours(string? sessionDir, out string id, out string start, out string owner)
    {
        id = "";
        start = "";
        owner = "";
        if (string.IsNullOrEmpty(sessionDir)) return;
        string path = Path.Combine(sessionDir, "hours-entry.json");
        if (!File.Exists(path)) return;
        try
        {
            using var doc = JsonDocument.Parse(File.ReadAllText(path));
            if (doc.RootElement.TryGetProperty("id", out var idEl) && idEl.ValueKind == JsonValueKind.String)
                id = (idEl.GetString() ?? "").Trim();
            if (doc.RootElement.TryGetProperty("start", out var startEl) && startEl.ValueKind == JsonValueKind.String)
                start = (startEl.GetString() ?? "").Trim();
            if (doc.RootElement.TryGetProperty("on_behalf_of", out var ownerEl) && ownerEl.ValueKind == JsonValueKind.String)
                owner = (ownerEl.GetString() ?? "").Trim();
        }
        catch { }
    }

    static string? ReadSessionOwner(string sessionDir)
    {
        string path = Path.Combine(sessionDir, "identity.json");
        if (!File.Exists(path)) return null;
        try
        {
            using var doc = JsonDocument.Parse(File.ReadAllText(path));
            if (doc.RootElement.TryGetProperty("priorityUserLogin", out var user) && user.ValueKind == JsonValueKind.String)
                return (user.GetString() ?? "").Trim();
        }
        catch { }
        return null;
    }

    static void ReadHoursRouting(string? sessionDir, out string customer, out string project, out string owner)
    {
        customer = "";
        project = "";
        owner = "";
        if (string.IsNullOrEmpty(sessionDir)) return;
        string path = Path.Combine(sessionDir, "hours-routing.json");
        if (!File.Exists(path)) return;
        try
        {
            using var doc = JsonDocument.Parse(File.ReadAllText(path));
            if (doc.RootElement.ValueKind != JsonValueKind.Object) return;
            customer = RoutingString(doc.RootElement, "customer");
            project = RoutingString(doc.RootElement, "project");
            owner = RoutingString(doc.RootElement, "on_behalf_of");
        }
        catch { }
    }

    static string RoutingString(JsonElement obj, string name)
    {
        if (!obj.TryGetProperty(name, out var value) || value.ValueKind != JsonValueKind.String)
            return "";
        return (value.GetString() ?? "").Trim();
    }

    static bool TryFetchHoursList(string query, out string json, out string detail)
    {
        json = "";
        string url = "https://bob.ntsa.uk/bob/v1/hours?" + query;
        try
        {
            using var http = new HttpClient { Timeout = TimeSpan.FromSeconds(8) };
            using var resp = http.GetAsync(url).GetAwaiter().GetResult();
            if (!resp.IsSuccessStatusCode)
            {
                detail = "hours GET HTTP " + (int)resp.StatusCode + "; delivery unverified; no retry";
                return false;
            }
            json = resp.Content.ReadAsStringAsync().GetAwaiter().GetResult();
            detail = "";
            return true;
        }
        catch (Exception ex)
        {
            detail = "hours GET unavailable; delivery unverified; no retry (" + ex.GetType().Name + ")";
            return false;
        }
    }

    // ------------------------------------------------------------------ git / gh
    static string Git = "git", Gh = "gh";
    static string Home => Environment.GetEnvironmentVariable("USERPROFILE")
        ?? Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);

    static string? FindClone(string name, string fullName)
    {
        foreach (var root in SearchRoots.Prepend(CloneRoot).Distinct(StringComparer.OrdinalIgnoreCase))
        {
            string d = Path.Combine(root, name);
            if (!Directory.Exists(d)) continue;
            if (!Directory.Exists(Path.Combine(d, ".git")))
            {
                Warn($"{d} exists but is not a git clone (no .git) - empty stub skipped");
                continue;
            }
            string url = GitOut(d, "remote", "get-url", "origin");
            if (url.Contains(fullName, StringComparison.OrdinalIgnoreCase)) return d;
        }
        return null;
    }

    static string? EnsureClone(string name, string fullName, string branch, bool alwaysPull, bool preferClean)
    {
        // FR #240: a valid clone with uncommitted changes is usable (warn, skip pull).
        // preferClean is unused for selection: dirty must never be skipped.
        _ = preferClean;
        var sightings = new List<CloneSighting>();
        foreach (var root in SearchRoots.Prepend(CloneRoot).Distinct(StringComparer.OrdinalIgnoreCase))
        {
            string d = Path.Combine(root, name);
            if (!Directory.Exists(d))
            {
                sightings.Add(new CloneSighting(d, CloneKind.Missing));
                continue;
            }
            if (!Directory.Exists(Path.Combine(d, ".git")))
            {
                Warn($"{d} exists but is not a git clone (no .git) - empty stub skipped");
                sightings.Add(new CloneSighting(d, CloneKind.Stub));
                continue;
            }
            if (!GitOut(d, "remote", "get-url", "origin").Contains(fullName, StringComparison.OrdinalIgnoreCase))
            {
                sightings.Add(new CloneSighting(d, CloneKind.WrongOrigin));
                continue;
            }
            bool dirty = GitOut(d, "status", "--porcelain").Length > 0;
            sightings.Add(new CloneSighting(d, dirty ? CloneKind.Dirty : CloneKind.Clean));
        }
        string? dir = CloneResolve.SelectUsable(sightings, out string? pickReason);
        if (dir == null)
        {
            string preferred = Path.Combine(CloneRoot, name);
            bool preferredVacant = !Directory.Exists(preferred) || !Directory.EnumerateFileSystemEntries(preferred).Any();
            if (preferredVacant)
            {
                if (DryRun && !alwaysPull) { Info($"would clone {fullName} -> {preferred}"); return null; }
                Info($"cloning {fullName} -> {preferred}");
                Directory.CreateDirectory(CloneRoot);
                int rc = RunTo(Gh, CloneRoot, "repo", "clone", fullName, preferred);
                Check(rc == 0, $"cloned {fullName}");
                return rc == 0 ? preferred : null;
            }
            Err(CloneResolve.FatalUnavailable(fullName, sightings));
            return null;
        }
        if (pickReason != null && pickReason.Contains("dirty", StringComparison.OrdinalIgnoreCase))
            Warn($"{dir} has uncommitted changes: using it and skipping pull");
        Info($"clone: {dir}");
        string before = GitOut(dir, "rev-parse", "--short", "HEAD");
        string cur = GitOut(dir, "rev-parse", "--abbrev-ref", "HEAD");
        int frc = RunTo(Git, dir, "fetch", "--prune", "--quiet", "origin");
        if (frc != 0) { Warn("git fetch failed (offline?) - using local copy"); return dir; }
        string behind = GitOut(dir, "rev-list", "--count", $"HEAD..origin/{branch}");
        bool dirtyNow = GitOut(dir, "status", "--porcelain").Length > 0;
        if (cur != branch || dirtyNow)
        {
            Warn($"on '{cur}'{(dirtyNow ? ", uncommitted changes" : "")}: not fast-forwarding ({behind} commit(s) behind origin/{branch}).");
            return dir;
        }
        if (!alwaysPull) { Info($"{behind} commit(s) behind origin/{branch}; dry run - not fast-forwarding."); return dir; }
        int mrc = RunTo(Git, dir, "merge", "--ff-only", "--quiet", $"origin/{branch}");
        string after = GitOut(dir, "rev-parse", "--short", "HEAD");
        string remote = GitOut(dir, "rev-parse", "--short", $"origin/{branch}");
        Check(mrc == 0 && after == remote, $"fast-forward {name}: {before} -> {after} (origin/{branch} {remote}, was {behind} behind)");
        return dir;
    }

    static List<Customer> ListCustomers()
    {
        // REST listing filtered on topics: no search-index lag (gh repo list --topic uses search).
        string jq = ".[] | select((.topics // []) | index(\"" + Topic + "\")) | [.name, .full_name, .default_branch, (.description // \"\")] | @tsv";
        var (rc, outp, err) = Capture(Gh, null, "api", "--paginate", "user/repos?affiliation=owner&per_page=100", "--jq", jq);
        if (rc != 0) { Err("gh api failed: " + err.Trim()); return new(); }
        return outp.Split('\n', StringSplitOptions.RemoveEmptyEntries)
            .Select(l => l.TrimEnd('\r').Split('\t'))
            .Where(f => f.Length >= 3)
            .Select(f => new Customer(f[0], f[1], f[2], f.Length > 3 ? f[3] : ""))
            .OrderBy(c => c.Name, StringComparer.OrdinalIgnoreCase).ToList();
    }

    // ------------------------------------------------------------------ grok config
    // priority-catalog runs locally over stdio from the agentic_fomprep clone:
    //   node <clone>\v2\apps\mcp-catalog\stdio.mjs   (the repo's own stdio entry point, no npm install needed)
    // Fallback while the clone lacks stdio.mjs or node is missing: this exe's built-in port (--mcp-catalog),
    // which serves the same <clone>\v2\apps\mcp-catalog\catalog. Any other registration (e.g. a remote URL) is replaced.
    static void EnsureGrokMcp(string grok, string fomprep)
    {
        string script = Path.Combine(fomprep, "v2", "apps", "mcp-catalog", "stdio.mjs");
        string exe = Environment.ProcessPath ?? Path.Combine(AppContext.BaseDirectory, "PriorityAgent.exe");
        string seen = "";
        string? node = File.Exists(script) ? FindNode(out seen) : null;
        string[] cmd;
        if (node != null) cmd = new[] { node, script };
        else
        {
            cmd = new[] { exe, "--mcp-catalog" };   // grok mcp add priority-catalog -- exe --mcp-catalog
            Warn(!File.Exists(script) ? $"{script} not in the clone; using PriorityAgent.exe --mcp-catalog for priority-catalog"
                                      : $"no node >= 18 found ({seen}); using PriorityAgent.exe --mcp-catalog for priority-catalog");
        }
        string want = string.Join(' ', cmd);
        var (rc, outp, _) = Capture(grok, null, "mcp", "list");
        string line = outp.Split('\n').Select(l => l.Trim()).FirstOrDefault(l => l.StartsWith(McpName + ":", StringComparison.OrdinalIgnoreCase)) ?? "";
        string current = line == "" ? "" : line[(McpName.Length + 1)..].Trim();
        bool good = current.Equals(want, StringComparison.OrdinalIgnoreCase);
        if (good) Check(true, $"MCP '{McpName}' registered (stdio): {current}");
        else if (DryRun) { Info($"would run: grok mcp add {McpName} -- {want}   (currently: {(current == "" ? "not registered" : current)})"); return; }
        else
        {
            var a = new List<string> { "mcp", "add", McpName, "--" }; a.AddRange(cmd);
            int arc = RunTo(grok, null, a.ToArray());
            Check(arc == 0, $"registered MCP '{McpName}' (stdio) -> {want}{(current == "" ? "" : $" (replaced: {current})")}");
        }
        if (DryRun && !good) return;
        var (drc, dout, derr) = Capture(grok, null, "mcp", "doctor", McpName);
        string d = (dout + derr).Trim();
        int sec = d.IndexOf(McpName + " (", StringComparison.OrdinalIgnoreCase);
        if (sec >= 0) d = d[sec..];
        bool ok = drc == 0 && d.Contains("handshake OK", StringComparison.OrdinalIgnoreCase) && !d.Contains("handshake failed", StringComparison.OrdinalIgnoreCase);
        Check(ok, $"grok mcp doctor {McpName}: " + Trunc(Regex.Replace(d, @"\s+", " "), 300));
    }

    // stdio.mjs needs Node 18+ (ES modules, node: imports). MarchHare's PATH node is v8, so check versions.
    static string? FindNode(out string seen)
    {
        var cands = new List<string>();
        string? env = Environment.GetEnvironmentVariable("PRIORITY_AGENT_NODE");
        if (!string.IsNullOrEmpty(env)) cands.Add(env);
        foreach (var root in new[] { @"D:\tools\node", @"C:\tools\node" })
            try { if (Directory.Exists(root)) cands.AddRange(Directory.EnumerateFiles(root, "node.exe", new EnumerationOptions { RecurseSubdirectories = true, MaxRecursionDepth = 2 })); } catch { }
        foreach (var d in (Environment.GetEnvironmentVariable("PATH") ?? "").Split(Path.PathSeparator))
            try { string f = Path.Combine(d.Trim('"'), "node.exe"); if (File.Exists(f)) cands.Add(f); } catch { }
        cands.Add(@"C:\Program Files\nodejs\node.exe"); cands.Add(@"D:\Program Files\nodejs\node.exe");
        var notes = new List<string>();
        foreach (var c in cands.Distinct(StringComparer.OrdinalIgnoreCase))
        {
            if (!File.Exists(c)) continue;
            string v = "";
            try { v = Capture(c, null, "--version").Item2.Trim(); } catch { }
            notes.Add($"{c} {v}");
            if (v.StartsWith("v") && int.TryParse(v[1..].Split('.')[0], out int major) && major >= 18) { seen = string.Join("; ", notes); return c; }
        }
        seen = notes.Count == 0 ? "none" : string.Join("; ", notes);
        return null;
    }

    static string FindCatalogDir()
    {
        foreach (var root in SearchRoots.Prepend(CloneRoot).Distinct(StringComparer.OrdinalIgnoreCase))
        {
            string c = Path.Combine(root, FomprepRepo, "v2", "apps", "mcp-catalog", "catalog");
            if (Directory.Exists(c)) return c;
        }
        return Path.Combine(CloneRoot, FomprepRepo, "v2", "apps", "mcp-catalog", "catalog");
    }

    static void EnsureGrokSkillsPath(string skillsDir)
    {
        string cfg = Path.Combine(Home, ".grok", "config.toml");
        string want = skillsDir.Replace('\\', '/');
        string text = File.Exists(cfg) ? File.ReadAllText(cfg) : "";
        if (text.Replace('\\', '/').Replace("//", "/").Contains(want, StringComparison.OrdinalIgnoreCase))
        { Check(true, $"skills path in {cfg}: {want}"); return; }

        string nl = text.Contains("\r\n") ? "\r\n" : "\n";
        string? updated = null;
        var hdr = Regex.Match(text, @"^[ \t]*\[skills\][ \t]*\r?$", RegexOptions.Multiline);
        if (!hdr.Success)
            updated = text.TrimEnd() + nl + nl + "[skills]" + nl + $"paths = [\"{want}\"]" + nl;
        else
        {
            int start = hdr.Index + hdr.Length;
            var nextHdr = Regex.Match(text[start..], @"^[ \t]*\[", RegexOptions.Multiline);
            int end = nextHdr.Success ? start + nextHdr.Index : text.Length;
            string section = text[start..end];
            var pl = Regex.Match(section, @"^([ \t]*paths[ \t]*=[ \t]*\[)(.*)\][ \t]*\r?$", RegexOptions.Multiline);
            if (pl.Success)
            {
                string inner = pl.Groups[2].Value.Trim();
                string newLine = pl.Groups[1].Value + (inner.Length > 0 ? inner.TrimEnd(',') + ", " : "") + $"\"{want}\"]";
                updated = text[..(start + pl.Index)] + newLine + text[(start + pl.Index + pl.Length)..];
            }
            else if (!Regex.IsMatch(section, @"^[ \t]*paths[ \t]*=", RegexOptions.Multiline))
                updated = text[..start] + nl + $"paths = [\"{want}\"]" + text[start..];
        }
        if (updated == null)
        { Warn($"{cfg} has a multi-line [skills] paths; add \"{want}\" to it by hand."); Fails++; return; }
        if (DryRun) { Info($"would add skills path \"{want}\" to {cfg} (backup first)"); return; }
        if (File.Exists(cfg)) File.Copy(cfg, cfg + $".bak-priorityagent-{DateTime.Now:yyyyMMddHHmmss}");
        File.WriteAllText(cfg, updated);
        Check(true, $"added skills path \"{want}\" to {cfg} (backup kept)");
    }

    static void GrokInspect(string grok, string workDir)
    {
        var (rc, outp, _) = Capture(grok, workDir, "inspect");
        Check(rc == 0 && outp.Contains("priority-", StringComparison.OrdinalIgnoreCase), "grok inspect sees priority-* skills");
        Check(rc == 0 && outp.Contains(McpName, StringComparison.OrdinalIgnoreCase), $"grok inspect sees MCP '{McpName}'");
    }

    static void FuelCheck()
    {
        try
        {
            using var http = new HttpClient { Timeout = TimeSpan.FromSeconds(8) };
            using var doc = JsonDocument.Parse(http.GetStringAsync(FuelUrl).GetAwaiter().GetResult());
            string m = Environment.MachineName.ToLowerInvariant();
            if (doc.RootElement.TryGetProperty("machines", out var ms) && ms.TryGetProperty(m, out var me)
                && me.TryGetProperty("pcent", out var pc) && pc.TryGetProperty("grok-chat", out var g) && g.ValueKind == JsonValueKind.Number)
            {
                double v = g.GetDouble();
                if (v > 0) { Check(true, $"fuel: grok-chat {v}% on {m} -> pool"); return; }
                Warn($"fuel: grok-chat is 0% on {m} (pool empty). Grok may need a session key; the launcher never handles keys.");
            }
            else Warn($"fuel: no grok-chat figure for {m} in the Bob report (unknown).");
        }
        catch (Exception ex) { Warn("fuel: Bob report unavailable (" + ex.Message + ")"); }
        if (!DryRun && !Smoke && !Console.IsInputRedirected && !Ask("Continue anyway? [y/N]: ").StartsWith("y", StringComparison.OrdinalIgnoreCase))
            throw new Exception("stopped: no grok fuel");
    }

    static int RulesVersion(string text)
    {
        var m = Regex.Match(text, @"rules-version:\s*(\d+)");
        return m.Success ? int.Parse(m.Groups[1].Value) : 1;
    }

    // Use launcher/agent-rules.md from the clone when it is at least as new as the embedded copy.
    static string LoadRules(string fomprep, out string src)
    {
        using var s = Assembly.GetExecutingAssembly().GetManifestResourceStream("agent-rules.md")!;
        string embedded = new StreamReader(s).ReadToEnd();
        string f = Path.Combine(fomprep, "launcher", "agent-rules.md");
        if (File.Exists(f))
        {
            string clone = File.ReadAllText(f);
            if (RulesVersion(clone) >= RulesVersion(embedded)) { src = $"{f} (v{RulesVersion(clone)})"; return clone; }
            Warn($"{f} is v{RulesVersion(clone)}, older than the embedded v{RulesVersion(embedded)}; using embedded rules.");
        }
        src = $"embedded agent-rules.md (v{RulesVersion(embedded)})";
        return embedded;
    }

    // ------------------------------------------------------------------ Haitch handoff
    static int Haitch(string what)
    {
        string msg = "Ask Haitch: " + what;
        Header("Needs Haitch");
        Console.WriteLine("  " + msg);
        Console.WriteLine("  The launcher does not create customer repos or project folders. Haitch does.");
        Console.WriteLine("  Customer setup template: launcher/customer-setup (SC/SO folder, project.md, webhook hours).");
        Console.WriteLine("  Run the launcher again once it exists.");
        try
        {
            var psi = new ProcessStartInfo("clip.exe") { RedirectStandardInput = true, UseShellExecute = false, CreateNoWindow = true };
            using var p = Process.Start(psi)!; p.StandardInput.Write(msg); p.StandardInput.Close(); p.WaitForExit(3000);
            Console.WriteLine("  (copied to clipboard)");
        }
        catch { }
        Log(msg);
        Pause();
        return 3;
    }

    // ------------------------------------------------------------------ helpers
    static string? Which(string exe, string? testOverride, params string[] known)
    {
        if (!string.IsNullOrWhiteSpace(testOverride) && File.Exists(testOverride)) return testOverride;
        foreach (var k in known) if (File.Exists(k)) return k;
        foreach (var d in (Environment.GetEnvironmentVariable("PATH") ?? "").Split(Path.PathSeparator))
        {
            try { string f = Path.Combine(d.Trim('"'), exe); if (File.Exists(f)) return f; } catch { }
        }
        return null;
    }

    static (int, string, string) Capture(string exe, string? cwd, params string[] args)
    {
        var psi = new ProcessStartInfo(exe) { RedirectStandardOutput = true, RedirectStandardError = true, UseShellExecute = false, CreateNoWindow = true,
            StandardOutputEncoding = Encoding.UTF8, StandardErrorEncoding = Encoding.UTF8 };
        if (cwd != null) psi.WorkingDirectory = cwd;
        foreach (var a in args) psi.ArgumentList.Add(a);
        psi.Environment["GIT_TERMINAL_PROMPT"] = "0";
        using var p = Process.Start(psi)!;
        var so = p.StandardOutput.ReadToEndAsync(); var se = p.StandardError.ReadToEndAsync();
        p.WaitForExit();
        Log($"$ {Path.GetFileName(exe)} {string.Join(' ', args.Select(Quote))} -> {p.ExitCode}");
        return (p.ExitCode, so.Result, se.Result);
    }

    static int RunTo(string exe, string? cwd, params string[] args)
    {
        var (rc, o, e) = Capture(exe, cwd, args);
        if (!string.IsNullOrWhiteSpace(o)) Log(o.Trim());
        if (rc != 0 && !string.IsNullOrWhiteSpace(e)) { Warn(e.Trim()); }
        return rc;
    }

    static string GitOut(string dir, params string[] args) => Capture(Git, dir, args).Item2.Trim();

    static string Quote(string a) => a.Length > 0 && !a.Any(c => char.IsWhiteSpace(c) || c == '"') ? a : "\"" + a.Replace("\"", "\\\"") + "\"";
    static string Trunc(string s, int n) => s.Length <= n ? s : s[..(n - 1)] + "…";

    static void EnsureCommandLineSize(string executable, IEnumerable<string> args, string operation)
    {
        LauncherSupport.ValidateWindowsCommandLine(executable, args, operation);
    }

    /// <summary>Issue #569 / FR-004: MSI-style none / one / many / refuse chooser (no download).</summary>
    static CliChooserResult ChooseAgentCli(IReadOnlyList<FoundCli> installed)
    {
        AgentCliKind? pick = null;
        bool? installNow = null;
        for (int i = 0; i < 8; i++)
        {
            var result = CliChooser.Decide(installed, Console.IsInputRedirected, pick, installNow);
            switch (result.Action)
            {
                case CliChooserAction.Launch:
                case CliChooserAction.Refuse:
                    return result;
                case CliChooserAction.OfferZeroMenu:
                    Info(result.Message);
                    pick = CliChooser.ParsePick(Ask("Grok / Cursor / OpenCode / refuse: "));
                    break;
                case CliChooserAction.OfferWhich:
                    Info(result.Message);
                    pick = CliChooser.ParsePick(Ask("Which CLI to launch? "));
                    break;
                case CliChooserAction.AskInstallNow:
                    Info(result.Message);
                    string ans = Ask(CliChooser.InstallNowPrompt + " [y/N]: ");
                    installNow = ans.StartsWith("y", StringComparison.OrdinalIgnoreCase);
                    break;
            }
        }
        return CliChooser.Decide(installed, true, AgentCliKind.Refuse, false);
    }

    static CliKind ToCliKind(AgentCliKind kind) => kind switch
    {
        AgentCliKind.Cursor => CliKind.Cursor,
        AgentCliKind.OpenCode => CliKind.OpenCode,
        _ => CliKind.Grok,
    };

    static string Ask(string prompt)
    {
        Console.Write(prompt);
        return (Console.ReadLine() ?? "").Trim();
    }

    static void Pause()
    {
        if (NoPause || Console.IsInputRedirected) return;
        Console.Write("\nPress Enter to close...");
        Console.ReadLine();
    }

    static void Check(bool ok, string what)
    {
        if (!ok) Fails++;
        Color(ok ? ConsoleColor.Green : ConsoleColor.Red, $"  [{(ok ? "PASS" : "FAIL")}] {what}");
    }

    static void Summary() => Color(Fails == 0 ? ConsoleColor.Green : ConsoleColor.Red, $"\nRESULT: {(Fails == 0 ? "PASS" : $"{Fails} FAIL(S)")}  (log: {LogFile})");
    static void Header(string s) => Color(ConsoleColor.Cyan, "\n" + s);
    static void Info(string s) { Console.WriteLine("  " + s.Replace("\n", "\n  ")); Log(s); }
    static void Warn(string s) => Color(ConsoleColor.Yellow, "  WARN " + s);
    static void Err(string s) => Color(ConsoleColor.Red, "  ERROR " + s);

    static void Color(ConsoleColor c, string s)
    {
        var old = Console.ForegroundColor; Console.ForegroundColor = c; Console.WriteLine(s); Console.ForegroundColor = old; Log(s.Trim());
    }

    static void Log(string s)
    {
        if (LogFile == "") return;
        try { File.AppendAllText(LogFile, $"{DateTime.Now:HH:mm:ss} {s}{Environment.NewLine}"); } catch { }
    }

    static void Help() => Console.WriteLine(@"
PriorityAgent.exe [options]

  (no options)          interactive: pick customer/project, then MSI-style CLI chooser
  --list                list customer repos (topic priority-customer); with --customer, also list its folders
  --general             general Priority context (no customer)
  --customer <repo>     pick customer non-interactively (e.g. rees)
  --project <folder>    pick project / service-call folder (needs --customer)
  --dry-run             do everything except change grok config / customer clones and start the agent;
                        prints the exact grok command line
  --smoke               real setup + one brief single-turn Grok launch that makes no changes
  --root <dir>          clone root for repos new to this machine (default: first existing X:\AI on C->D->E..Z,
                        else create \AI on the first ready drive in that order; env PRIORITY_AGENT_ROOT)
  --no-fuel-check       skip the Bob fuel report check
  --no-pause            don't wait for Enter before closing
  --passwords-dir <dir> where <repo>-connections.txt lives (<repo> = GitHub repo name, lowercase) (default C:\passwords, env PRIORITY_AGENT_PASSWORDS);
                        the launcher only checks the file exists, never reads it
  --check-hours <ignored-repo-dir> --session <full uuid>
                        webhook hours gate for that session (not a git hours ref)
  --hours-user <USERLOGIN>
                        Priority USERLOGIN for this launch only. When stdin is redirected,
                        a saved last-user row for the selected WCF instance is used if this
                        flag is omitted; otherwise exit 2 (Priority USERLOGIN unavailable).
                        Not read from the OS user. An existing session keeps identity.json.
  --hours-entry-id <h_...>
                        persisted receiver id (else hours-entry.json or PRIORITY_AGENT_HOURS_ENTRY_ID)
  --cli grok|cursor|opencode
                        which agent CLI to start (env PRIORITY_AGENT_CLI). When
                        omitted, issue #569 chooser: none/one/many/refuse; redirected
                        stdin never prompts or downloads. Grok keeps RunGrok + MCP.
                        Cursor uses %LOCALAPPDATA%\cursor-agent\agent.cmd (never
                        Cursor.exe GUI or .grok\bin\agent.exe). OpenCode uses a
                        standalone opencode.exe. Cursor/OpenCode never get Grok
                        MCP flags; --help is read first, else work-dir only.
                        Hours relaunch always uses the same chosen CLI.
  PRIORITY_AGENT_HOURS_JSON
                        fixture file for the list body; when set, no HTTP request is made
");
}
