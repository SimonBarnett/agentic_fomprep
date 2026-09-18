#requires -Version 5.1
$ErrorActionPreference = 'Stop'
$files = @(
    'M:\py\agentic_fomprep\v2\apps\mcp-catalog\catalog\priority-formprep\runner\Prepare-NamedForm.ps1'
    'M:\py\agentic_fomprep\v2\apps\mcp-catalog\catalog\priority-formprep\runner\lib\sql.ps1'
    'M:\py\agentic_fomprep\v2\apps\mcp-catalog\catalog\priority-formprep\runner\lib\Get-WinrunCredential.ps1'
    'M:\py\agentic_fomprep\v2\plugins\priority-formprep\scripts\Prepare-NamedForm.ps1'
)
$failed = 0
foreach ($f in $files) {
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
