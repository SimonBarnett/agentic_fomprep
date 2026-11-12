using System.Text.Json;

namespace PriorityAgent;

/// <summary>
/// FR #385 / FR-003: read the user-profile last-user file (written by FR-002)
/// so the interactive prompt can offer the saved USERLOGIN.
/// </summary>
public static class LastUserFile
{
    public const string EnvPath = "PRIORITY_AGENT_LAST_USER_FILE";

    public static string DefaultPath()
    {
        string profile = Environment.GetFolderPath(Environment.SpecialFolder.UserProfile);
        if (string.IsNullOrWhiteSpace(profile))
            profile = Environment.GetEnvironmentVariable("USERPROFILE") ?? "";
        return Path.Combine(profile, ".priority-agent", "last-user.json");
    }

    public static string ResolvePath()
    {
        string? overridePath = Environment.GetEnvironmentVariable(EnvPath);
        if (!string.IsNullOrWhiteSpace(overridePath))
            return overridePath.Trim();
        return DefaultPath();
    }

    public static string? ReadUserLogin(string? instanceId, string? path = null)
    {
        string id = (instanceId ?? "").Trim();
        if (id.Length == 0)
            return null;
        string file = string.IsNullOrWhiteSpace(path) ? ResolvePath() : path.Trim();
        if (!File.Exists(file))
            return null;
        try
        {
            using var doc = JsonDocument.Parse(File.ReadAllText(file));
            if (doc.RootElement.ValueKind != JsonValueKind.Object)
                return null;
            if (!doc.RootElement.TryGetProperty(id, out var row) || row.ValueKind != JsonValueKind.Object)
                return null;
            if (!row.TryGetProperty("userLogin", out var loginEl) || loginEl.ValueKind != JsonValueKind.String)
                return null;
            string login = (loginEl.GetString() ?? "").Trim();
            if (!BobHours.IsPriorityUserLogin(login))
                return null;
            return login;
        }
        catch
        {
            return null;
        }
    }

    public static string FormatPrompt(string? savedLogin)
    {
        string saved = (savedLogin ?? "").Trim();
        if (saved.Length > 0 && BobHours.IsPriorityUserLogin(saved))
            return "Priority USERLOGIN [" + saved + "]: ";
        return "Priority USERLOGIN for this session: ";
    }

    /// <summary>
    /// --hours-user wins. Empty typed answer binds the saved login when present.
    /// </summary>
    public static string? ChooseRequestedUser(string? hoursUserArg, string? typedAnswer, string? savedLogin)
    {
        string flag = (hoursUserArg ?? "").Trim();
        if (flag.Length > 0)
            return flag;
        string typed = (typedAnswer ?? "").Trim();
        if (typed.Length > 0)
            return typed;
        string saved = (savedLogin ?? "").Trim();
        if (saved.Length > 0 && BobHours.IsPriorityUserLogin(saved))
            return saved;
        return null;
    }

    public static int GrokStartCount;

    public readonly record struct FlagWhoamiCheck(bool Ok, int ExitCode, string Detail);

    /// <summary>
    /// FR #387 / FR-005: --hours-user that differs from whoami does not start Grok
    /// and does not rewrite last-user.json.
    /// </summary>
    public static FlagWhoamiCheck CheckFlagAgainstWhoami(string? hoursUser, string? whoamiLogin)
    {
        string flag = (hoursUser ?? "").Trim();
        string who = (whoamiLogin ?? "").Trim();
        if (flag.Length == 0 || who.Length == 0)
            return new(true, 0, "no hours-user/whoami pair");
        if (string.Equals(flag, who, StringComparison.Ordinal))
            return new(true, 0, "hours-user matches whoami");
        return new(
            false,
            2,
            "--hours-user " + flag + " disagrees with whoami " + who);
    }

    public static void NoteGrokStart() => GrokStartCount++;
}
