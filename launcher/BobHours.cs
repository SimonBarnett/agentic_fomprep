using System.Globalization;
using System.Text.Json;
using System.Text.RegularExpressions;

namespace PriorityAgent;

/// <summary>
/// Hours list gate for bobiverse <c>bobhours.py</c> (FR #3450 / #3673).
/// Matches <c>idempotency_key</c> on the returned entries. The list query has no key filter.
/// Does not POST and does not invent duration.
/// </summary>
public sealed record BobHoursExpect(
    string IdempotencyKey,
    string EntryId,
    string OnBehalfOf,
    string Customer,
    string Project);

public readonly record struct BobHoursResult(bool Ok, string Detail);

public static class BobHours
{
    public const string ListPath = "/bob/v1/hours";
    public static readonly Regex ProjectFolder = new(@"^(SC|SO)[0-9]+$", RegexOptions.CultureInvariant);
    public static readonly Regex EntryIdPattern = new(@"^h_[0-9a-f]{16}$", RegexOptions.CultureInvariant);
    public static readonly Regex Slug = new(@"^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$", RegexOptions.CultureInvariant);
    public static readonly Regex Idempotency = new(@"^[A-Za-z0-9._:@-]{1,128}$", RegexOptions.CultureInvariant);
    public static readonly Regex UserLoginPattern = new(@"^[A-Za-z0-9][A-Za-z0-9._@-]{0,63}$", RegexOptions.CultureInvariant);
    public const string SampleCompletedWork =
        "Updated the agreed rates so new orders price correctly. Consultant-equivalent effort: 1.5 hours.";

    static readonly HashSet<string> UnsupportedEffortKeys = new(StringComparer.Ordinal)
    {
        "estimated_hours", "equivalent_hours", "human_hours", "effort_minutes", "effort_hours",
    };

    static readonly HashSet<string> RejectedAliases = new(StringComparer.Ordinal)
    {
        "started_at", "start_at", "started", "from", "ended_at", "finish", "customer_slug", "project_slug",
    };

    static readonly HashSet<string> CredentialKeys = new(StringComparer.Ordinal)
    {
        "password", "passwd", "pwd", "secret", "token", "api_key", "apikey", "access_token",
        "refresh_token", "authorization", "auth", "bearer", "private_key", "client_secret",
        "sasl", "nickserv", "github.token", "x-bob-secret",
    };

    public static bool IsAuthoritativeProjectFolder(string? name) =>
        !string.IsNullOrEmpty(name) && ProjectFolder.IsMatch(name);

    public static string IdempotencyKeyForSession(string sessionId) =>
        "priority-agent-" + (sessionId ?? "").Trim();

    public static bool IsPriorityUserLogin(string? value) =>
        !string.IsNullOrEmpty(value) && UserLoginPattern.IsMatch(value);

    public readonly record struct SessionOwner(bool Ok, string UserLogin, string Detail);

    /// <summary>
    /// The session file is the owner. A later request may repeat that login.
    /// A different login is refused and the stored owner is left in place.
    /// There is no default login and no operating-system user.
    /// </summary>
    public static SessionOwner BindSessionOwner(string? persistedOwner, string? requestedOwner)
    {
        string persisted = (persistedOwner ?? "").Trim();
        string requested = (requestedOwner ?? "").Trim();
        if (persisted.Length > 0)
        {
            if (!IsPriorityUserLogin(persisted))
                return new(false, "", "persisted session owner is not a Priority USERLOGIN");
            if (requested.Length > 0 && !string.Equals(persisted, requested, StringComparison.Ordinal))
                return new(false, persisted, "session owner is " + persisted + "; refusing to reassign");
            return new(true, persisted, "session owner kept");
        }
        if (requested.Length == 0)
            return new(false, "", "Priority USERLOGIN unavailable");
        if (!IsPriorityUserLogin(requested))
            return new(false, "", "Priority USERLOGIN is not a usable login");
        return new(true, requested, "session owner set");
    }

    public readonly record struct CustomerHoursConfig(
        bool Ok,
        string Detail,
        string Customer,
        string Project,
        string PriorityProject,
        string Wbs,
        string WbsStatus);

