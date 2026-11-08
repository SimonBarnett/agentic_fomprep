namespace PriorityAgent;

/// <summary>
/// Resolves the machine AI workspace root: look for X:\AI on ready drives in
/// C: → D: → E: … Z: order; if none exists, create \AI on the first ready drive
/// in that same order.
/// </summary>
public static class AiRoot
{
    public const string FolderName = "AI";

    public static IEnumerable<char> DriveOrder()
    {
        for (char c = 'C'; c <= 'Z'; c++)
            yield return c;
    }

    public static bool DriveReady(char letter)
    {
        try
        {
            var di = new DriveInfo(letter + @":\");
            return di.IsReady;
        }
        catch
        {
            return false;
        }
    }

    public static string AiPath(char letter) =>
        Path.Combine(letter + @":\", FolderName);

    /// <summary>
    /// Find an existing X:\AI (case-insensitive on Windows) in drive order,
    /// or create one on the first ready drive. Injectables support unit tests.
    /// </summary>
    public static string Resolve(
        Func<char, bool>? driveReady = null,
        Func<string, bool>? exists = null,
        Action<string>? create = null)
    {
        driveReady ??= DriveReady;
        exists ??= Directory.Exists;
        create ??= static p => { Directory.CreateDirectory(p); };

        foreach (char letter in DriveOrder())
        {
            if (!driveReady(letter)) continue;
            string path = AiPath(letter);
            if (exists(path))
                return Path.GetFullPath(path);
        }

        foreach (char letter in DriveOrder())
        {
            if (!driveReady(letter)) continue;
            string path = AiPath(letter);
            create(path);
            return Path.GetFullPath(path);
        }

        throw new InvalidOperationException(
            "No ready drive C:..Z: found to use or create \\AI.");
    }

    /// <summary>
    /// Search roots for existing clones: preferred clone root first, then every
    /// existing X:\AI and X:\repos on ready drives (C→Z).
    /// </summary>
    public static string[] BuildSearchRoots(
        string cloneRoot,
        Func<char, bool>? driveReady = null,
        Func<string, bool>? exists = null)
    {
        driveReady ??= DriveReady;
        exists ??= Directory.Exists;
        var list = new List<string>();

        void Add(string? p)
        {
            if (string.IsNullOrWhiteSpace(p)) return;
            string full = Path.GetFullPath(p);
            if (list.Any(x => string.Equals(x, full, StringComparison.OrdinalIgnoreCase)))
                return;
            list.Add(full);
        }

        Add(cloneRoot);
        foreach (char letter in DriveOrder())
        {
            if (!driveReady(letter)) continue;
            string ai = AiPath(letter);
            if (exists(ai)) Add(ai);
            string repos = Path.Combine(letter + @":\", "repos");
            if (exists(repos)) Add(repos);
        }
        return list.ToArray();
    }
}
