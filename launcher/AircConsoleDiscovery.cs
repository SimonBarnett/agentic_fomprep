using System.Text.Json;

namespace PriorityAgent;

public sealed record AircConsoleDiscoveryResult(bool Available, IReadOnlyList<string> Consoles, string Error)
{
    public static AircConsoleDiscoveryResult Unavailable(string error) => new(false, Array.Empty<string>(), error);
    public static AircConsoleDiscoveryResult AvailableWith(IEnumerable<string> consoles) =>
        new(true, AircSupport.NormalizeConsoles(consoles), "");
}

static class AircConsoleDiscovery
{
    public const string DefaultReportUrl = "https://bob.ntsa.uk/bob/v1/report";
    public static readonly TimeSpan DefaultTimeout = TimeSpan.FromSeconds(8);

    /// <summary>
    /// FR #258: credential-free listing from Bob digest <c>airc_consoles</c>
    /// (fallback: per-machine <c>console_nicks</c>). Override with env
    /// <c>PRIORITY_AGENT_AIRC_REPORT_JSON</c> (file path) or
    /// <c>PRIORITY_AGENT_REPORT_URL</c> for tests. An explicit <paramref name="fetch"/>
    /// always wins over the fixture env (MRB #259: CI sets the fixture for dry-runs).
    /// </summary>
    public static AircConsoleDiscoveryResult Discover(
        string? reportUrl = null,
        TimeSpan? timeout = null,
        Func<Uri, TimeSpan, string>? fetch = null)
    {
        try
        {
            // Injectable fetch overrides process-level fixture so unit tests stay
            // hermetic when CI exports PRIORITY_AGENT_AIRC_REPORT_JSON for dry-runs.
            if (fetch == null)
            {
                string? fixturePath = Environment.GetEnvironmentVariable("PRIORITY_AGENT_AIRC_REPORT_JSON");
                if (!string.IsNullOrWhiteSpace(fixturePath))
                {
                    if (!File.Exists(fixturePath))
                        return AircConsoleDiscoveryResult.Unavailable(
                            "Bob report fixture missing: " + fixturePath);
                    return ParseReport(File.ReadAllText(fixturePath));
                }
            }

            string urlText = string.IsNullOrWhiteSpace(reportUrl)
                ? (Environment.GetEnvironmentVariable("PRIORITY_AGENT_REPORT_URL") ?? DefaultReportUrl)
                : reportUrl!;
            if (!Uri.TryCreate(urlText, UriKind.Absolute, out Uri? uri)
                || (uri.Scheme != Uri.UriSchemeHttp && uri.Scheme != Uri.UriSchemeHttps))
            {
                return AircConsoleDiscoveryResult.Unavailable("Bob report URL is invalid.");
            }

            TimeSpan to = timeout ?? DefaultTimeout;
            Func<Uri, TimeSpan, string> getter = fetch ?? FetchReport;
            string json = getter(uri, to);
            return ParseReport(json);
        }
        catch (Exception ex)
        {
            return AircConsoleDiscoveryResult.Unavailable("Bob report unavailable: " + ex.Message);
        }
    }

    public static AircConsoleDiscoveryResult ParseReport(string reportJson)
    {
        if (string.IsNullOrWhiteSpace(reportJson))
            return AircConsoleDiscoveryResult.Unavailable("Bob report body was empty.");

        JsonDocument doc;
        try { doc = JsonDocument.Parse(reportJson); }
        catch (JsonException ex)
        {
            return AircConsoleDiscoveryResult.Unavailable("Bob report JSON was invalid: " + ex.Message);
        }

        using (doc)
        {
            var root = doc.RootElement;
            if (root.ValueKind != JsonValueKind.Object)
                return AircConsoleDiscoveryResult.Unavailable("Bob report root was not an object.");

            bool sawAircConsoles = root.TryGetProperty("airc_consoles", out var aircConsoles);
            if (sawAircConsoles)
            {
                if (aircConsoles.ValueKind == JsonValueKind.Null)
                    return AircConsoleDiscoveryResult.AvailableWith(Array.Empty<string>());
                if (aircConsoles.ValueKind != JsonValueKind.Array)
                    return AircConsoleDiscoveryResult.Unavailable(
                        "Bob report airc_consoles was not an array.");
                var fromTop = new List<string>();
                foreach (var item in aircConsoles.EnumerateArray())
                {
                    if (item.ValueKind == JsonValueKind.String)
                    {
                        string? s = item.GetString();
                        if (!string.IsNullOrWhiteSpace(s)) fromTop.Add(s);
                    }
                }
                return AircConsoleDiscoveryResult.AvailableWith(fromTop);
            }

            // Fallback: collect machines.*.console_nicks when top-level list is absent.
            if (root.TryGetProperty("machines", out var machines)
                && machines.ValueKind == JsonValueKind.Object)
            {
                var fromMachines = new List<string>();
                bool sawNickField = false;
                foreach (var machine in machines.EnumerateObject())
                {
                    if (!machine.Value.TryGetProperty("console_nicks", out var nicks))
                        continue;
                    sawNickField = true;
                    if (nicks.ValueKind != JsonValueKind.Array) continue;
                    foreach (var item in nicks.EnumerateArray())
                    {
                        if (item.ValueKind == JsonValueKind.String)
                        {
                            string? s = item.GetString();
                            if (!string.IsNullOrWhiteSpace(s)) fromMachines.Add(s);
                        }
                    }
                }
                if (sawNickField)
                    return AircConsoleDiscoveryResult.AvailableWith(fromMachines);
            }

            return AircConsoleDiscoveryResult.Unavailable(
                "Bob report has no airc_consoles (and no machines.*.console_nicks).");
        }
    }

    static string FetchReport(Uri uri, TimeSpan timeout)
    {
        using var http = new HttpClient { Timeout = timeout };
        return http.GetStringAsync(uri).GetAwaiter().GetResult();
    }
}