    /// <summary>
    /// Customer routing is the repo name and the selected SC/SO folder, or
    /// hours.json when that file is present. hours.json may contain only
    /// customer and project. It must not name a user. project.md may contain
    /// priority_project and wbs as plain lines or inside a fence. wbs unknown
    /// stays unknown and is not a booking code.
    /// </summary>
    public static CustomerHoursConfig ReadCustomerHoursConfig(
        string? repoName,
        string? selectedFolder,
        string? hoursJson,
        string? projectMarkdown)
    {
        string customer = (repoName ?? "").Trim();
        string project = (selectedFolder ?? "").Trim();
        if (!string.IsNullOrWhiteSpace(hoursJson))
        {
            JsonDocument doc;
            try { doc = JsonDocument.Parse(hoursJson); }
            catch (JsonException) { return EmptyConfig("hours.json is not JSON"); }
            using (doc)
            {
                if (doc.RootElement.ValueKind != JsonValueKind.Object)
                    return EmptyConfig("hours.json must be an object");
                foreach (var prop in doc.RootElement.EnumerateObject())
                {
                    if (prop.Name is "user" or "on_behalf_of" or "priorityUserLogin" or "hours_user" or "agent")
                        return EmptyConfig("hours.json must not set a user");
                    if (prop.Name is not "customer" and not "project")
                        return EmptyConfig("hours.json only allows customer and project");
                }
                string fileCustomer = JsonString(doc.RootElement, "customer");
                string fileProject = JsonString(doc.RootElement, "project");
                if (fileCustomer.Length > 0 && customer.Length > 0 && !string.Equals(fileCustomer, customer, StringComparison.Ordinal))
                    return EmptyConfig("hours.json customer does not match the selected repo");
                if (fileCustomer.Length > 0) customer = fileCustomer;
                if (fileProject.Length > 0 && project.Length > 0 && !string.Equals(fileProject, project, StringComparison.Ordinal))
                    return EmptyConfig("hours.json project does not match the selected folder");
                if (fileProject.Length > 0) project = fileProject;
            }
        }
        if (customer.Length > 0 && !Slug.IsMatch(customer))
            return EmptyConfig("bad_customer");
        if (project.Length > 0 && !IsAuthoritativeProjectFolder(project))
            return EmptyConfig("project must be an SCxxxxxx or SOxxxxxx folder");

        string priority = "";
        string wbs = "";
        string wbsStatus = "absent";
        if (!string.IsNullOrEmpty(projectMarkdown))
        {
            foreach (string raw in projectMarkdown.Replace("\r\n", "\n").Split('\n'))
            {
                if (!TryBookingLine(raw, out string key, out string value)) continue;
                if (key == "priority_project" && priority.Length == 0 && !IsUnknownBooking(value))
                    priority = value;
                if (key == "wbs" && wbsStatus == "absent")
                {
                    if (IsUnknownBooking(value)) wbsStatus = "unknown";
                    else { wbs = value; wbsStatus = "set"; }
                }
            }
        }
        return new(true, "customer hours config ok", customer, project, priority, wbs, wbsStatus);
    }

    static CustomerHoursConfig EmptyConfig(string detail) =>
        new(false, detail, "", "", "", "", "absent");

    static string JsonString(JsonElement obj, string name)
    {
        if (!obj.TryGetProperty(name, out var value) || value.ValueKind != JsonValueKind.String)
            return "";
        return (value.GetString() ?? "").Trim();
    }

    static bool TryBookingLine(string raw, out string key, out string value)
    {
        key = "";
        value = "";
        string line = raw.Trim();
        if (line.Length == 0 || line.StartsWith("```", StringComparison.Ordinal)) return false;
        if (line.StartsWith("|", StringComparison.Ordinal))
        {
            string[] cells = line.Trim('|').Split('|').Select(cell => cell.Trim().Trim('`', '*')).Where(cell => cell.Length > 0).ToArray();
            if (cells.Length < 2) return false;
            key = cells[0].ToLowerInvariant();
            value = cells[1].Trim().Trim('`', '"', '\'');
        }
        else
        {
            line = line.Trim('`', '*', '#', ' ', '-');
            var match = Regex.Match(line, @"^(priority_project|wbs)\s*[:=]\s*(.*)$", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant);
            if (!match.Success) return false;
            key = match.Groups[1].Value.ToLowerInvariant();
            value = match.Groups[2].Value.Trim().Trim('`', '"', '\'');
        }
        return key is "priority_project" or "wbs";
    }

    static bool IsUnknownBooking(string value)
    {
        string text = value.Trim();
        return text.Length == 0 || Regex.IsMatch(text, @"^(unknown|n/?a|\?|-)$", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant);
    }

    /// <summary>
    /// Customer-facing completed work. start/end stay audit times. The receiver
    /// has no estimated-effort field; duration_minutes is only the elapsed span.
    /// Consultant-equivalent effort is stated in description. billable_hint is
    /// only Y or N. A Priority booking id such as PR230001 is not a pull request.
    /// </summary>
    public static BobHoursResult AssessCompletedWork(string? description)
    {
        string text = (description ?? "").Trim();
        if (text.Length == 0)
            return new(false, "completed work description missing");
        if (text.Length > 4000)
            return new(false, "bad_description");
        if (Regex.IsMatch(text, @"\bWP\s*[-#]?\d+", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant))
            return new(false, "description contains an internal work-package id");
        if (Regex.IsMatch(text, @"\bFR\s*[#-]?\d+", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant))
            return new(false, "description contains an internal feature-request id");
        if (Regex.IsMatch(text, @"\bPR\s*[#-]\s*\d+", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant)
            || Regex.IsMatch(text, @"\bpull request\b", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant))
            return new(false, "description contains an internal pull-request id");
        if (Regex.IsMatch(text, @"github\.com/\S+/(pull|issues)/\d+", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant)
            || Regex.IsMatch(text, @"\bissue\s*#\s*\d+", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant))
            return new(false, "description contains an internal issue number");
        bool namesElapsed = Regex.IsMatch(text, @"\b(wall[- ]clock|elapsed|session duration)\b", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant);
        bool namesEffort = Regex.IsMatch(text, @"consultant-equivalent effort\s*:\s*\d+(\.\d+)?\s*hours?\b", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant);
        if (namesElapsed && !namesEffort)
            return new(false, "elapsed time is not the consultant-equivalent effort");
        if (!namesEffort)
            return new(false, "description needs an explicit consultant-equivalent effort");
        if (Regex.IsMatch(text, @"\b(including|plus)\s+(idle|retries|retry time|wait time)\b", RegexOptions.IgnoreCase | RegexOptions.CultureInvariant))
            return new(false, "description adds idle or retry time to the effort");
        return new(true, "completed work description ok");
    }

