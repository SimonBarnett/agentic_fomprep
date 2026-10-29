using System.Net.Security;
using System.Net.Sockets;
using System.Text;
using System.Text.Json;

namespace PriorityAgent;

static class AircConsoleDiscovery
{
    const string ReportUrl = "https://irc.ntsa.uk/bob/v1/report";
    const string IrcHost = "irc.ntsa.uk";

    public static (List<string> Consoles, string Error) Discover()
    {
        string report = "";
        string reportError = "";
        try
        {
            using var http = new HttpClient { Timeout = TimeSpan.FromSeconds(8) };
            report = http.GetStringAsync(ReportUrl).GetAwaiter().GetResult();
        }
        catch (Exception ex) { reportError = ex.GetType().Name; }

        var channels = new List<string> { "#wonderland" };
        if (report != "")
        {
            try { channels.AddRange(AircSupport.MachineChannelsFromReport(report)); }
            catch (JsonException) { reportError = "invalid Bob report"; }
        }
        channels = channels.Distinct(StringComparer.OrdinalIgnoreCase).Take(101).ToList();

        try
        {
            using var client = new TcpClient();
            client.ConnectAsync(IrcHost, 6697).WaitAsync(TimeSpan.FromSeconds(8)).GetAwaiter().GetResult();
            using var tls = new SslStream(client.GetStream(), leaveInnerStreamOpen: false);
            tls.AuthenticateAsClientAsync(IrcHost).WaitAsync(TimeSpan.FromSeconds(8)).GetAwaiter().GetResult();
            using var reader = new StreamReader(tls, Encoding.UTF8, leaveOpen: true);
            using var writer = new StreamWriter(tls, new UTF8Encoding(false), leaveOpen: true) { AutoFlush = true, NewLine = "\r\n" };

            string nick = "pa-" + Guid.NewGuid().ToString("N")[..10];
            writer.WriteLine($"NICK {nick}");
            writer.WriteLine($"USER {nick} 0 * :Priority Agent read-only console discovery");
            ReadUntil(reader, writer, line => line.Contains(" 001 ", StringComparison.Ordinal), TimeSpan.FromSeconds(8));

            foreach (string channel in channels) writer.WriteLine("NAMES " + channel);
            var lines = new List<string>();
            var completed = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            while (completed.Count < channels.Count)
            {
                string line = ReadLine(reader, writer, TimeSpan.FromSeconds(12));
                lines.Add(line);
                string[] fields = line.Split(' ', 5, StringSplitOptions.RemoveEmptyEntries);
                if (fields.Length >= 4 && (fields[1] == "366" || fields[1] == "403" || fields[1] == "442"))
                    completed.Add(fields[3]);
            }
            writer.WriteLine("QUIT :read-only console discovery complete");
            return (AircSupport.ConsolesFromNames(lines), reportError);
        }
        catch (Exception ex)
        {
            return (new(), "NAMES lookup failed: " + ex.GetType().Name);
        }
    }

    static void ReadUntil(StreamReader reader, StreamWriter writer, Func<string, bool> done, TimeSpan timeout)
    {
        DateTime deadline = DateTime.UtcNow + timeout;
        while (DateTime.UtcNow < deadline)
        {
            string line = ReadLine(reader, writer, deadline - DateTime.UtcNow);
            if (done(line)) return;
        }
        throw new TimeoutException("IRC registration timed out");
    }

    static string ReadLine(StreamReader reader, StreamWriter writer, TimeSpan timeout)
    {
        string? line = reader.ReadLineAsync().WaitAsync(timeout).GetAwaiter().GetResult();
        if (line == null) throw new IOException("IRC connection closed");
        if (line.StartsWith("PING ", StringComparison.Ordinal))
            writer.WriteLine("PONG " + line[5..]);
        return line;
    }
}
