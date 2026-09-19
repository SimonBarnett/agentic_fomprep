#requires -Version 5.1
<#
.SYNOPSIS
    Off-DEV pack check: parse every script, validate JSON schema file, run AT6 + unit-mutex.
    Does not connect to 10.220.0.5\DEV or to Priority web.
#>
[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
$failed = 0

Write-Host '--- WP0 (v2 shell compile/install fail-fast) ---'
$wp0 = Join-Path $repo 'v2\tools\Test-WP0.ps1'
if (-not (Test-Path -LiteralPath $wp0)) {
    Write-Host 'WP0 FAIL missing v2\tools\Test-WP0.ps1'
    $failed++
} else {
    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $wp0
    if ($LASTEXITCODE -ne 0) {
        Write-Host "WP0 FAIL exit $LASTEXITCODE"
        $failed++
    }
}

function Test-Parse([string]$Path) {
    $tok = $null
    $err = $null
    [void][System.Management.Automation.Language.Parser]::ParseFile($Path, [ref]$tok, [ref]$err)
    if ($err -and $err.Count -gt 0) {
        foreach ($e in $err) {
            Write-Host "PARSE FAIL $Path : $($e.Message) at $($e.Extent.StartLineNumber)"
        }
        return $false
    }
    return $true
}

$files = Get-ChildItem -LiteralPath $repo -Recurse -File |
    Where-Object {
        $_.Extension -in @('.ps1', '.psm1', '.psd1') -and
        $_.FullName -notmatch '\\node_modules\\'
    }
foreach ($f in $files) {
    if (-not (Test-Parse $f.FullName)) { $failed++ }
}

$schema = Join-Path $repo 'schemas\prepare-forms-result.schema.json'
try {
    [void](Get-Content -LiteralPath $schema -Raw | ConvertFrom-Json)
    Write-Host "SCHEMA OK $schema"
} catch {
    Write-Host "SCHEMA FAIL $($_.Exception.Message)"
    $failed++
}

$mjs = Join-Path $repo 'src\web\formprep.mjs'
if (-not (Test-Path -LiteralPath $mjs)) {
    Write-Host 'MISSING src/web/formprep.mjs'
    $failed++
}

Write-Host '--- AT6 ---'
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $repo 'tests\AT6-refuse-non-dev.ps1')
if ($LASTEXITCODE -ne 0) {
    Write-Host "AT6 FAIL exit $LASTEXITCODE"
    $failed++
}

Write-Host '--- unit-mutex ---'
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $repo 'tests\unit-mutex.ps1')
if ($LASTEXITCODE -ne 0) {
    Write-Host "unit-mutex FAIL exit $LASTEXITCODE"
    $failed++
}

Write-Host '--- unit-lastprep ---'
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $repo 'tests\unit-lastprep.ps1')
if ($LASTEXITCODE -ne 0) {
    Write-Host "unit-lastprep FAIL exit $LASTEXITCODE"
    $failed++
}

Write-Host '--- unit-lock-execid ---'
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $repo 'tests\unit-lock-execid.ps1')
if ($LASTEXITCODE -ne 0) {
    Write-Host "unit-lock-execid FAIL exit $LASTEXITCODE"
    $failed++
}

Write-Host '--- unit-error-parse ---'
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $repo 'tests\unit-error-parse.ps1')
if ($LASTEXITCODE -ne 0) {
    Write-Host "unit-error-parse FAIL exit $LASTEXITCODE"
    $failed++
}

Write-Host '--- AT3 fixture ---'
& powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $repo 'tests\AT3-index-dialog.ps1')
if ($LASTEXITCODE -ne 0) {
    Write-Host "AT3 FAIL exit $LASTEXITCODE"
    $failed++
}

if ($failed -gt 0) {
    Write-Host "Test-Pack FAIL ($failed)"
    exit 1
}
Write-Host 'Test-Pack PASS'
exit 0