    /// <summary>
    /// GET query. No idempotency_key parameter (match that client-side).
    /// Empty from/to are omitted so the receiver does not drop an older London day.
    /// </summary>
    public static string BuildListQuery(string user, string? fromDay, string? toDay)
    {
        var parts = new List<string> { "user=" + Uri.EscapeDataString(user ?? "") };
        if (!string.IsNullOrEmpty(fromDay)) parts.Add("from=" + Uri.EscapeDataString(fromDay));
        if (!string.IsNullOrEmpty(toDay)) parts.Add("to=" + Uri.EscapeDataString(toDay));
        parts.Add("status=closed");
        string query = string.Join("&", parts);
        if (query.Contains("idempotency_key", StringComparison.Ordinal))
            throw new InvalidOperationException("hours query must not filter by idempotency_key");
        return query;
    }

    /// <summary>
    /// Same rule as bobhours._parse_iso: a value with no offset is that clock time in UTC.
    /// An explicit Z or numeric offset is kept. This does not use the host local zone.
    /// </summary>
    public static bool TryParseInstant(string? raw, out DateTimeOffset value)
    {
        value = default;
        string s = (raw ?? "").Trim();
        if (s.Length == 0) return false;
        if (s.EndsWith("Z", StringComparison.Ordinal))
            s = s[..^1] + "+00:00";
        bool hasOffset = Regex.IsMatch(s, @"[+-]\d{2}:\d{2}$", RegexOptions.CultureInvariant);
        if (!hasOffset)
        {
            if (!DateTime.TryParse(s, CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind, out var clock))
                return false;
            value = new DateTimeOffset(clock.Ticks, TimeSpan.Zero);
            return true;
        }
        return DateTimeOffset.TryParse(s, CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind, out value);
    }

    /// <summary>
    /// Europe/London calendar date. UK civil time since 1996: BST is the hour
    /// beginning 01:00 UTC on the last Sunday of March, through 01:00 UTC on the
    /// last Sunday of October. bobhours uses ZoneInfo("Europe/London"); these
    /// instants match that zone. The launcher ships with invariant globalization,
    /// so this does not call TimeZoneInfo.
    /// </summary>
    public static string LondonDate(DateTimeOffset instant)
    {
        var utc = instant.ToUniversalTime();
        var london = utc.AddHours(IsUkBst(utc) ? 1 : 0);
        return london.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
    }

    public readonly record struct BobHoursListWindow(string? FromDay, string? ToDay);

    /// <summary>
    /// Receiver from/to are Europe/London dates of <c>start</c>. A known start
    /// spans that London day through the London day of <paramref name="now"/>,
    /// including an older session. An unknown start omits both bounds.
    /// </summary>
    public static BobHoursListWindow WindowForStart(DateTimeOffset? entryStart, DateTimeOffset now)
    {
        if (entryStart is null) return new(null, null);
        string from = LondonDate(entryStart.Value);
        string to = LondonDate(now);
        if (string.CompareOrdinal(from, to) > 0) to = from;
        return new(from, to);
    }

    /// <summary>Same inclusion as bobhours._entry_in_range (London day of start).</summary>
    public static bool LondonDayInRange(DateTimeOffset start, string? fromDay, string? toDay)
    {
        string day = LondonDate(start);
        if (!string.IsNullOrEmpty(fromDay) && string.CompareOrdinal(day, fromDay) < 0) return false;
        if (!string.IsNullOrEmpty(toDay) && string.CompareOrdinal(day, toDay) > 0) return false;
        return true;
    }

    public static BobHoursResult Precheck(BobHoursExpect expect)
    {
        if (string.IsNullOrWhiteSpace(expect.OnBehalfOf))
            return new(false, "Priority USERLOGIN missing");
        if (string.IsNullOrWhiteSpace(expect.EntryId))
            return new(false, "persisted entry id missing");
        if (!EntryIdPattern.IsMatch(expect.EntryId))
            return new(false, "persisted entry id is not a receiver id");
        if (string.IsNullOrWhiteSpace(expect.IdempotencyKey)
            || !expect.IdempotencyKey.StartsWith("priority-agent-", StringComparison.Ordinal)
            || expect.IdempotencyKey.Length <= "priority-agent-".Length
            || !Idempotency.IsMatch(expect.IdempotencyKey))
            return new(false, "session idempotency_key missing");
        if ((!string.IsNullOrEmpty(expect.Customer) || !string.IsNullOrEmpty(expect.Project))
            && !IsAuthoritativeProjectFolder(expect.Project))
            return new(false, "expected project is not an SC or SO folder");
        if (!string.IsNullOrEmpty(expect.Customer) && !Slug.IsMatch(expect.Customer))
            return new(false, "bad_customer");
        return new(true, "precheck ok");
    }

