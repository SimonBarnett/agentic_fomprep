#requires -Version 5.1
# P0-T1: force three named forms UPD=Y (do not zero LASTPREPDATE), park+CLI, assert bigint lastprep moved.
# Web selectors are unverified (P0-W1); this run uses -SkipWeb. Do not SQL-flip UPD=N.
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
if (-not (Test-FormPrepDevHost)) {
    Write-Host 'AT1 SKIP: not on AllowedComputer.'
    exit 0
}
Import-FormPrepModule
$cfg = Get-DevConfig
$names = @('ZCLA_PARTLONGDESC', 'ZCLA_PARTLONGDHIST', 'ZCLA_PARTLONGDREV')
$conn = New-FormPrepSqlConnection -Config $cfg
$lockTable = ConvertTo-SqlIdent $cfg.LockTable
$execTable = ConvertTo-SqlIdent $cfg.ExecTable
$lId = ConvertTo-SqlIdent $cfg.LockCols.ExecId
$lUpd = ConvertTo-SqlIdent $cfg.LockCols.Upd
$lPrep = ConvertTo-SqlIdent $cfg.LockCols.LastPrep
$eId = ConvertTo-SqlIdent $cfg.ExecIdCol
$eName = ConvertTo-SqlIdent $cfg.ExecNameCol

function Get-YCount($c) {
    return [int](Invoke-FormPrepSql -Connection $c -Query "SELECT COUNT(*) FROM $lockTable WHERE $lUpd = N'Y'" -Scalar)
}

$yBefore = Get-YCount $conn
$snapTable = Invoke-FormPrepSql -Connection $conn -Query @"
SELECT E.$eName AS name, E.$eId AS exec_id, L.$lUpd AS upd, L.$lPrep AS last_prep
FROM $execTable E
JOIN $lockTable L ON L.$lId = E.$eId
WHERE E.$eName IN (N'ZCLA_PARTLONGDESC', N'ZCLA_PARTLONGDHIST', N'ZCLA_PARTLONGDREV')
"@
$snap = @()
foreach ($r in $snapTable.Rows) {
    $snap += [pscustomobject]@{
        Name     = [string]$r.name
        ExecId   = [int64]$r.exec_id
        Upd      = [string]$r.upd
        LastPrep = [int64]$r.last_prep
    }
    Write-Host ("AT1 before {0} exec={1} upd={2} lastPrep={3}" -f $r.name, $r.exec_id, $r.upd, $r.last_prep)
    [void](Invoke-FormPrepSql -Connection $conn -Query "UPDATE $lockTable SET $lUpd = N'Y' WHERE $lId = @id" -Parameters @{ '@id' = [int64]$r.exec_id } -NonQuery)
}
$conn.Close(); $conn.Dispose()

# P0-W1: web selectors unpinned; storageState may be missing. CLI after park only.
$result = Prepare-Forms -Names $names -Environment DEV -SkipWeb -TimeoutMinutes 15 -CliTimeoutSeconds 60
Write-Host ("AT1 exit={0} reason={1} ok={2} parked={3} restored={4} restoreOk={5}" -f $result.exitCode, $result.reason, $result.ok, $result.parkedCount, $result.restoredCount, $result.restoreOk)

$conn = New-FormPrepSqlConnection -Config $cfg
try {
    $afterTable = Invoke-FormPrepSql -Connection $conn -Query @"
SELECT E.$eName AS name, L.$lUpd AS upd, L.$lPrep AS last_prep
FROM $execTable E
JOIN $lockTable L ON L.$lId = E.$eId
WHERE E.$eName IN (N'ZCLA_PARTLONGDESC', N'ZCLA_PARTLONGDHIST', N'ZCLA_PARTLONGDREV')
"@
    $moved = 0
    foreach ($r in $afterTable.Rows) {
        $before = $snap | Where-Object { $_.Name -eq [string]$r.name } | Select-Object -First 1
        $afterN = [int64]$r.last_prep
        Write-Host ("AT1 after  {0} upd={1} lastPrep={2} (before {3})" -f $r.name, $r.upd, $afterN, $before.LastPrep)
        if (([string]$r.upd).Trim() -eq 'N' -and (Test-LastPrepAdvanced -Before $before.LastPrep -After $afterN)) {
            $moved++
        }
    }
    $yAfter = Get-YCount $conn
    $open = [int](Invoke-FormPrepSql -Connection $conn -Query "SELECT COUNT(*) FROM dbo.AGENT_FORMPREP_PARK WHERE restored_at IS NULL" -Scalar)
    Write-Host "AT1 Y-count before=$yBefore after=$yAfter openParks=$open moved=$moved"
    if ($open -ne 0) { throw "AT1 left $open OPEN park rows" }
    if (-not $result.restoreOk) { throw 'AT1 restoreOk=false' }
    if ($moved -lt 1) {
        throw "P0-T1: no named form moved LASTPREPDATE. CLI did not compile. Do not SQL-flip UPD. Pin web selectors (P0-W1) next."
    }
    Write-Host "AT1 PASS $moved/3 forms compiled (bigint lastprep advanced)"
} finally {
    $conn.Close(); $conn.Dispose()
}
exit 0
