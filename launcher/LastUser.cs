using System.Text;
using System.Text.Json;

namespace PriorityAgent;

/// <summary>
/// FR #384 / FR-002: persist a whoami USERLOGIN per instance under the user profile.
/// </summary>
public static class LastUser
{
    public const string RelativeDir = ".priority-agent";
    public const string FileName = "last-user.json";

    public static string FilePath(string userProfile) =>
        Path.Combine(userProfile ?? "", RelativeDir, FileName);

    public readonly record struct SaveResult(bool Ok, string Detail, string Path);

    /// <summary>
    /// Successful whoami: write userLogin, company, identifiedAt, source under instance id.
    /// Refuses a login that fails <see cref="BobHours.IsPriorityUserLogin"/> and leaves the file unchanged.
    /// Never writes access_token, refresh_token, or password keys.
    /// </summary>
    public static SaveResult RememberWhoami(
        string userProfile,
        string instanceId,
        string? userLogin,
        string? company,
        string? source,
        DateTimeOffset identifiedAt)
    {
        string path = FilePath(userProfile);
        string instance = (instanceId ?? "").Trim();
        if (instance.Length == 0 || instance.IndexOfAny(Path.GetInvalidFileNameChars()) >= 0)
            return new(false, "instance id is not usable", path);

        string login = (userLogin ?? "").Trim();
        if (!BobHours.IsPriorityUserLogin(login))
            return new(false, "Priority USERLOGIN is not a usable login", path);

        string co = (company ?? "").Trim();
        string src = string.IsNullOrWhiteSpace(source) ? "whoami" : source.Trim();
        string at = identifiedAt.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ");

        Dictionary<string, JsonElement> root = ReadObject(path);
        using var valueDoc = JsonDocument.Parse(JsonSerializer.Serialize(new Dictionary<string, string>
        {
            ["userLogin"] = login,
            ["company"] = co,
            ["identifiedAt"] = at,
            ["source"] = src,
        }));
        root[instance] = valueDoc.RootElement.Clone();

        var outbound = new Dictionary<string, object?>();
        foreach (var kv in root)
            outbound[kv.Key] = JsonSerializer.Deserialize<Dictionary<string, string>>(kv.Value.GetRawText());

        Directory.CreateDirectory(Path.GetDirectoryName(path)!);
        string json = JsonSerializer.Serialize(outbound, new JsonSerializerOptions { WriteIndented = true });
        if (json.Contains("access_token", StringComparison.Ordinal)
            || json.Contains("refresh_token", StringComparison.Ordinal))
            return new(false, "refusing to write token keys", path);

        var utf8 = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false);
        string tmp = path + ".tmp";
        File.WriteAllText(tmp, json, utf8);
        File.Copy(tmp, path, overwrite: true);
        File.Delete(tmp);
        return new(true, "whoami saved", path);
    }

    public static int RunFr384SelfTest()
    {
        int failed = 0;
        void Gate(string id, bool pass, string detail)
        {
            Console.WriteLine((pass ? "PASS " : "FAIL ") + id + " " + detail);
            if (!pass) failed++;
        }

        string profile = Path.Combine(Path.GetTempPath(), "fr384-" + Guid.NewGuid().ToString("N"));
        try
        {
            Directory.CreateDirectory(profile);
            DateTimeOffset at = DateTimeOffset.Parse("2026-11-12T11:00:00Z");
            var ok = RememberWhoami(profile, "saas1", "UserOne", "DEMO", "whoami", at);
            string path = FilePath(profile);
            byte[] raw = File.Exists(path) ? File.ReadAllBytes(path) : Array.Empty<byte>();
            string text = raw.Length > 0 ? Encoding.UTF8.GetString(raw) : "";
            Gate("whoami-saas1",
                ok.Ok && File.Exists(path) && text.Contains("\"saas1\"", StringComparison.Ordinal)
                && text.Contains("\"userLogin\": \"UserOne\"", StringComparison.Ordinal)
                && text.Contains("\"company\": \"DEMO\"", StringComparison.Ordinal)
                && text.Contains("\"source\": \"whoami\"", StringComparison.Ordinal),
                ok.Detail + " " + text);
            Gate("no-bom",
                raw.Length < 3 || raw[0] != 0xef || raw[1] != 0xbb || raw[2] != 0xbf,
                "utf8");
            Gate("no-access-token",
                !text.Contains("access_token", StringComparison.Ordinal)
                && !text.Contains("refresh_token", StringComparison.Ordinal)
                && !text.Contains("\"password\"", StringComparison.Ordinal),
                "keys");

            string previous = text;
            var refused = RememberWhoami(profile, "saas1", "bad login", "DEMO", "whoami", at);
            string after = File.ReadAllText(path, new UTF8Encoding(false));
            Gate("space-refused",
                !refused.Ok && after == previous,
                refused.Detail);
        }
        finally
        {
            try { Directory.Delete(profile, true); } catch { }
        }

        Console.WriteLine(failed == 0 ? "FR-384 last-user self-test PASS" : "FR-384 last-user self-test FAIL " + failed);
        return failed == 0 ? 0 : 1;
    }

    static Dictionary<string, JsonElement> ReadObject(string path)
    {
        var map = new Dictionary<string, JsonElement>(StringComparer.Ordinal);
        if (!File.Exists(path)) return map;
        try
        {
            using var doc = JsonDocument.Parse(File.ReadAllText(path, new UTF8Encoding(false)));
            if (doc.RootElement.ValueKind != JsonValueKind.Object) return map;
            foreach (var p in doc.RootElement.EnumerateObject())
                map[p.Name] = p.Value.Clone();
        }
        catch (JsonException)
        {
            return map;
        }
        return map;
    }
}
