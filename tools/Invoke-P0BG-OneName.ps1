#requires -Version 5.1
# P0-BG: one-name web run. After restore+30s, unnamed ZCLA siblings must match pre-run snapshot.
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
Import-Module (Join-Path $repo 'src\CE.FormPrep.psd1') -Force
$cfg = Get-FormPrepConfig
$target = 'ZCLA_PARTLONGDESC'
$siblings = @('ZCLA_PARTLONGDHIST', 'ZCLA_PARTLONGDREV')

function Get-LockMap($conn, $names) {
    $lockTable = ConvertTo-SqlIdent $cfg.LockTable
    $execTable = ConvertTo-SqlIdent $cfg.ExecTable
    $lId = ConvertTo-SqlIdent $cfg.LockCols.ExecId
    $lUpd = ConvertTo-SqlIdent $cfg.LockCols.Upd
    $lPrep = ConvertTo-SqlIdent $cfg.LockCols.LastPrep
    $eId = ConvertTo-SqlIdent $cfg.ExecIdCol
    $eName = ConvertTo-SqlIdent $cfg.ExecNameCol
    $in = (($names | ForEach-Object { "N'$_'" }) -join ',')
    $t = Invoke-FormPrepSql -Connection $conn -Query @"
SELECT E.$eName AS name, E.$eId AS exec_id, L.$lUpd AS upd, L.$lPrep AS last_prep
FROM $execTable E
JOIN $lockTable L ON L.$lId = E.$eId
WHERE E.$eName IN ($in)
"@
    $map = @{}
    foreach ($r in $t.Rows) {
        $map[[string]$r.name] = [pscustomobject]@{
            Upd      = ([string]$r.upd).Trim()
            LastPrep = [int64]$r.last_prep
            ExecId   = [int64]$r.exec_id
        }
    }
    return , $map
}

$conn = New-FormPrepSqlConnection -Config $cfg
$before = Get-LockMap $conn (@($target) + $siblings)
foreach ($n in $before.Keys) {
    Write-Host ("before {0} upd={1} lastPrep={2}" -f $n, $before[$n].Upd, $before[$n].LastPrep)
}
$lockTable = ConvertTo-SqlIdent $cfg.LockTable
$lId = ConvertTo-SqlIdent $cfg.LockCols.ExecId
$lUpd = ConvertTo-SqlIdent $cfg.LockCols.Upd
[void](Invoke-FormPrepSql -Connection $conn -Query "UPDATE $lockTable SET $lUpd = N'Y' WHERE $lId = @id" -Parameters @{ '@id' = $before[$target].ExecId } -NonQuery)
Write-Host ("forced {0} UPD=Y (lastprep untouched)" -f $target)
$conn.Close(); $conn.Dispose()

$r = Prepare-Forms -Names $target -Environment DEV -SkipCli -AllowSameDayPrep -TimeoutMinutes 8
Write-Host ("exit={0} reason={1} ok={2} parked={3} restored={4} restoreOk={5} executor={6} auth={7}" -f $r.exitCode, $r.reason, $r.ok, $r.parkedCount, $r.restoredCount, $r.restoreOk, $r.executor, $r.auth)
$r.errors | ForEach-Object { Write-Host ("err {0} {1}" -f $_.severity, $_.text) }
Start-Sleep -Seconds 30

$conn = New-FormPrepSqlConnection -Config $cfg
$after = Get-LockMap $conn (@($target) + $siblings)
foreach ($n in $siblings) {
    Write-Host ("after  {0} upd={1} lastPrep={2}" -f $n, $after[$n].Upd, $after[$n].LastPrep)
    if ($after[$n].Upd -ne $before[$n].Upd -or $after[$n].LastPrep -ne $before[$n].LastPrep) {
        throw ("P0-BG sibling {0} moved upd {1}->{2} lastPrep {3}->{4}" -f $n, $before[$n].Upd, $after[$n].Upd, $before[$n].LastPrep, $after[$n].LastPrep)
    }
}
Write-Host ("after  {0} upd={1} lastPrep={2}" -f $target, $after[$target].Upd, $after[$target].LastPrep)
$open = Invoke-FormPrepSql -Connection $conn -Query "SELECT COUNT(*) FROM dbo.AGENT_FORMPREP_PARK WHERE restored_at IS NULL" -Scalar
Write-Host ("open={0}" -f $open)
$conn.Close(); $conn.Dispose()
if ($r.auth -eq 'expired' -or $r.reason -eq 'auth_expired') {
    throw 'P0-BG did not run web (auth_expired). Siblings-unchanged is not evidence.'
}
if ($r.executor -ne 'web' -and $r.executor -ne 'cli+web') {
    throw ("P0-BG executor={0} (need web)" -f $r.executor)
}
if ([int]$open -ne 0) { throw 'OPEN parks remain' }
if (-not $r.restoreOk) { throw 'restoreOk=false' }
Write-Host 'P0-BG PASS siblings unchanged'
