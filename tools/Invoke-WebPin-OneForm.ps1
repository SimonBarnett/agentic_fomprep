#requires -Version 5.1
# P0-W1: park + web only (no CLI) for ZCLA_PARTLONGDESC. Headed Playwright.
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
Import-Module (Join-Path $repo 'src\CE.FormPrep.psd1') -Force
$cfg = Get-FormPrepConfig
$name = 'ZCLA_PARTLONGDESC'
$conn = New-FormPrepSqlConnection -Config $cfg
$before = Invoke-FormPrepSql -Connection $conn -Query @"
SELECT E.ENAME, E.[T`$EXEC] AS exec_id, L.UPD, L.LASTPREPDATE
FROM dbo.[T`$EXEC] E
JOIN dbo.EXECPREPLOCK L ON L.[T`$EXEC] = E.[T`$EXEC]
WHERE E.ENAME = @n
"@ -Parameters @{ '@n' = $name }
Write-Host ("before {0} exec={1} upd={2} lastPrep={3}" -f $before.Rows[0].ENAME, $before.Rows[0].exec_id, $before.Rows[0].UPD, $before.Rows[0].LASTPREPDATE)
$conn.Close(); $conn.Dispose()

$r = Prepare-Forms -Names $name -Environment DEV -SkipCli -TimeoutMinutes 8
Write-Host ("exit={0} reason={1} ok={2} parked={3} restored={4} restoreOk={5} executor={6} auth={7}" -f $r.exitCode, $r.reason, $r.ok, $r.parkedCount, $r.restoredCount, $r.restoreOk, $r.executor, $r.auth)
Write-Host ("runId={0}" -f $r.runId)
$r.errors | ForEach-Object { Write-Host ("err {0} {1} {2}" -f $_.severity, $_.source, $_.text) }

$conn = New-FormPrepSqlConnection -Config $cfg
$after = Invoke-FormPrepSql -Connection $conn -Query @"
SELECT E.ENAME, L.UPD, L.LASTPREPDATE
FROM dbo.[T`$EXEC] E
JOIN dbo.EXECPREPLOCK L ON L.[T`$EXEC] = E.[T`$EXEC]
WHERE E.ENAME = @n
"@ -Parameters @{ '@n' = $name }
$open = Invoke-FormPrepSql -Connection $conn -Query "SELECT COUNT(*) FROM dbo.AGENT_FORMPREP_PARK WHERE restored_at IS NULL" -Scalar
Write-Host ("after {0} upd={1} lastPrep={2} open={3}" -f $after.Rows[0].ENAME, $after.Rows[0].UPD, $after.Rows[0].LASTPREPDATE, $open)
$conn.Close(); $conn.Dispose()
if (-not $r.restoreOk) { throw 'restoreOk=false' }
