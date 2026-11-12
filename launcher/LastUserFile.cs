using System.Text.Json;

namespace PriorityAgent;

/// <summary>
/// Read the user-profile last-user file (written by FR-002 / #384)
/// for launcher USERLOGIN resolution (FR-003 / FR-004).
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

    /// <summary>
    /// FR #386 / FR-004: resolve USERLOGIN for launch without calling ReadLine.
    /// When stdin is redirected, bind the saved login if present; otherwise leave null
    /// so BindSessionOwner returns Priority USERLOGIN unavailable (exit 2).
    /// Interactive typing is supplied by the caller after Ask; this method never blocks.
    /// </summary>
    public static string? ResolveLaunchUser(
        string? hoursUserArg,
        bool inputRedirected,
        string? savedLogin,
        string? typedAnswer)
    {
        string flag = (hoursUserArg ?? "").Trim();
        if (flag.Length > 0)
            return flag;
        if (inputRedirected)
            return ChooseRequestedUser(null, null, savedLogin);
        return ChooseRequestedUser(null, typedAnswer, null);
    }
}