    public static BobHoursResult Evaluate(string listJson, BobHoursExpect expect)
    {
        var pre = Precheck(expect);
        if (!pre.Ok) return pre;
        JsonDocument doc;
        try { doc = JsonDocument.Parse(listJson); }
        catch (JsonException) { return new(false, "hours list is not JSON"); }
        using (doc)
        {
            if (doc.RootElement.ValueKind != JsonValueKind.Object
                || !doc.RootElement.TryGetProperty("entries", out var entries)
                || entries.ValueKind != JsonValueKind.Array)
                return new(false, "hours list missing entries");

            JsonElement matched = default;
            int idCount = 0;
            int keyCount = 0;
            foreach (var entry in entries.EnumerateArray())
            {
                if (entry.ValueKind != JsonValueKind.Object) continue;
                if (Field(entry, "id") == expect.EntryId) { idCount++; matched = entry; }
                if (Field(entry, "idempotency_key") == expect.IdempotencyKey) keyCount++;
            }
            if (idCount == 0) return new(false, "persisted entry id not in the list");
            if (idCount > 1) return new(false, "duplicate entry id");
            if (keyCount > 1) return new(false, "duplicate idempotency_key");
            if (Field(matched, "idempotency_key") != expect.IdempotencyKey)
                return new(false, "idempotency_key does not match the session key");

            string status = Field(matched, "status");
            if (status == "open") return new(false, "entry still open");
            if (status == "auto_closed") return new(false, "auto_closed is not a closed report");
            if (status != "closed") return new(false, "status is not closed");
            if (Field(matched, "on_behalf_of") != expect.OnBehalfOf)
                return new(false, "on_behalf_of does not match Priority USERLOGIN");
            if (Field(matched, "customer") != expect.Customer)
                return new(false, "customer mismatch");
            if (Field(matched, "project") != expect.Project)
                return new(false, "project mismatch");

            string startRaw = Field(matched, "start");
            string endRaw = Field(matched, "end");
            if (startRaw.Length == 0 || endRaw.Length == 0)
                return new(false, "closed entry missing start or end");
            if (!TryParseInstant(startRaw, out var start) || !TryParseInstant(endRaw, out var end))
                return new(false, "start or end is not ISO-8601");
            if (end < start) return new(false, "end before start");
            if (!matched.TryGetProperty("duration_minutes", out var dur)
                || dur.ValueKind != JsonValueKind.Number
                || !dur.TryGetInt32(out int minutes))
                return new(false, "duration_minutes missing on closed entry");
            int derived = (int)Math.Floor((end - start).TotalSeconds / 60.0);
            if (derived < 0) derived = 0;
            if (minutes != derived)
                return new(false, "duration_minutes does not match start and end");
            var prose = AssessCompletedWork(Field(matched, "description"));
            if (!prose.Ok) return prose;
            return new(true, "one closed entry " + expect.EntryId + " matched client-side");
        }
    }

