#requires -Version 5.1
# Read-only: last Prepare-Forms result + parsed error lines. No park, no SQL UPDATE.
[CmdletBinding()]
param(
    [guid]$RunId
)
$ErrorActionPreference = 'Stop'
$agent = 'C:\Priority\tmp\agent-formprep'
$last = Join-Path $agent 'last.json'
$named = Join-Path $agent 'last-named.json'
if ($RunId) {
    $dir = Join-Path $agent $RunId.ToString().ToLowerInvariant()
    $last = Join-Path $dir 'result.json'
} elseif ((Test-Path -LiteralPath $named) -and (
        -not (Test-Path -LiteralPath $last) -or
        (Get-Item -LiteralPath $named).LastWriteTimeUtc -ge (Get-Item -LiteralPath $last).LastWriteTimeUtc
    )) {
    $last = $named
}
if (-not (Test-Path -LiteralPath $last)) { throw "No result at $last" }
Write-Host "resultJson=$last"
$obj = Get-Content -LiteralPath $last -Raw | ConvertFrom-Json
if ($obj.PSObject.Properties.Name -contains 'name' -and $obj.name) {
    Write-Host ("ok={0} reason={1} name={2} lastPrep {3}->{4} upd {5}->{6}" -f $obj.ok, $obj.reason, $obj.name, $obj.lastPrepBefore, $obj.lastPrepAfter, $obj.updBefore, $obj.updAfter)
} else {
    Write-Host ("ok={0} reason={1} exit={2} executor={3} parked={4} restored={5} restoreOk={6}" -f $obj.ok, $obj.reason, $obj.exitCode, $obj.executor, $obj.parkedCount, $obj.restoredCount, $obj.restoreOk)
    Write-Host 'prepared:'
    @($obj.prepared) | ForEach-Object { Write-Host ("  {0} upd={1} lastPrep {2}->{3}" -f $_.name, $_.upd, $_.lastPrepDateBefore, $_.lastPrepDateAfter) }
    Write-Host 'stillUnprepared:'
    @($obj.stillUnprepared) | ForEach-Object { Write-Host ("  {0}" -f $_.name) }
}
Write-Host 'errors (cap 200):'
$i = 0
foreach ($e in @($obj.errors)) {
    if ($i -ge 200) { break }
    Write-Host ("  [{0}] {1} {2}" -f $e.severity, $e.source, $e.text)
    $i++
}
$dir = Split-Path -Parent $last
$jsonl = Join-Path $dir 'capture\errors-report.jsonl'
if (Test-Path -LiteralPath $jsonl) {
    Write-Host "errors-report.jsonl=$jsonl"
}
exit 0
