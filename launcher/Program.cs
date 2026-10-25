// Priority Agent launcher - starts a Grok coding agent for Priority ERP work.
// Always fast-forwards SimonBarnett/agentic_fomprep and loads its MCP + skills,
// then lets you pick general / customer / project context.
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
    static string? CustomerArg, ProjectArg, CheckHoursDir, SessionArg;
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
                case "--passwords-dir": PasswordsDir = Next(); break;
                case "--check-hours": CheckHoursDir = Next(); break;
                case "--session": SessionArg = Next(); break;
                case "-h": case "--help": case "/?": Help(); return 0;
                default: Err($"Unknown argument: {args[i]}"); Help(); return 2;
            }
        }
        if (ListOnly || DryRun || Smoke || CustomerArg != null || General) NoPause |= Console.IsInputRedirected;

        string logDir = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData), "PriorityAgent", "logs");
        Directory.CreateDirectory(logDir);
        LogFile = Path.Combine(logDir, $"launcher-{DateTime.Now:yyyyMMdd}.log");
        try { Console.Title = "Priority Agent"; } catch { }

        Header($"Priority Agent launcher {Assembly.GetExecutingAssembly().GetName().Version}  " +
               (DryRun ? "[DRY RUN] " : "") + (ListOnly ? "[LIST] " : "") + (Smoke ? "[SMOKE] " : ""));
        Log($"=== start args: {string.Join(' ', args)}");

        string? git = Which("git.exe", @"C:\Program Files\Git\cmd\git.exe", @"D:\Program Files\Git\cmd\git.exe");
        string? gh = Which("gh.exe", @"C:\Program Files\GitHub CLI\gh.exe", @"D:\Program Files\GitHub CLI\gh.exe");
        string? grok = Which("grok.exe", Path.Combine(Home, ".grok", "bin", "grok.exe"));
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
        string fomprep = EnsureClone(FomprepRepo, $"{Owner}/{FomprepRepo}", "main", alwaysPull: true, preferClean: true)
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

        // ---- 4. grok: register MCP + skills, build brief, launch ----------------------
        Header("[4] Agent (Grok)");
        if (grok == null) { Err("grok CLI not found (expected %USERPROFILE%\\.grok\\bin\\grok.exe)."); Pause(); return 1; }
        EnsureGrokMcp(grok);
        EnsureGrokSkillsPath(skillsDir);
        if (!NoFuel) FuelCheck();

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
        foreach (var kv in vars) rules = rules.Replace("{{" + kv.Key + "}}", kv.Value);
        Info($"rules: {rulesSrc} ({rules.Length} chars)");
        if (cust != null) Check(File.Exists(pwFile), $"connections file for {cust.Name} {(File.Exists(pwFile) ? "exists" : "MISSING")}: {pwFile} (contents not read)");
        Info($"hours: {hoursRepo} branch 'hours' -> hours/{launchedAt:yyyy-MM-dd}.md, tag session:{sessShort} (mandatory; checked on exit)");

        var brief = new StringBuilder();
        brief.AppendLine($"Priority agent session {sessionId} (launched {DateTime.Now:yyyy-MM-dd HH:mm} on {Environment.MachineName}).");
        brief.AppendLine($"Context level: {level}. Working directory: {workDir}.");
        brief.AppendLine($"General Priority repo: {fomprep} (SimonBarnett/agentic_fomprep @ {GitOut(fomprep, "rev-parse", "--short", "HEAD")}); MCP server '{McpName}' and its .grok/skills are loaded.");
        if (cust != null) brief.AppendLine($"Customer: {cust.Name} = {cust.FullName}, clone {custDir}. Connection secrets (never commit/echo): {pwFile}.");
        if (project != null) brief.AppendLine($"Project / service call: {project} at {projectDir}.");
        var readFirst = new List<string> { Path.Combine(fomprep, "AGENTS.md") };
        if (custDir != null) readFirst.AddRange(new[] { Path.Combine(custDir, "AGENTS.md"), Path.Combine(custDir, "README.md") });
        if (projectDir != null) readFirst.AddRange(new[] { Path.Combine(projectDir, "README.md"), Path.Combine(projectDir, "log.md") });
        brief.AppendLine("Read first (those that exist): " + string.Join("; ", readFirst));
        brief.Append(Smoke
            ? "SMOKE TEST: do not read or change any file and do not contact any customer system. You may call the priority-catalog tool list_catalog once (read-only, local). Reply in at most 8 lines: the context level, customer, project; the priority-catalog tools you have and whether that server is connected (with the skill count list_catalog returned); whether Priority skills are visible; and what your launcher rules say about connecting to this customer's systems. Then stop."
            : $"Follow the launcher rules (harvest rule, secrets, MANDATORY hours with tag session:{sessShort} on the hours branch of {hoursRepo}). Then briefly confirm the context and ask Simon what to work on.");

        var gargs = new List<string> { "--cwd", workDir, "--session-id", sessionId, "--trust", "--rules", rules };
        if (Smoke) gargs.AddRange(new[] { "--max-turns", "4", "-p" });
        gargs.Add(brief.ToString());

        string sessDir = Path.Combine(Path.GetDirectoryName(logDir)!, "sessions");
        Directory.CreateDirectory(sessDir);
        string rulesFile = Path.Combine(sessDir, $"{sessionId}.rules.md");
        File.WriteAllText(rulesFile, rules);
        File.WriteAllText(Path.Combine(sessDir, $"{sessionId}.launch.json"), JsonSerializer.Serialize(new
        { sessionId, level, customer = cust?.FullName, project, workDir, fomprep, grok, dryRun = DryRun, smoke = Smoke, at = DateTime.Now }, new JsonSerializerOptions { WriteIndented = true }));

        string display = Quote(grok) + " " + string.Join(' ', gargs.Select(a => a == rules ? $"<rules: {rulesFile}>" : Quote(a)));
        Console.WriteLine("\nLaunch command:\n  " + display.Replace("\r\n", "\\n").Replace("\n", "\\n"));
        Log("launch: " + display);
        Check(Directory.Exists(workDir), $"working directory exists: {workDir}");

        string hoursPrompt = $"HOURS NOT REPORTED. Priority agents MUST report their hours. Before anything else, write and push the hours lines for session {sessionId} now, " +
            $"following the launcher rules: at least one dev line and one test line (human-equivalent, each with an evidence link ending session:{sessShort}), appended to hours/YYYY-MM-DD.md " +
            $"on the 'hours' branch of {hoursRepo} (worktree {hoursWt}), from hours/_template.md. Push to origin hours, confirm, then stop.";
        var resumeArgs = new List<string> { "--cwd", workDir, "--resume", sessionId, "--trust", "--rules", rules, hoursPrompt };
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
    static string Home => Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);

    static string? FindClone(string name, string fullName)
    {
        foreach (var root in SearchRoots.Prepend(CloneRoot).Distinct(StringComparer.OrdinalIgnoreCase))
        {
            string d = Path.Combine(root, name);
            if (!Directory.Exists(Path.Combine(d, ".git"))) continue;
            string url = GitOut(d, "remote", "get-url", "origin");
            if (url.Contains(fullName, StringComparison.OrdinalIgnoreCase)) return d;
        }
        return null;
    }

    static string? EnsureClone(string name, string fullName, string branch, bool alwaysPull, bool preferClean)
    {
        // Prefer the configured root's clone; for agentic_fomprep skip dirty clones elsewhere.
        string? dir = null;
        foreach (var root in SearchRoots.Prepend(CloneRoot).Distinct(StringComparer.OrdinalIgnoreCase))
        {
            string d = Path.Combine(root, name);
            if (!Directory.Exists(Path.Combine(d, ".git"))) continue;
            if (!GitOut(d, "remote", "get-url", "origin").Contains(fullName, StringComparison.OrdinalIgnoreCase)) continue;
            if (preferClean && GitOut(d, "status", "--porcelain").Length > 0) { Warn($"skipping dirty clone {d}"); continue; }
            dir = d; break;
        }
        if (dir == null)
        {
            dir = Path.Combine(CloneRoot, name);
            if (Directory.Exists(dir) && Directory.EnumerateFileSystemEntries(dir).Any())
            { Err($"{dir} exists but is not a clone of {fullName}; not touching it."); return null; }
            if (DryRun && !alwaysPull) { Info($"would clone {fullName} -> {dir}"); return null; }
            Info($"cloning {fullName} -> {dir}");
            Directory.CreateDirectory(CloneRoot);
            int rc = RunTo(Gh, CloneRoot, "repo", "clone", fullName, dir);
            Check(rc == 0, $"cloned {fullName}");
            return rc == 0 ? dir : null;
        }
        Info($"clone: {dir}");
        string before = GitOut(dir, "rev-parse", "--short", "HEAD");
        string cur = GitOut(dir, "rev-parse", "--abbrev-ref", "HEAD");
        int frc = RunTo(Git, dir, "fetch", "--prune", "--quiet", "origin");
        if (frc != 0) { Warn("git fetch failed (offline?) - using local copy"); return dir; }
        string behind = GitOut(dir, "rev-list", "--count", $"HEAD..origin/{branch}");
        bool dirty = GitOut(dir, "status", "--porcelain").Length > 0;
        if (cur != branch || dirty)
        {
            Warn($"on '{cur}'{(dirty ? ", uncommitted changes" : "")}: not fast-forwarding ({behind} commit(s) behind origin/{branch}).");
            if (name == FomprepRepo) Check(false, $"agentic_fomprep fast-forward (left at {before})");
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
    // priority-catalog runs locally over stdio from this exe, serving <agentic_fomprep>\v2\apps\mcp-catalog\catalog.
    // (The hosted https://mcp-priority.ntsa.uk/mcp has no DNS record, so an http registration always fails the handshake.)
    static void EnsureGrokMcp(string grok)
    {
        string exe = Environment.ProcessPath ?? Path.Combine(AppContext.BaseDirectory, "PriorityAgent.exe");
        var (rc, outp, _) = Capture(grok, null, "mcp", "list");
        string line = outp.Split('\n').Select(l => l.Trim()).FirstOrDefault(l => l.StartsWith(McpName + ":", StringComparison.OrdinalIgnoreCase)) ?? "";
        bool good = line.Contains(exe, StringComparison.OrdinalIgnoreCase) && line.Contains("--mcp-catalog", StringComparison.OrdinalIgnoreCase);
        if (good) Check(true, $"MCP '{McpName}' registered: {line[(McpName.Length + 1)..].Trim()}");
        else if (DryRun) { Info($"would run: grok mcp add {McpName} -- \"{exe}\" --mcp-catalog   (currently: {(line == "" ? "not registered" : line)})"); return; }
        else
        {
            int arc = RunTo(grok, null, "mcp", "add", McpName, "--", exe, "--mcp-catalog");
            Check(arc == 0, $"registered MCP '{McpName}' (stdio) -> \"{exe}\" --mcp-catalog{(line == "" ? "" : $" (replaced: {line})")}");
        }
        if (DryRun && !good) return;
        var (drc, dout, derr) = Capture(grok, null, "mcp", "doctor", McpName);
        string d = (dout + derr).Trim();
        int sec = d.IndexOf(McpName + " (", StringComparison.OrdinalIgnoreCase);
        if (sec >= 0) d = d[sec..];
        bool ok = drc == 0 && d.Contains("handshake OK", StringComparison.OrdinalIgnoreCase) && !d.Contains("handshake failed", StringComparison.OrdinalIgnoreCase);
        Check(ok, $"grok mcp doctor {McpName}: " + Trunc(Regex.Replace(d, @"\s+", " "), 300));
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
    static string? Which(string exe, params string[] known)
    {
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
