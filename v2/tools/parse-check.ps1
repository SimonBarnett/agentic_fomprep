#requires -Version 5.1
<#
.SYNOPSIS
    Parse-check key v2 shell + formprep PowerShell entrypoints (offline).
#>
$ErrorActionPreference = 'Stop'
$v2 = Split-Path -Parent $PSScriptRoot
$repo = Split-Path -Parent $v2
$files = @(
    (Join-Path $v2 'apps\mcp-catalog\catalog\priority-formprep\runner\Prepare-NamedForm.ps1')
    (Join-Path $v2 'apps\mcp-catalog\catalog\priority-shell-compile\runner\Compile-Shell.ps1')
    (Join-Path $v2 'apps\mcp-catalog\catalog\priority-shell-install\runner\Install-Shell.ps1')
    (Join-Path $v2 'plugins\priority-formprep\scripts\Prepare-NamedForm.ps1')
    (Join-Path $v2 'plugins\priority-shell-compile\scripts\Compile-Shell.ps1')
    (Join-Path $v2 'plugins\priority-shell-install\scripts\Install-Shell.ps1')
    (Join-Path $v2 'lib\sql.ps1')
    (Join-Path $v2 'lib\Get-WinrunCredential.ps1')
)
$failed = 0
foreach ($f in $files) {
    if (-not (Test-Path -LiteralPath $f)) {
        $failed++
        Write-Host "MISSING $f"
        continue
    }
    $tok = $null
    $err = $null
    [void][System.Management.Automation.Language.Parser]::ParseFile($f, [ref]$tok, [ref]$err)
    if ($err -and $err.Count -gt 0) {
        $failed++
        Write-Host "PARSE FAIL $f"
        foreach ($e in $err) { Write-Host $e.Message }
    } else {
        Write-Host "PARSE OK $f"
    }
}
if ($failed -gt 0) { exit 1 }
exit 0
