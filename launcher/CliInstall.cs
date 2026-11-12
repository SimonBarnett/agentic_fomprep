// FR #568: official CLI installers as the interactive user. Tests inject runners (no live network).
using System.Security.Principal;

namespace PriorityAgent;

public sealed record CliInstallPlan(
    CliKind Kind,
    string FileName,
    string Arguments,
    bool InteractiveUserRequired);

public sealed record CliInstallResult(
    CliKind Kind,
    bool Ran,
    string? CommandLine,
    string? User,
    bool LocalSystem,
    string Reason);

public static class CliInstall
{
    public const string GrokInstallScript = "https://x.ai/cli/install.ps1";
    public const string CursorInstallScript = "https://cursor.com/install?win32=true";
    public const string OpenCodeInstallPage = "https://opencode.ai/docs/windows";

    public static bool IsLocalSystem(WindowsIdentity? id = null)
    {
        if (!OperatingSystem.IsWindows())
            return false;
        try
        {
            id ??= WindowsIdentity.GetCurrent();
            return id.IsSystem;
        }
        catch
        {
            return false;
        }
    }

    public static CliInstallPlan Plan(CliKind kind, string? openCodeBinaryUrl = null)
    {
        return kind switch
        {
            CliKind.Grok => new(
                CliKind.Grok,
                "powershell.exe",
                "-NoProfile -ExecutionPolicy Bypass -Command \"irm " + GrokInstallScript + " | iex\"",
                true),
            CliKind.Cursor => new(
                CliKind.Cursor,
                "powershell.exe",
                "-NoProfile -ExecutionPolicy Bypass -Command \"irm '" + CursorInstallScript + "' | iex\"",
                true),
            CliKind.OpenCode => new(
                CliKind.OpenCode,
                "powershell.exe",
                "-NoProfile -ExecutionPolicy Bypass -Command \"" +
                OpenCodeDownloadCommand(openCodeBinaryUrl) + "\"",
                true),
            _ => throw new ArgumentOutOfRangeException(nameof(kind)),
        };
    }

    public static string? ParseOpenCodeWindowsBinaryUrl(string installPageHtml)
    {
        if (string.IsNullOrWhiteSpace(installPageHtml))
            return null;
        var matches = System.Text.RegularExpressions.Regex.Matches(
            installPageHtml,
            @"https://[^\s""']+(?:windows|win-x64|win64)[^\s""']*\.(?:exe|zip)",
            System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        return matches.Count > 0 ? matches[0].Value : null;
    }

    static string OpenCodeDownloadCommand(string? url)
    {
        // PowerShell must expand $env:USERPROFILE (cmd percent-USERPROFILE stays literal).
        // Create .opencode\bin itself; Split-Path of that path would only create .opencode.
        string dest = "$env:USERPROFILE\\.opencode\\bin\\opencode.exe";
        string u = string.IsNullOrWhiteSpace(url) ? "URL_FROM_INSTALL_PAGE" : url.Replace("\"", "");
        return "New-Item -ItemType Directory -Force -Path $env:USERPROFILE\\.opencode\\bin | Out-Null; " +
               "Invoke-WebRequest -UseBasicParsing -Uri '" + u + "' -OutFile \"" + dest + "\"";
    }

    public static CliInstallResult Run(
        CliKind kind,
        Func<CliInstallPlan, int> runner,
        bool? localSystem = null,
        string? user = null,
        string? openCodeBinaryUrl = null)
    {
        bool sys = localSystem ?? IsLocalSystem();
        string who = user ?? Environment.UserName;
        if (sys)
        {
            return new(kind, false, null, who, true, "refuse LocalSystem installer");
        }
        var plan = Plan(kind, openCodeBinaryUrl);
        string cmd = plan.FileName + " " + plan.Arguments;
        int code = runner(plan);
        return new(kind, code == 0, cmd, who, false, code == 0 ? "ok" : "installer exit " + code);
    }
}