    public static BobHoursResult TryBuildCreateJson(
        IReadOnlyDictionary<string, string?> fields,
        IReadOnlyList<string>? tickets,
        out string json)
    {
        json = "";
        var rejected = new List<string>();
        foreach (string key in fields.Keys)
        {
            string norm = key.Trim().ToLowerInvariant().Replace("-", "_");
            if (RejectedAliases.Contains(key)
                || CredentialKeys.Contains(norm)
                || norm.EndsWith("_password", StringComparison.Ordinal)
                || norm.EndsWith("_token", StringComparison.Ordinal)
                || key == "duration_minutes"
                || UnsupportedEffortKeys.Contains(norm))
                rejected.Add(key);
        }
        if (rejected.Count > 0)
            return new(false, "rejected fields: " + string.Join(",", rejected));

        string Req(string name) =>
            fields.TryGetValue(name, out var value) ? (value ?? "").Trim() : "";

        string idem = Req("idempotency_key");
        string agent = Req("agent");
        string user = Req("on_behalf_of");
        string startRaw = Req("start");
        if (idem.Length == 0 || agent.Length == 0 || user.Length == 0 || startRaw.Length == 0)
            return new(false, "missing required idempotency_key, agent, on_behalf_of, or start");
        if (!Idempotency.IsMatch(idem))
            return new(false, "bad_idempotency_key");
        if (!TryParseInstant(startRaw, out var start))
            return new(false, "bad_start");

        string endRaw = Req("end");
        if (endRaw.Length > 0)
        {
            if (!TryParseInstant(endRaw, out var end))
                return new(false, "bad_end");
            if (end < start) return new(false, "bad_end_before_start");
        }

        string customer = Req("customer");
        string project = Req("project");
        if (customer.Length > 0 && !Slug.IsMatch(customer))
            return new(false, "bad_customer");
        if (customer.Length > 0 && project.Length == 0)
            return new(false, "customer work needs an SC or SO project folder");
        if (project.Length > 0 && !IsAuthoritativeProjectFolder(project))
            return new(false, "project must be an SCxxxxxx or SOxxxxxx folder");

        var prose = AssessCompletedWork(Req("description"));
        if (!prose.Ok) return prose;

        string bill = Req("billable_hint");
        if (bill.Length > 0 && bill != "Y" && bill != "N")
            return new(false, "bad_billable_hint");
        string repo = Req("repo_url");
        if (repo.Length > 0 && !repo.StartsWith("https://", StringComparison.Ordinal) && !repo.StartsWith("http://", StringComparison.Ordinal))
            return new(false, "bad_repo_url");

        var payload = new Dictionary<string, object?>
        {
            ["idempotency_key"] = idem,
            ["agent"] = agent,
            ["on_behalf_of"] = user,
            ["start"] = startRaw,
        };
        if (endRaw.Length > 0) payload["end"] = endRaw;
        if (customer.Length > 0) payload["customer"] = customer;
        if (project.Length > 0) payload["project"] = project;
        if (repo.Length > 0) payload["repo_url"] = repo;
        string description = Req("description");
        if (description.Length > 0) payload["description"] = description;
        string source = Req("source");
        if (source.Length > 0) payload["source"] = source;
        if (bill.Length > 0) payload["billable_hint"] = bill;
        if (tickets is { Count: > 0 }) payload["tickets"] = tickets;

        json = JsonSerializer.Serialize(payload);
        if (json.Contains("duration_minutes", StringComparison.Ordinal))
            return new(false, "duration_minutes must not be sent");
        return new(true, "create body ok");
    }

