namespace PriorityAgent;

public enum CloneKind
{
    Missing,
    Stub,
    WrongOrigin,
    Dirty,
    Clean,
}

public sealed record CloneSighting(string Path, CloneKind Kind);

public static class CloneResolve
{
    public static string Describe(CloneSighting sighting) => sighting.Kind switch
    {
        CloneKind.Missing => $"{sighting.Path}: missing",
        CloneKind.Stub => $"{sighting.Path}: empty stub (no .git)",
        CloneKind.WrongOrigin => $"{sighting.Path}: exists but origin is not this repo",
        CloneKind.Dirty => $"{sighting.Path}: valid clone with uncommitted changes",
        CloneKind.Clean => $"{sighting.Path}: valid clean clone",
        _ => sighting.Path,
    };

    public static string? SelectUsable(IReadOnlyList<CloneSighting> sightings, out string? chosenReason)
    {
        foreach (var s in sightings)
        {
            if (s.Kind is CloneKind.Clean or CloneKind.Dirty)
            {
                chosenReason = s.Kind == CloneKind.Dirty
                    ? "using dirty clone (skip pull)"
                    : "using clean clone";
                return s.Path;
            }
        }
        chosenReason = null;
        return null;
    }

    public static string FatalUnavailable(string fullName, IReadOnlyList<CloneSighting> sightings)
    {
        string listed = sightings.Count == 0
            ? "(no candidate paths searched)"
            : string.Join("; ", sightings.Select(Describe));
        return $"agentic_fomprep clone unavailable for {fullName}. Candidates: {listed}. Rename/remove an empty stub, or use --root / PRIORITY_AGENT_ROOT pointing at a real clone.";
    }
}
