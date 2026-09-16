#requires -Version 5.1
# WP3: parked 1-form CLI probe. Pass A = LASTPREPDATE advanced. Pass B = documented no-op.
# Never SQL-flip UPD=N. Never run web.
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
if (-not (Test-FormPrepDevHost)) {
    Write-Host 'WP3 SKIP: not on AllowedComputer.'
    exit 0
}
Import-FormPrepModule
$cfg = Get-DevConfig
$name = 'ZCLA_PARTLONGDESC'

$what = Prepare-Forms -Names $name -Environment DEV -WhatIf
Write-Host $what.reason
$conn = New-FormPrepSqlConnection -Config $cfg
$lockTable = ConvertTo-SqlIdent $cfg.LockTable
$execTable = ConvertTo-SqlIdent $cfg.ExecTable
$lId = ConvertTo-SqlIdent $cfg.LockCols.ExecId
$lUpd = ConvertTo-SqlIdent $cfg.LockCols.Upd
$lPrep = ConvertTo-SqlIdent $cfg.LockCols.LastPrep
$eId = ConvertTo-SqlIdent $cfg.ExecIdCol
$eName = ConvertTo-SqlIdent $cfg.ExecNameCol
$yBefore = [int](Invoke-FormPrepSql -Connection $conn -Query "SELECT COUNT(*) FROM $lockTable WHERE $lUpd = N'Y'" -Scalar)
$snap = Invoke-FormPrepSql -Connection $conn -Query @"
SELECT E.$eName AS name, E.$eId AS exec_id, L.$lUpd AS upd, L.$lPrep AS last_prep
FROM $execTable E
JOIN $lockTable L ON L.$lId = E.$eId
WHERE E.$eName = @n
"@ -Parameters @{ '@n' = $name }
if ($snap.Rows.Count -ne 1) { throw "WP3 missing $name" }
$before = [pscustomobject]@{
    Name     = [string]$snap.Rows[0].name
    ExecId   = [int64]$snap.Rows[0].exec_id
    Upd      = [string]$snap.Rows[0].upd
    LastPrep = [int64]$snap.Rows[0].last_prep
}
Write-Host ("WP3 before {0} exec={1} upd={2} lastPrep={3} Y={4}" -f $before.Name, $before.ExecId, $before.Upd, $before.LastPrep, $yBefore)
$conn.Close(); $conn.Dispose()

$result = Prepare-Forms -Names $name -Environment DEV -SkipWeb -CliTimeoutSeconds 60
Write-Host ("WP3 exit={0} reason={1} ok={2} parked={3} restored={4} restoreOk={5} executor={6}" -f $result.exitCode, $result.reason, $result.ok, $result.parkedCount, $result.restoredCount, $result.restoreOk, $result.executor)

$conn = New-FormPrepSqlConnection -Config $cfg
try {
    $open = [int](Invoke-FormPrepSql -Connection $conn -Query "SELECT COUNT(*) FROM dbo.AGENT_FORMPREP_PARK WHERE restored_at IS NULL" -Scalar)
    $yAfter = [int](Invoke-FormPrepSql -Connection $conn -Query "SELECT COUNT(*) FROM $lockTable WHERE $lUpd = N'Y'" -Scalar)
    $afterT = Invoke-FormPrepSql -Connection $conn -Query @"
SELECT E.$eName AS name, L.$lUpd AS upd, L.$lPrep AS last_prep
FROM $execTable E
JOIN $lockTable L ON L.$lId = E.$eId
WHERE E.$eName = @n
"@ -Parameters @{ '@n' = $name }
    $after = [pscustomobject]@{
        Name     = [string]$afterT.Rows[0].name
        Upd      = [string]$afterT.Rows[0].upd
        LastPrep = [int64]$afterT.Rows[0].last_prep
    }
    Write-Host ("WP3 after  {0} upd={1} lastPrep={2} Y={3} open={4}" -f $after.Name, $after.Upd, $after.LastPrep, $yAfter, $open)
    if ($open -ne 0) { throw "WP3 left $open OPEN park rows" }
    if (-not $result.restoreOk) { throw 'WP3 restoreOk=false' }

    $runDir = Join-Path $cfg.AgentWork $result.runId
    $cliLog = Join-Path $runDir 'cli-stdout.txt'
    if (-not (Test-Path -LiteralPath $cliLog)) { throw "WP3 missing $cliLog" }
    $cliText = [System.IO.File]::ReadAllText($cliLog)
    if ($cliText -match '(?i)password\s*[:=]') { throw 'WP3 cli-stdout.txt looks like it contains a password' }
    $json = [System.IO.File]::ReadAllText((Join-Path $runDir 'result.json'))
    if ($json -match '(?i)"(password|siPass|connectionstring)"\s*:') { throw 'WP3 result.json looks like it contains a password' }

    $moved = (([string]$after.Upd).Trim() -eq 'N') -and ([int64]$after.LastPrep -gt [int64]$before.LastPrep)
    if ($moved) {
        if ($result.executor -ne 'cli') { throw "WP3 SQL moved but executor=$($result.executor)" }
        Write-Host 'WP3 PASS A: LASTPREPDATE advanced, executor=cli'
    } else {
        if ($result.executor -eq 'cli') { throw 'WP3 executor=cli but LASTPREPDATE did not move' }
        if ($cliText -notmatch 'no_cred|winrun_missing|timeout|CLI skipped|exit=') {
            throw "WP3 no-op without evidence in cli-stdout.txt: $cliText"
        }
        if ($result.reason -ne 'cli_noop' -and $result.parkedCount -gt 0) {
            throw "WP3 expected reason=cli_noop got $($result.reason)"
        }
        Write-Host 'WP3 PASS B: CLI no-op with evidence; park restored; no SQL flip'
    }
} finally {
    $conn.Close(); $conn.Dispose()
}
exit 0
