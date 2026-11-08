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

    /// <summary>GET query. No idempotency_key parameter (match that client-side).</summary>
    public static string BuildListQuery(string user, string fromDay, string toDay) =>
        "user=" + Uri.EscapeDataString(user ?? "")
        + "&from=" + Uri.EscapeDataString(fromDay ?? "")
        + "&to=" + Uri.EscapeDataString(toDay ?? "")
        + "&status=closed";

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
            if (!DateTimeOffset.TryParse(startRaw, CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind, out var start)
                || !DateTimeOffset.TryParse(endRaw, CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind, out var end))
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
                || key == "duration_minutes")
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
        if (!DateTimeOffset.TryParse(startRaw, CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind, out var start))
            return new(false, "bad_start");

        string endRaw = Req("end");
        if (endRaw.Length > 0)
        {
            if (!DateTimeOffset.TryParse(endRaw, CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind, out var end))
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
        var expect = new BobHoursExpect(key, "h_0123456789abcdef", "SimonB", "example-customer", "SC100001");
        string closed = Entry("h_0123456789abcdef", key, "SimonB", "example-customer", "SC100001", "closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "60");

        var ok = Evaluate(closed, expect);
        Gate("closed-match", ok.Ok, ok.Detail);

        var missing = Evaluate("{\"entries\":[]}", expect);
        Gate("missing", !missing.Ok && missing.Detail.Contains("not in the list", StringComparison.Ordinal), missing.Detail);

        string open = Entry("h_0123456789abcdef", key, "SimonB", "example-customer", "SC100001", "open",
            "2026-11-08T09:00:00+00:00", "", "");
        var openResult = Evaluate(open, expect);
        Gate("open", !openResult.Ok && openResult.Detail.Contains("still open", StringComparison.Ordinal), openResult.Detail);

        string wrongKey = Entry("h_0123456789abcdef", "priority-agent-other", "SimonB", "example-customer", "SC100001", "closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "60");
        var wrong = Evaluate(wrongKey, expect);
        Gate("wrong-key", !wrong.Ok && wrong.Detail.Contains("idempotency_key", StringComparison.Ordinal), wrong.Detail);

        string autoClosed = Entry("h_0123456789abcdef", key, "SimonB", "example-customer", "SC100001", "auto_closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "60");
        var auto = Evaluate(autoClosed, expect);
        Gate("auto-closed", !auto.Ok && auto.Detail.Contains("auto_closed", StringComparison.Ordinal), auto.Detail);

        var wrongUser = Evaluate(Entry("h_0123456789abcdef", key, "Other", "example-customer", "SC100001", "closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "60"), expect);
        Gate("wrong-user", !wrongUser.Ok && wrongUser.Detail.Contains("USERLOGIN", StringComparison.Ordinal), wrongUser.Detail);

        var wrongProject = Evaluate(Entry("h_0123456789abcdef", key, "SimonB", "example-customer", "SO100001", "closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "60"), expect);
        Gate("wrong-project", !wrongProject.Ok && wrongProject.Detail.Contains("project mismatch", StringComparison.Ordinal), wrongProject.Detail);

        var badDuration = Evaluate(Entry("h_0123456789abcdef", key, "SimonB", "example-customer", "SC100001", "closed",
            "2026-11-08T09:00:00+00:00", "2026-11-08T10:00:00+00:00", "480"), expect);
        Gate("bad-duration", !badDuration.Ok && badDuration.Detail.Contains("duration_minutes", StringComparison.Ordinal), badDuration.Detail);

        string query = BuildListQuery("SimonB", "2026-11-02", "2026-11-08");
        Gate("query-no-key",
            query == "user=SimonB&from=2026-11-02&to=2026-11-08&status=closed" && !query.Contains("idempotency", StringComparison.Ordinal),
            query);

        var alias = new Dictionary<string, string?> { ["started_at"] = "2026-11-08T09:00:00+00:00", ["idempotency_key"] = key, ["agent"] = "Haitch", ["on_behalf_of"] = "SimonB" };
        var aliasResult = TryBuildCreateJson(alias, null, out _);
        Gate("reject-alias", !aliasResult.Ok && aliasResult.Detail.Contains("started_at", StringComparison.Ordinal), aliasResult.Detail);

        var good = new Dictionary<string, string?>
        {
            ["idempotency_key"] = key,
            ["agent"] = "Haitch",
            ["on_behalf_of"] = "SimonB",
            ["start"] = "2026-11-08T09:00:00+00:00",
            ["end"] = "2026-11-08T10:00:00+00:00",
            ["customer"] = "example-customer",
            ["project"] = "SC100001",
            ["description"] = "fixture",
            ["source"] = "fixture",
        };
        var built = TryBuildCreateJson(good, null, out string body);
        Gate("create-body", built.Ok && body.Contains("\"project\":\"SC100001\"", StringComparison.Ordinal) && !body.Contains("duration_minutes", StringComparison.Ordinal), built.Detail);

        var ordinal = new Dictionary<string, string?>(good) { ["project"] = "ordinal2" };
        var ordinalResult = TryBuildCreateJson(ordinal, null, out _);
        Gate("reject-ordinal-project", !ordinalResult.Ok && ordinalResult.Detail.Contains("SC", StringComparison.Ordinal), ordinalResult.Detail);

        Gate("fixture-only", true, "self-test sent no HTTP request");
        Console.WriteLine(failed == 0 ? "BobHours offline self-test PASS" : "BobHours offline self-test FAIL " + failed);
        return failed == 0 ? 0 : 1;
    }

    static string Entry(string id, string key, string user, string customer, string project, string status, string start, string end, string duration)
    {
        string endJson = end.Length == 0 ? "null" : "\"" + end + "\"";
        string durJson = duration.Length == 0 ? "null" : duration;
        return "{\"entries\":[{\"id\":\"" + id + "\",\"idempotency_key\":\"" + key
            + "\",\"on_behalf_of\":\"" + user + "\",\"customer\":\"" + customer + "\",\"project\":\"" + project
            + "\",\"status\":\"" + status + "\",\"start\":\"" + start + "\",\"end\":" + endJson
            + ",\"duration_minutes\":" + durJson + "}]}";
    }

    static string Field(JsonElement entry, string name)
    {
        if (!entry.TryGetProperty(name, out var value) || value.ValueKind == JsonValueKind.Null)
            return "";
        return value.ValueKind == JsonValueKind.String ? value.GetString() ?? "" : value.ToString() ?? "";
    }
}
