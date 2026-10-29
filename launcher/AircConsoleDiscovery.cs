namespace PriorityAgent;

public sealed record AircConsoleDiscoveryResult(bool Available, IReadOnlyList<string> Consoles, string Error)
{
    public static AircConsoleDiscoveryResult Unavailable(string error) => new(false, Array.Empty<string>(), error);
    public static AircConsoleDiscoveryResult AvailableWith(IEnumerable<string> consoles) =>
        new(true, AircSupport.NormalizeConsoles(consoles), "");
}

static class AircConsoleDiscovery
{
    public static AircConsoleDiscoveryResult Discover() =>
        AircConsoleDiscoveryResult.Unavailable(
            "irc.ntsa.uk requires authentication, and the Bob report does not list connected customer consoles. A credential-free connected-console listing is not currently available.");
}