    public static int RunOfflineSelfTest()
    {
        int failed = 0;
        void Gate(string id, bool pass, string detail)
        {
            Console.WriteLine((pass ? "PASS " : "FAIL ") + id + " " + detail);
            if (!pass) failed++;
        }

        const string session = "11111111-1111-1111-1111-111111111111";
        string key = IdempotencyKeyForSession(session);
        var expect = new BobHoursExpect(key, "h_0123456789abcdef", "UserOne", "example-customer", "SC100001");
        string closed = Entry("h_0123456789abcdef", key, "UserOne", "example-customer", "SC100001", "closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "60");

        var ok = Evaluate(closed, expect);
        Gate("closed-match", ok.Ok, ok.Detail);

        var missing = Evaluate("{\"entries\":[]}", expect);
        Gate("missing", !missing.Ok && missing.Detail.Contains("not in the list", StringComparison.Ordinal), missing.Detail);

        string open = Entry("h_0123456789abcdef", key, "UserOne", "example-customer", "SC100001", "open",
            "2026-11-08T09:00:00+00:00", "", "");
        var openResult = Evaluate(open, expect);
        Gate("open", !openResult.Ok && openResult.Detail.Contains("still open", StringComparison.Ordinal), openResult.Detail);

        string wrongKey = Entry("h_0123456789abcdef", "priority-agent-other", "UserOne", "example-customer", "SC100001", "closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "60");
        var wrong = Evaluate(wrongKey, expect);
        Gate("wrong-key", !wrong.Ok && wrong.Detail.Contains("idempotency_key", StringComparison.Ordinal), wrong.Detail);

        string autoClosed = Entry("h_0123456789abcdef", key, "UserOne", "example-customer", "SC100001", "auto_closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "60");
        var auto = Evaluate(autoClosed, expect);
        Gate("auto-closed", !auto.Ok && auto.Detail.Contains("auto_closed", StringComparison.Ordinal), auto.Detail);

        var wrongUser = Evaluate(Entry("h_0123456789abcdef", key, "Other", "example-customer", "SC100001", "closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "60"), expect);
        Gate("wrong-user", !wrongUser.Ok && wrongUser.Detail.Contains("USERLOGIN", StringComparison.Ordinal), wrongUser.Detail);
        var expectTwo = new BobHoursExpect(key, "h_0123456789abcdef", "UserTwo", "example-customer", "SC100001");
        var userTwo = Evaluate(Entry("h_0123456789abcdef", key, "UserTwo", "example-customer", "SC100001", "closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "60"), expectTwo);
        Gate("user-two", userTwo.Ok && BuildListQuery("UserTwo", null, null) == "user=UserTwo&status=closed", userTwo.Detail);
        var cross = Evaluate(Entry("h_0123456789abcdef", key, "UserTwo", "example-customer", "SC100001", "closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "60"), expect);
        Gate("cross-user", !cross.Ok, cross.Detail);
        var setOne = BindSessionOwner(null, "UserOne");
        var setTwo = BindSessionOwner(null, "UserTwo");
        var kept = BindSessionOwner("UserOne", "UserTwo");
        var absent = BindSessionOwner(null, null);
        Gate("two-session-owners",
            setOne.Ok && setOne.UserLogin == "UserOne" && setTwo.Ok && setTwo.UserLogin == "UserTwo",
            setOne.UserLogin + "/" + setTwo.UserLogin);
        Gate("owner-not-reassigned",
            !kept.Ok && kept.UserLogin == "UserOne" && kept.Detail.Contains("refusing to reassign", StringComparison.Ordinal),
            kept.Detail);
        Gate("owner-unavailable",
            !absent.Ok && absent.UserLogin.Length == 0 && absent.Detail.Contains("unavailable", StringComparison.Ordinal),
            absent.Detail);

        var wrongProject = Evaluate(Entry("h_0123456789abcdef", key, "UserOne", "example-customer", "SO100001", "closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "60"), expect);
        Gate("wrong-project", !wrongProject.Ok && wrongProject.Detail.Contains("project mismatch", StringComparison.Ordinal), wrongProject.Detail);

        var badDuration = Evaluate(Entry("h_0123456789abcdef", key, "UserOne", "example-customer", "SC100001", "closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "480"), expect);
        Gate("bad-duration", !badDuration.Ok && badDuration.Detail.Contains("duration_minutes", StringComparison.Ordinal), badDuration.Detail);

        string query = BuildListQuery("UserOne", "2026-11-02", "2026-11-08");
        Gate("query-no-key",
            query == "user=UserOne&from=2026-11-02&to=2026-11-08&status=closed" && !query.Contains("idempotency", StringComparison.Ordinal),
            query);

        var alias = new Dictionary<string, string?> { ["started_at"] = "2026-11-08T09:00:00+00:00", ["idempotency_key"] = key, ["agent"] = "Haitch", ["on_behalf_of"] = "UserOne" };
        var aliasResult = TryBuildCreateJson(alias, null, out _);
        Gate("reject-alias", !aliasResult.Ok && aliasResult.Detail.Contains("started_at", StringComparison.Ordinal), aliasResult.Detail);

        var good = new Dictionary<string, string?>
        {
            ["idempotency_key"] = key,
            ["agent"] = "Haitch",
            ["on_behalf_of"] = "UserOne",
            ["start"] = "2026-11-08T09:00:00+00:00",
            ["end"] = "2026-11-08T10:00:00+00:00",
            ["customer"] = "example-customer",
            ["project"] = "SC100001",
            ["description"] = SampleCompletedWork,
            ["source"] = "fixture",
        };
        var built = TryBuildCreateJson(good, null, out string body);
        Gate("create-body", built.Ok && body.Contains("\"project\":\"SC100001\"", StringComparison.Ordinal) && !body.Contains("duration_minutes", StringComparison.Ordinal), built.Detail);

        var ordinal = new Dictionary<string, string?>(good) { ["project"] = "ordinal2" };
        var ordinalResult = TryBuildCreateJson(ordinal, null, out _);
        Gate("reject-ordinal-project", !ordinalResult.Ok && ordinalResult.Detail.Contains("SC", StringComparison.Ordinal), ordinalResult.Detail);

        Gate("id-still-16-hex",
            EntryIdPattern.IsMatch("h_0123456789abcdef")
            && !EntryIdPattern.IsMatch("h_0123456789abcde")
            && !EntryIdPattern.IsMatch("h_0123456789abcdef0"),
            "receiver id stays h_ plus 16 hex");

        Gate("naive-is-utc",
            TryParseInstant("2026-07-01T00:30:00", out var naive)
            && naive.Offset == TimeSpan.Zero && naive.Hour == 0 && naive.Minute == 30,
            naive.ToString("o", CultureInfo.InvariantCulture));
        DateTimeOffset.TryParse("2026-07-01T00:30:00", CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind, out var hostLocal);
        var hostOff = TimeZoneInfo.Local.GetUtcOffset(new DateTime(2026, 7, 1, 0, 30, 0, DateTimeKind.Unspecified));
        Gate("naive-not-host-local",
            hostOff == TimeSpan.Zero || naive != hostLocal,
            "hostOffset=" + hostOff + " localParse=" + hostLocal.ToString("o", CultureInfo.InvariantCulture));
        Gate("explicit-offset",
            TryParseInstant("2026-07-01T00:30:00+01:00", out var plus) && plus.Offset == TimeSpan.FromHours(1),
            plus.ToString("o", CultureInfo.InvariantCulture));
        Gate("zulu",
            TryParseInstant("2026-07-01T00:30:00Z", out var zed) && zed.Offset == TimeSpan.Zero && zed.Hour == 0,
            zed.ToString("o", CultureInfo.InvariantCulture));

        string mixed = Entry("h_0123456789abcdef", key, "UserOne", "example-customer", "SC100001", "closed",
            "2026-07-01T00:30:00", "2026-07-01T01:30:00Z", "60");
        var mixedResult = Evaluate(mixed, expect);
        Gate("naive-utc-duration", mixedResult.Ok, mixedResult.Detail);

        var bstNow = DateTimeOffset.Parse("2026-06-30T23:30:00Z", CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind);
        Gate("london-bst-midnight", LondonDate(bstNow) == "2026-07-01", LondonDate(bstNow));
        var bstWindow = WindowForStart(bstNow, bstNow);
        Gate("bst-window",
            bstWindow.FromDay == "2026-07-01" && bstWindow.ToDay == "2026-07-01"
            && LondonDayInRange(bstNow, bstWindow.FromDay, bstWindow.ToDay),
            (bstWindow.FromDay ?? "") + ".." + (bstWindow.ToDay ?? ""));
        string utcToday = bstNow.UtcDateTime.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
        Gate("utc-date-drops-london-day", !LondonDayInRange(bstNow, utcToday, utcToday), utcToday);

        Gate("before-bst", LondonDate(DateTimeOffset.Parse("2026-03-29T00:30:00Z", CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind)) == "2026-03-29", "");
        Gate("bst-begins", LondonDate(DateTimeOffset.Parse("2026-03-29T01:00:00Z", CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind)) == "2026-03-29", "");
        Gate("clocks-back", LondonDate(DateTimeOffset.Parse("2026-10-25T01:00:00Z", CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind)) == "2026-10-25", "");
        Gate("winter-midnight", LondonDate(DateTimeOffset.Parse("2026-11-08T00:30:00Z", CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind)) == "2026-11-08", "");

        var checkedOn = DateTimeOffset.Parse("2026-11-08T12:00:00Z", CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind);
        var olderStart = DateTimeOffset.Parse("2026-11-02T09:00:00Z", CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind);
        string oldFrom = checkedOn.UtcDateTime.AddDays(-1).ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
        string oldTo = checkedOn.UtcDateTime.AddDays(1).ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
        Gate("utc-clamp-drops-older", !LondonDayInRange(olderStart, oldFrom, oldTo), oldFrom + ".." + oldTo);
        var olderWindow = WindowForStart(olderStart, checkedOn);
        Gate("older-session-window",
            olderWindow.FromDay == "2026-11-02" && olderWindow.ToDay == "2026-11-08"
            && LondonDayInRange(olderStart, olderWindow.FromDay, olderWindow.ToDay),
            (olderWindow.FromDay ?? "") + ".." + (olderWindow.ToDay ?? ""));
        var unbounded = WindowForStart(null, checkedOn);
        string unboundedQuery = BuildListQuery("UserOne", unbounded.FromDay, unbounded.ToDay);
        Gate("unknown-start-omits-days",
            unbounded.FromDay == null && unbounded.ToDay == null
            && unboundedQuery == "user=UserOne&status=closed",
            unboundedQuery);

        try
        {
            var tz = TimeZoneInfo.FindSystemTimeZoneById("Europe/London");
            foreach (var sample in new[] { "2026-03-29T00:30:00Z", "2026-03-29T01:00:00Z", "2026-06-30T23:30:00Z", "2026-10-25T00:30:00Z", "2026-10-25T01:00:00Z", "2026-11-08T00:30:00Z" })
            {
                var inst = DateTimeOffset.Parse(sample, CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind);
                string zoneDay = TimeZoneInfo.ConvertTime(inst, tz).ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
                Gate("zone-" + sample, LondonDate(inst) == zoneDay, zoneDay + " vs " + LondonDate(inst));
            }
        }
        catch (TimeZoneNotFoundException ex)
        {
            Gate("zone-data", false, ex.Message);
        }

        var jargon = AssessCompletedWork("Spent the session on WP3, FR #12, and PR #34.");
        Gate("reject-internal-ids", !jargon.Ok, jargon.Detail);
        var wall = AssessCompletedWork("Session duration was 60 minutes.");
        Gate("reject-elapsed-as-hours", !wall.Ok && wall.Detail.Contains("elapsed", StringComparison.Ordinal), wall.Detail);
        var booking = AssessCompletedWork("Recorded the booking id in the project file. Consultant-equivalent effort: 1 hours. Booking PR230001 stays a project id.");
        Gate("booking-id-not-pull-request", booking.Ok, booking.Detail);
        var effortKey = new Dictionary<string, string?>(good) { ["effort_hours"] = "1.5" };
        var effortRejected = TryBuildCreateJson(effortKey, null, out _);
        Gate("no-effort-field", !effortRejected.Ok && effortRejected.Detail.Contains("effort_hours", StringComparison.Ordinal), effortRejected.Detail);
        Gate("audit-times-kept",
            body.Contains("2026-11-08T09:00:00", StringComparison.Ordinal)
            && body.Contains("2026-11-08T10:00:00", StringComparison.Ordinal)
            && body.Contains("1.5 hours", StringComparison.Ordinal)
            && !body.Contains("duration_minutes", StringComparison.Ordinal),
            "start and end stay the audit span");

        var plain = ReadCustomerHoursConfig("example-customer", "SC100001", null, "priority_project: PR100001\nwbs: unknown\n");
        Gate("plain-project-md",
            plain.Ok && plain.Customer == "example-customer" && plain.Project == "SC100001"
            && plain.PriorityProject == "PR100001" && plain.WbsStatus == "unknown" && plain.Wbs.Length == 0,
            plain.Detail + " wbs=" + plain.WbsStatus);
        var fenced = ReadCustomerHoursConfig("example-customer", "SC100001", null, "note\n```\npriority_project: PR100001\nwbs: 1\n```\n");
        Gate("fenced-project-md", fenced.Ok && fenced.WbsStatus == "set" && fenced.Wbs == "1", fenced.WbsStatus);
        string hoursFile = "{\"customer\":\"example-customer\",\"project\":\"SO100001\"}";
        var withHours = ReadCustomerHoursConfig("example-customer", "SO100001", hoursFile, "priority_project: PR100002\nwbs: 2\n");
        Gate("hours-json", withHours.Ok && withHours.Project == "SO100001" && withHours.PriorityProject == "PR100002", withHours.Detail);
        var disagree = ReadCustomerHoursConfig("example-customer", "SC100001", "{\"customer\":\"example-customer\",\"project\":\"SO100001\"}", null);
        Gate("hours-json-mismatch", !disagree.Ok, disagree.Detail);
        var userInFile = ReadCustomerHoursConfig("example-customer", "SC100001", "{\"customer\":\"example-customer\",\"project\":\"SC100001\",\"on_behalf_of\":\"UserOne\"}", null);
        Gate("hours-json-no-user", !userInFile.Ok && userInFile.Detail.Contains("user", StringComparison.Ordinal), userInFile.Detail);
        var routed = BindSessionOwner(null, "UserTwo");
        var report = new Dictionary<string, string?>
        {
            ["idempotency_key"] = key,
            ["agent"] = "Haitch",
            ["on_behalf_of"] = routed.UserLogin,
            ["start"] = "2026-11-08T09:00:00+00:00",
            ["end"] = "2026-11-08T10:00:00+00:00",
            ["customer"] = plain.Customer,
            ["project"] = plain.Project,
            ["description"] = SampleCompletedWork,
        };
        var reportBody = TryBuildCreateJson(report, null, out string reportJson);
        Gate("report-omits-unknown-wbs",
            reportBody.Ok && routed.Ok
            && reportJson.Contains("\"on_behalf_of\":\"UserTwo\"", StringComparison.Ordinal)
            && reportJson.Contains("\"project\":\"SC100001\"", StringComparison.Ordinal)
            && !reportJson.Contains("priority_project", StringComparison.Ordinal)
            && !reportJson.Contains("\"wbs\"", StringComparison.Ordinal)
            && !reportJson.Contains("unknown", StringComparison.Ordinal),
            reportBody.Detail);
        var routedExpect = new BobHoursExpect(key, "h_0123456789abcdef", "UserTwo", plain.Customer, plain.Project);
        var routedReceipt = Evaluate(Entry("h_0123456789abcdef", key, "UserTwo", plain.Customer, plain.Project, "closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "60"), routedExpect);
        Gate("report-receipt", routedReceipt.Ok, routedReceipt.Detail);

        Gate("fixture-only", true, "self-test sent no HTTP request");
        Console.WriteLine(failed == 0 ? "BobHours offline self-test PASS" : "BobHours offline self-test FAIL " + failed);
        return failed == 0 ? 0 : 1;
    }

    static string Entry(string id, string key, string user, string customer, string project, string status, string start, string end, string duration, string? description = null)
    {
        string endJson = end.Length == 0 ? "null" : "\"" + end + "\"";
        string durJson = duration.Length == 0 ? "null" : duration;
        string desc = (description ?? SampleCompletedWork).Replace("\\", "\\\\").Replace("\"", "\\\"");
        return "{\"entries\":[{\"id\":\"" + id + "\",\"idempotency_key\":\"" + key
            + "\",\"on_behalf_of\":\"" + user + "\",\"customer\":\"" + customer + "\",\"project\":\"" + project
            + "\",\"status\":\"" + status + "\",\"start\":\"" + start + "\",\"end\":" + endJson
            + ",\"duration_minutes\":" + durJson + ",\"description\":\"" + desc + "\"}]}";
    }

    static bool IsUkBst(DateTimeOffset utc)
    {
        var u = utc.ToUniversalTime();
        return u >= UkTransition(u.Year, 3) && u < UkTransition(u.Year, 10);
    }

    static DateTimeOffset UkTransition(int year, int month)
    {
        var day = new DateTime(year, month, DateTime.DaysInMonth(year, month));
        while (day.DayOfWeek != DayOfWeek.Sunday) day = day.AddDays(-1);
        return new DateTimeOffset(day.Year, day.Month, day.Day, 1, 0, 0, TimeSpan.Zero);
    }

    static string Field(JsonElement entry, string name)
    {
        if (!entry.TryGetProperty(name, out var value) || value.ValueKind == JsonValueKind.Null)
            return "";
        return value.ValueKind == JsonValueKind.String ? value.GetString() ?? "" : value.ToString() ?? "";
    }
}
