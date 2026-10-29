// Priority Agent launcher - starts a Grok coding agent for Priority ERP work.
// Always fast-forwards SimonBarnett/agentic_fomprep and loads its MCP + skills,
// then lets you pick general / customer / project context and optional airc support.
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
    const string FuelUrl = "https://irc.ntsa.uk/bob/v1/report";

    static bool DryRun, ListOnly, Smoke, General, NoPause, NoFuel;
    static bool? AircArg;
    static string? CustomerArg, ProjectArg, CheckHoursDir, SessionArg;
    static string? AircConsoleArg;
    static string CloneRoot = Environment.GetEnvironmentVariable("PRIORITY_AGENT_ROOT") ?? @"D:\ai";
    static string PasswordsDir = Environment.GetEnvironmentVariable("PRIORITY_AGENT_PASSWORDS") ?? @"C:\passwords";
    static readonly string[] SearchRoots = { @"D:\ai", @"C:\ai", @"D:\repos", @"C:\repos" };
    static string LogFile = "";
    static int Fails;

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
                case "--root": CloneRoot = Next(); break;
                case "--no-pause": NoPause = true; break;
                case "--no-fuel-check": NoFuel = true; break;
                case "--airc": AircArg = true; break;
                case "--no-airc": AircArg = false; break;
                case "--airc-console": AircConsoleArg = Next(); break;
                case "--passwords-dir": PasswordsDir = Next(); break;
                case "--check-hours": CheckHoursDir = Next(); break;
                case "--session": SessionArg = Next(); break;
                case "-h": case "--help": case "/?": Help(); return 0;
                default: Err($"Unknown argument: {args[i]}"); Help(); return 2;
            }
        }
        if (AircArg.HasValue && AircConsoleArg != null && !AircArg.Value)
        { Err("--airc-console cannot be combined with --no-airc."); return 2; }
        if (ListOnly || DryRun || Smoke || CustomerArg != null || General) NoPause |= Console.IsInputRedirected;

        string localAppData = Environment.GetEnvironmentVariable("LOCALAPPDATA")
            ?? Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
        string logDir = Path.Combine(localAppData, "PriorityAgent", "logs");
        Directory.CreateDirectory(logDir);
        LogFile = Path.Combine(logDir, $"launcher-{DateTime.Now:yyyyMMdd}.log");
        try { Console.Title = "Priority Agent"; } catch { }

        Header($"Priority Agent launcher {Assembly.GetExecutingAssembly().GetName().Version}  " +
               (DryRun ? "[DRY RUN] " : "") + (ListOnly ? "[LIST] " : "") + (Smoke ? "[SMOKE] " : ""));
        string logArgs = string.Join(' ', args);
        if (AircConsoleArg != null) logArgs = logArgs.Replace(AircConsoleArg, "<airc-console>", StringComparison.OrdinalIgnoreCase);
        Log($"=== start args: {logArgs}");

        string? git = Which("git.exe", Environment.GetEnvironmentVariable("PRIORITY_AGENT_TEST_GIT"),
            @"C:\Program Files\Git\cmd\git.exe", @"D:\Program Files\Git\cmd\git.exe");
        string? gh = Which("gh.exe", Environment.GetEnvironmentVariable("PRIORITY_AGENT_TEST_GH"),
            @"C:\Program Files\GitHub CLI\gh.exe", @"D:\Program Files\GitHub CLI\gh.exe");
        string? grok = Which("grok.exe", Environment.GetEnvironmentVariable("PRIORITY_AGENT_TEST_GROK"),
            Path.Combine(Home, ".grok", "bin", "grok.exe"));
        Info($"git : {git ?? "MISSING"}\ngh  : {gh ?? "MISSING"}\ngrok: {grok ?? "MISSING"}");
        if (git == null || gh == null) { Err("git and gh are required."); Pause(); return 1; }
        Git = git; Gh = gh;

        if (CheckHoursDir != null)
        {
            if (SessionArg == null) { Err("--check-hours needs --session <id or short tag>"); return 2; }
            Header($"Hours check: {CheckHoursDir} session:{Short(SessionArg)}");
            bool ok = HoursCheck(CheckHoursDir, Short(SessionArg), new[] { DateTime.Now }, out string det);
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
        }
        if (ListOnly) { Summary(); Pause(); return Fails == 0 ? 0 : 1; }

        // ---- 3b. optional airc context -----------------------------------------------
        AircConfig aircConfig = AircSupport.LoadConfig(projectDir, custDir);
        bool interactiveAirc = !Console.IsInputRedirected && !Smoke;
        string? aircPromptAnswer = null;
        bool airc = AircSupport.ResolveEnabled(AircArg, AircConsoleArg != null, aircConfig.Enabled,
            interactiveAirc, configured =>
            {
                bool defaultValue = configured ?? false;
                string suffix = defaultValue ? " [Y/n]: " : " [y/N]: ";
                aircPromptAnswer = Ask("Does this session need airc?" + suffix);
                return aircPromptAnswer == "" ? defaultValue : aircPromptAnswer.StartsWith("y", StringComparison.OrdinalIgnoreCase);
            });
        string aircDecisionSource = AircConsoleArg != null ? "--airc-console"
            : AircArg.HasValue ? (AircArg.Value ? "--airc" : "--no-airc")
            : interactiveAirc && !string.IsNullOrEmpty(aircPromptAnswer) ? "prompt"
            : aircConfig.EnabledSource ?? (interactiveAirc ? "prompt" : "default");
        Console.WriteLine($"airc: {(airc ? "yes" : "no")} (from {aircDecisionSource})");
        Log($"airc decision: {(airc ? "yes" : "no")} (from {aircDecisionSource})");
        string? aircConsole = null;
        bool aircConsoleVerified = true;
        string aircConsoleSource = "";
        if (airc)
        {
            AircConsoleDiscoveryResult discovery = DiscoverConnectedAircConsoles();
            if (!AircSupport.TrySelectListedConsole(airc, discovery, aircConfig.Console, AircConsoleArg,
                interactiveAirc, AskAircConsole, out aircConsole, out string discoveryError))
            {
                Warn($"airc: {discoveryError}");
                if (!ContinueWithoutAirc(interactiveAirc)) { Pause(); return 1; }
                airc = false;
                Console.WriteLine("airc: no (continuing without airc)");
            }
            else if (discoveryError.StartsWith("console not verified:", StringComparison.Ordinal))
            {
                aircConsoleVerified = false;
                aircConsoleSource = AircConsoleArg != null ? "--airc-console"
                    : aircConfig.ConsoleSource ?? "configuration";
                Info($"airc: using {aircConsole} ({discoveryError})");
            }
            else Console.WriteLine($"airc: using {aircConsole}");
        }

        // ---- 4. grok: register MCP + skills, build brief, launch ----------------------
        Header("[4] Agent (Grok)");
        if (grok == null) { Err("grok CLI not found (expected %USERPROFILE%\\.grok\\bin\\grok.exe)."); Pause(); return 1; }
        EnsureGrokMcp(grok, fomprep);
        EnsureGrokSkillsPath(skillsDir);
        WarnIfGlobalAircSkillsPath();
        if (!NoFuel) FuelCheck();

        string[] aircSkills = Array.Empty<string>();
        string aircSource = "";
        if (airc && aircConsole != null)
        {
            try { (aircSkills, aircSource) = LoadAircSkills(gh); }
            catch (Exception ex)
            {
                Warn("airc skills unavailable (" + ex.Message + ")");
                if (!ContinueWithoutAirc(interactiveAirc)) { Pause(); return 1; }
                airc = false;
                aircConsole = null;
                Console.WriteLine("airc: no (continuing without airc)");
            }
        }

        string level = projectDir != null ? "project" : cust != null ? "customer" : "general";
        string workDir = projectDir ?? custDir ?? fomprep;
        string sessionId = Guid.NewGuid().ToString();
        string sessShort = Short(sessionId);
        DateTime launchedAt = DateTime.Now;
        string hoursRepoDir = custDir ?? fomprep;
        string hoursRepo = cust?.FullName ?? $"{Owner}/{FomprepRepo}";
        string hoursWt = Path.Combine(Path.GetDirectoryName(hoursRepoDir)!, Path.GetFileName(hoursRepoDir) + "-hours");
        string pwFile = cust != null ? Path.Combine(PasswordsDir, $"{cust.Name.ToLowerInvariant()}-connections.txt") : Path.Combine(PasswordsDir, "<repo>-connections.txt");
        var vars = new Dictionary<string, string>
        {
            ["LEVEL"] = level, ["FOMPREP_DIR"] = fomprep, ["WORK_DIR"] = workDir,
            ["CUSTOMER"] = cust?.Name ?? "(none - general Priority)", ["CUSTOMER_REPO"] = cust?.FullName ?? "(none)",
            ["CUSTOMER_DIR"] = custDir ?? "(none)", ["PROJECT"] = project ?? "(none)", ["PROJECT_DIR"] = projectDir ?? "(none - ask Simon)",
            ["PASSWORDS_FILE"] = pwFile, ["SESSION"] = sessionId, ["SESSION_SHORT"] = sessShort,
            ["HOURS_REPO"] = hoursRepo, ["HOURS_REPO_DIR"] = hoursRepoDir, ["HOURS_WORKTREE"] = hoursWt,
            ["TODAY"] = launchedAt.ToString("yyyy-MM-dd"),
        };
        string rules = LoadRules(fomprep, out string rulesSrc);
        string sessDir = Path.Combine(Path.GetDirectoryName(logDir)!, "sessions");
        string sessionDir = Path.Combine(sessDir, sessionId);
        Directory.CreateDirectory(sessionDir);
        AircSessionFiles? aircFiles = null;
        if (airc && aircConsole != null)
            aircFiles = AircSupport.WriteSessionFiles(sessionDir, aircSkills, ReadResource("airc-dcc.md"), aircConsole);
        rules = AircSupport.RenderSessionRules(rules, airc && aircConsole != null, aircConsole,
            aircSource, aircFiles, aircConsoleVerified, aircConsoleSource);
        foreach (var kv in vars) rules = rules.Replace("{{" + kv.Key + "}}", kv.Value);
        Info($"rules: {rulesSrc} ({rules.Length} chars)");
        if (cust != null)
        {
            bool connectionsExist = AircSupport.ConnectionFileExists(pwFile);
            Check(connectionsExist, AircSupport.ConnectionFileStatus(cust.Name, pwFile, connectionsExist));
        }
        Info($"hours: {hoursRepo} branch 'hours' -> hours/{launchedAt:yyyy-MM-dd}.md, tag session:{sessShort} (mandatory; checked on exit)");

        var brief = new StringBuilder();
        brief.AppendLine($"Priority agent session {sessionId} (launched {DateTime.Now:yyyy-MM-dd HH:mm} on {Environment.MachineName}).");
        brief.AppendLine($"Context level: {level}. Working directory: {workDir}.");
        brief.AppendLine($"General Priority repo: {fomprep} (SimonBarnett/agentic_fomprep @ {GitOut(fomprep, "rev-parse", "--short", "HEAD")}); MCP server '{McpName}' and its .grok/skills are loaded.");
        if (airc && aircConsole != null)
            brief.AppendLine($"Airc target: {aircConsole} in #{AircSupport.MachineFromConsole(aircConsole)}. Send remote shell commands only to this selected console; use the loaded airc and DCC guidance.");
        if (cust != null) brief.AppendLine($"Customer: {cust.Name} = {cust.FullName}, clone {custDir}. Connection secrets (never commit/echo): {pwFile}.");
        if (project != null) brief.AppendLine($"Project / service call: {project} at {projectDir}.");
        var readFirst = new List<string> { Path.Combine(fomprep, "AGENTS.md") };
        if (custDir != null) readFirst.AddRange(new[] { Path.Combine(custDir, "AGENTS.md"), Path.Combine(custDir, "README.md") });
        if (projectDir != null) readFirst.AddRange(new[] { Path.Combine(projectDir, "README.md"), Path.Combine(projectDir, "log.md") });
        brief.AppendLine("Read first (those that exist): " + string.Join("; ", readFirst));
        brief.Append(Smoke
            ? "SMOKE TEST: do not read or change any file and do not contact any customer system. You may call the priority-catalog tool list_catalog once (read-only, local). Reply in at most 8 lines: the context level, customer, project; the priority-catalog tools you have and whether that server is connected (with the skill count list_catalog returned); whether Priority skills are visible; and what your launcher rules say about connecting to this customer's systems. Then stop."
            : $"Follow the launcher rules (harvest rule, secrets, MANDATORY hours with tag session:{sessShort} on the hours branch of {hoursRepo}). Then briefly confirm the context and ask Simon what to work on.");

        string rulesFile = Path.Combine(sessionDir, "rules.md");
        AircSupport.WriteSessionMetadata(sessionDir, rules, new
        { sessionId, level, customer = cust?.FullName, project, workDir, fomprep, grok, airc, aircConsole, dryRun = DryRun, smoke = Smoke, at = DateTime.Now });

        string hoursPrompt = $"HOURS NOT REPORTED. Priority agents MUST report their hours. Before anything else, write and push the hours lines for session {sessionId} now, " +
            $"following the launcher rules: at least one dev line and one test line (human-equivalent, each with an evidence link ending session:{sessShort}), appended to hours/YYYY-MM-DD.md " +
            $"on the 'hours' branch of {hoursRepo} (worktree {hoursWt}), from hours/_template.md. Push to origin hours, confirm, then stop.";
        var gargs = AircSupport.BuildGrokArguments(workDir, sessionId, rules, brief.ToString(), Smoke);
        var resumeArgs = new List<string> { "--cwd", workDir, "--resume", sessionId, "--trust", "--rules", rules, hoursPrompt };
        EnsureCommandLineSize(grok, gargs, "Grok launch");
        EnsureCommandLineSize(grok, resumeArgs, "Grok hours relaunch");
        string display = Quote(grok) + " " + string.Join(' ', gargs.Select(a => a == rules ? $"<rules: {rulesFile}>" : Quote(a)));
        Console.WriteLine("\nLaunch command:\n  " + display.Replace("\r\n", "\\n").Replace("\n", "\\n"));
        string logDisplay = display;
        if (aircConsole != null)
        {
            logDisplay = logDisplay.Replace(aircConsole, "<airc-console>", StringComparison.OrdinalIgnoreCase);
            string? machine = AircSupport.MachineFromConsole(aircConsole);
            if (machine != null) logDisplay = logDisplay.Replace("#" + machine, "<airc-channel>", StringComparison.OrdinalIgnoreCase);
        }
        Log("launch: " + logDisplay);
        Check(Directory.Exists(workDir), $"working directory exists: {workDir}");
        Console.WriteLine("Hours relaunch command (only if hours are missing on exit):\n  " + Quote(grok) + " " +
            string.Join(' ', resumeArgs.Select(a => a == rules ? $"<rules: {rulesFile}>" : Quote(a))));

        if (DryRun) { Info("Dry run: agent not started."); Summary(); Pause(); return Fails == 0 ? 0 : 1; }

        if (Smoke) GrokInspect(grok, workDir);
        Header(Smoke ? "Starting Grok (single-turn smoke)..." : "Starting Grok...");
        int code = RunGrok(grok, workDir, gargs);
        if (Smoke)
        {
            Check(code == 0, "smoke launch exit code 0");
            bool ok = HoursCheck(hoursRepoDir, sessShort, new[] { launchedAt, DateTime.Now }, out string det);
            Info($"hours enforcement probe (smoke writes no hours, so 'missing' is expected): {det}");
            Info(ok ? "hours present" : "-> a real session would now be relaunched with the hours prompt (--resume " + sessionId + ")");
            Summary(); Pause(); return code;
        }

        // ---- 5. mandatory hours ---------------------------------------------------------
        for (int attempt = 1; ; attempt++)
        {
            Header("[5] Hours check (mandatory)");
            if (HoursCheck(hoursRepoDir, sessShort, new[] { launchedAt, DateTime.Now }, out string det)) { Check(true, det); break; }
            Color(ConsoleColor.Red, "\n  ################################################################");
            Color(ConsoleColor.Red, "  ##  HOURS NOT REPORTED - Priority agents MUST report their hours ##");
            Color(ConsoleColor.Red, "  ################################################################");
            Color(ConsoleColor.Red, "  " + det);
            try { Console.Beep(); } catch { }
            if (Console.IsInputRedirected) { Fails++; Err("non-interactive: cannot relaunch for hours."); break; }
            string ans = Ask($"Relaunching the agent to report hours (attempt {attempt}). Press Enter to continue (type SKIP to override, it gets logged): ");
            if (ans == "SKIP") { Log($"HOURS OVERRIDE: session {sessionId} closed without hours by user"); Warn("hours skipped by override; logged."); Fails++; break; }
            code = RunGrok(grok, workDir, resumeArgs);
        }
        Pause();
        return code;
    }

    static int RunGrok(string grok, string workDir, List<string> gargs)
    {
        var psi = new ProcessStartInfo(grok) { UseShellExecute = false, WorkingDirectory = workDir };
        foreach (var a in gargs) psi.ArgumentList.Add(a);
        using var p = Process.Start(psi)!;
        p.WaitForExit();
        Log($"grok exit {p.ExitCode}");
        Info($"Grok exited ({p.ExitCode}).");
        return p.ExitCode;
    }

    static string Short(string session) => session.Replace("-", "")[..Math.Min(8, session.Replace("-", "").Length)].ToLowerInvariant();

    // Today's hours file on origin/hours must have a dev line and a test line tagged session:<short>, each with evidence.
    static bool HoursCheck(string repoDir, string sessShort, IEnumerable<DateTime> days, out string detail)
    {
        int frc = RunTo(Git, repoDir, "fetch", "--quiet", "origin", "+refs/heads/hours:refs/remotes/origin/hours");
        if (frc != 0) { detail = $"no 'hours' branch on origin for {repoDir} (or fetch failed)"; return false; }
        string tag = "session:" + sessShort;
        var files = new List<string>();
        bool dev = false, test = false; int lines = 0;
        foreach (var d in days.Select(x => x.ToString("yyyy-MM-dd")).Distinct())
        {
            var (rc, txt, _) = Capture(Git, repoDir, "show", $"origin/hours:hours/{d}.md");
            if (rc != 0) continue;
            files.Add($"hours/{d}.md");
            foreach (var raw in txt.Split('\n'))
            {
                string l = raw.Trim();
                if (!l.StartsWith('|') || !l.Contains(tag, StringComparison.OrdinalIgnoreCase)) continue;
                var c = l.Trim('|').Split('|').Select(x => x.Trim()).ToArray();
                if (c.Length < 6 || !decimal.TryParse(c[3], System.Globalization.NumberStyles.Number, System.Globalization.CultureInfo.InvariantCulture, out _)) continue;
                string evidence = Regex.Replace(c[5], Regex.Escape(tag), "", RegexOptions.IgnoreCase).Trim(' ', ',', ';', '-', '·');
                if (evidence.Length == 0) continue;
                lines++;
                if (c[2].Equals("dev", StringComparison.OrdinalIgnoreCase)) dev = true;
                if (c[2].Equals("test", StringComparison.OrdinalIgnoreCase)) test = true;
            }
        }
        if (files.Count == 0) { detail = $"no hours/{string.Join(" or ", days.Select(x => x.ToString("yyyy-MM-dd")).Distinct())}.md on origin/hours"; return false; }
        detail = $"{string.Join(",", files)} on origin/hours: {lines} line(s) tagged {tag} (dev:{(dev ? "yes" : "NO")}, test:{(test ? "yes" : "NO")})";
        return dev && test;
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

    static AircConsoleDiscoveryResult DiscoverConnectedAircConsoles()
    {
        var result = AircConsoleDiscovery.Discover();
        Log(result.Available
            ? $"airc console listing returned {result.Consoles.Count} console(s)"
            : "airc console listing unavailable: " + result.Error);
        return result;
    }

    static bool ContinueWithoutAirc(bool interactive) =>
        !interactive || !Ask("Continue without airc? [Y/n]: ").StartsWith("n", StringComparison.OrdinalIgnoreCase);

    static string? AskAircConsole(IReadOnlyList<string> consoles, string? preferred)
    {
        for (int i = 0; i < consoles.Count; i++)
            Console.WriteLine($"  {i + 1,2}. {consoles[i]}{(consoles[i].Equals(preferred, StringComparison.OrdinalIgnoreCase) ? " (configured)" : "")}");
        string? defaultNick = preferred ?? (consoles.Count == 1 ? consoles[0] : null);
        string defaultText = defaultNick == null ? "" : $" (Enter={defaultNick})";
        string answer = Ask($"Pick airc console [1-{consoles.Count}]{defaultText}: ");
        if (answer == "" && defaultNick != null) return defaultNick;
        if (int.TryParse(answer, out int index) && index >= 1 && index <= consoles.Count) return consoles[index - 1];
        return consoles.FirstOrDefault(x => x.Equals(answer, StringComparison.OrdinalIgnoreCase));
    }

    const string AircSkillsCommit = "7372500933ba10c725219334a33e4bba41f1eca8";
    static readonly string[] AircSkillPaths =
    {
        "airc/.grok/skills/bobiverse-airc-commands/SKILL.md",
        "airc/.grok/skills/bobiverse-airc/SKILL.md",
    };

    static (string[] Content, string Source) LoadAircSkills(string gh)
    {
        string? clone = FindAircClone();
        string sha;
        string[] contents;
        if (clone != null)
        {
            sha = GitOut(clone, "rev-parse", "HEAD");
            contents = AircSkillPaths.Select(p => File.ReadAllText(Path.Combine(clone, p.Replace('/', Path.DirectorySeparatorChar)))).ToArray();
            Info($"Airc skills source: local SimonBarnett/bobiverse @ {sha}");
        }
        else
        {
            sha = AircSkillsCommit;
            contents = AircSkillPaths.Select(p => FetchAircSkill(gh, p, sha)).ToArray();
            Info($"Airc skills source: GitHub SimonBarnett/bobiverse @ {sha}");
        }
        if (contents.Any(string.IsNullOrWhiteSpace))
            throw new InvalidDataException("Airc skill content is empty");
        return (contents, clone == null ? $"GitHub @ {sha}" : $"local @ {sha}");
    }

    static string? FindAircClone()
    {
        foreach (string root in SearchRoots.Prepend(CloneRoot).Distinct(StringComparer.OrdinalIgnoreCase))
        {
            string path = Path.Combine(root, "bobiverse");
            if (!Directory.Exists(Path.Combine(path, ".git"))) continue;
            if (GitOut(path, "remote", "get-url", "origin").Contains("SimonBarnett/bobiverse", StringComparison.OrdinalIgnoreCase))
                return path;
        }
        return null;
    }

    static string FetchAircSkill(string gh, string path, string sha)
    {
        string endpoint = $"repos/SimonBarnett/bobiverse/contents/{path}?ref={sha}";
        var (rc, encoded, _) = Capture(gh, null, "api", endpoint, "--jq", ".content");
        if (rc != 0 || string.IsNullOrWhiteSpace(encoded))
            throw new IOException("GitHub read-only airc skill fetch failed");
        try { return Encoding.UTF8.GetString(Convert.FromBase64String(Regex.Replace(encoded, @"\s", ""))); }
        catch (FormatException) { throw new IOException("GitHub airc skill response was invalid"); }
    }

    static string ReadResource(string name)
    {
        using Stream? stream = Assembly.GetExecutingAssembly().GetManifestResourceStream(name);
        if (stream == null) throw new InvalidOperationException($"Embedded resource {name} is missing");
        return new StreamReader(stream).ReadToEnd();
    }

    static void WarnIfGlobalAircSkillsPath()
    {
        string cfg = Path.Combine(Home, ".grok", "config.toml");
        if (!File.Exists(cfg)) return;
        string text = File.ReadAllText(cfg).Replace('\\', '/');
        if (Regex.IsMatch(text, @"bobiverse/airc/\.grok/skills", RegexOptions.IgnoreCase))
            Warn($"global Grok config already lists a bobiverse airc skills path ({cfg}); launcher leaves it unchanged");
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
        AircSupport.ValidateWindowsCommandLine(executable, args, operation);
    }

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

  (no options)          interactive: pick customer and project, then start Grok
  --list                list customer repos (topic priority-customer); with --customer, also list its folders
  --general             general Priority context (no customer)
  --customer <repo>     pick customer non-interactively (e.g. rees)
  --project <folder>    pick project / service-call folder (needs --customer)
  --airc                enable airc for this session (overrides repo config)
  --no-airc             disable airc for this session (overrides repo config)
  --airc-console <nick> enable airc and select a connected *_console (overrides prompt/config)
  --dry-run             do everything except change grok config / customer clones and start the agent;
                        prints the exact grok command line
  --smoke               real setup + one brief single-turn Grok launch that makes no changes
  --root <dir>          clone root for repos new to this machine (default D:\ai, env PRIORITY_AGENT_ROOT)
  --no-fuel-check       skip the Bob fuel report check
  --no-pause            don't wait for Enter before closing
  --passwords-dir <dir> where <repo>-connections.txt lives (<repo> = GitHub repo name, lowercase) (default C:\passwords, env PRIORITY_AGENT_PASSWORDS);
                        the launcher only checks the file exists, never reads it
  --check-hours <repo> --session <id>
                        only run the mandatory hours check for a session against <repo>'s origin/hours
");
}
