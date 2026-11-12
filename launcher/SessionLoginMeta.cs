using System.Text.Json;

namespace PriorityAgent;

/// <summary>
/// FR #388 / FR-006: session identity records priorityUserLogin and userLoginSource.
/// </summary>
public static class SessionLoginMeta
{
    public const string SourceClient = "client";
    public const string SourceSaved = "saved";
    public const string SourceFlag = "flag";

    public static string ClassifySource(string? hoursUserArg, string? typedAnswer, string? savedLogin)
    {
        if (!string.IsNullOrWhiteSpace(hoursUserArg))
            return SourceFlag;
        if (!string.IsNullOrWhiteSpace(typedAnswer))
            return SourceClient;
        string saved = (savedLogin ?? "").Trim();
        if (saved.Length > 0 && BobHours.IsPriorityUserLogin(saved))
            return SourceSaved;
        return SourceClient;
    }

    public static void WriteIdentity(string sessionDir, string userLogin, string source)
    {
        Directory.CreateDirectory(sessionDir);
        string path = Path.Combine(sessionDir, "identity.json");
        if (File.Exists(path))
            return;
        File.WriteAllText(path, JsonSerializer.Serialize(new Dictionary<string, string>
        {
            ["priorityUserLogin"] = userLogin,
            ["userLoginSource"] = source,
        }));
    }

    public static void WriteHoursRoutingLogin(string sessionDir, string userLogin, BobHours.CustomerHoursConfig routing)
    {
        Directory.CreateDirectory(sessionDir);
        string path = Path.Combine(sessionDir, "hours-routing.json");
        if (File.Exists(path))
            return;
        File.WriteAllText(path, JsonSerializer.Serialize(new Dictionary<string, string>
        {
            ["on_behalf_of"] = userLogin,
            ["customer"] = routing.Customer,
            ["project"] = routing.Project,
            ["priority_project"] = routing.PriorityProject,
            ["wbs_status"] = routing.WbsStatus,
        }));
    }
}
