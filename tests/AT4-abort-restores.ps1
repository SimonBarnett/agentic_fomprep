#requires -Version 5.1
# WP1 dry AT4: park 5 dummy rows, kill the holder, RepairOpenParks restores 5/5.
# Does not run CLI or web Form Prep.
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\Helpers.ps1"
if (-not (Test-FormPrepDevHost)) {
    Write-Host 'AT4 SKIP: not on AllowedComputer.'
    exit 0
}
Import-FormPrepModule
$cfg = Get-DevConfig
if (-not $cfg.PinComplete) { throw 'AT4: PinComplete is false' }

$zclaNames = @('ZCLA_PARTLONGDESC', 'ZCLA_PARTLONGDHIST', 'ZCLA_PARTLONGDREV')
$lockTable = ConvertTo-SqlIdent $cfg.LockTable
$execTable = ConvertTo-SqlIdent $cfg.ExecTable
$parkTable = ConvertTo-SqlIdent $cfg.ParkTable
$lId = ConvertTo-SqlIdent $cfg.LockCols.ExecId
$lUpd = ConvertTo-SqlIdent $cfg.LockCols.Upd
$lPrep = ConvertTo-SqlIdent $cfg.LockCols.LastPrep
$lPid = ConvertTo-SqlIdent $cfg.LockCols.Pid
$lExp = ConvertTo-SqlIdent $cfg.LockCols.LockExpiry
$lComp = ConvertTo-SqlIdent $cfg.LockCols.Computer
$eId = ConvertTo-SqlIdent $cfg.ExecIdCol
$eName = ConvertTo-SqlIdent $cfg.ExecNameCol

function Get-YCount($Connection) {
    return [int](Invoke-FormPrepSql -Connection $Connection -Query "SELECT COUNT(*) FROM $lockTable WHERE $lUpd = N'Y'" -Scalar)
}

$conn = New-FormPrepSqlConnection -Config $cfg
$dummy = @()
$dummyForced = $false
$proc = $null
try {
    $yBefore = Get-YCount $conn
    Write-Host "AT4 Y-count before=$yBefore"
    if ($yBefore -ne 3) {
        throw "AT4 expected global UPD=Y count 3 (the ZCLA trio), got $yBefore. Re-read estate before parking."
    }

    $zcla = Invoke-FormPrepSql -Connection $conn -Query @"
SELECT E.$eName AS name, E.$eId AS exec_id, L.$lUpd AS upd, L.$lPrep AS last_prep
FROM $execTable E
JOIN $lockTable L ON L.$lId = E.$eId
WHERE E.$eName IN (N'ZCLA_PARTLONGDESC', N'ZCLA_PARTLONGDHIST', N'ZCLA_PARTLONGDREV')
"@
    if ($zcla.Rows.Count -ne 3) { throw "AT4 expected 3 ZCLA lock rows, got $($zcla.Rows.Count)" }
    $zclaSnap = @()
    foreach ($r in $zcla.Rows) {
        $zclaSnap += [pscustomobject]@{
            Name     = [string]$r.name
            ExecId   = [int64]$r.exec_id
            Upd      = [string]$r.upd
            LastPrep = [int64]$r.last_prep
        }
    }

    $dummyTable = Invoke-FormPrepSql -Connection $conn -Query @"
SELECT TOP 5 E.$eName AS name, E.$eId AS exec_id, L.$lUpd AS upd, L.$lPrep AS last_prep
FROM $execTable E
JOIN $lockTable L ON L.$lId = E.$eId
WHERE L.$lUpd = N'N'
  AND E.$eName NOT LIKE N'ZCLA_PARTLONG%'
  AND L.$lPid = 0
  AND L.$lExp = 0
  AND (L.$lComp = N'' OR L.$lComp IS NULL)
ORDER BY E.$eId
"@
    if ($dummyTable.Rows.Count -lt 5) {
        throw "AT4 could not find 5 dummy UPD=N forms (got $($dummyTable.Rows.Count))"
    }
    foreach ($r in $dummyTable.Rows) {
        $dummy += [pscustomobject]@{
            Name     = [string]$r.name
            ExecId   = [int64]$r.exec_id
            OrigUpd  = [string]$r.upd
            LastPrep = [int64]$r.last_prep
        }
    }
    Write-Host ("AT4 dummies: {0}" -f (($dummy | ForEach-Object { '{0}={1}' -f $_.Name, $_.ExecId }) -join ', '))

    foreach ($d in $dummy) {
        $n = Invoke-FormPrepSql -Connection $conn -Query "UPDATE $lockTable SET $lUpd = N'Y' WHERE $lId = @id AND $lUpd = N'N'" -Parameters @{ '@id' = $d.ExecId } -NonQuery
        if ($n -ne 1) { throw "AT4 failed to force dummy $($d.Name) UPD=Y (rows=$n)" }
    }
    $dummyForced = $true
    $yForced = Get-YCount $conn
    if ($yForced -ne 8) { throw "AT4 expected Y-count 8 after dummy force, got $yForced" }

    $outLog = Join-Path $cfg.AgentWork 'at4-hold.out.log'
    $errLog = Join-Path $cfg.AgentWork 'at4-hold.err.log'
    foreach ($f in @($outLog, $errLog)) {
        if (Test-Path -LiteralPath $f) { Remove-Item -LiteralPath $f -Force }
    }
    $cli = Join-Path $script:RepoRoot 'src\Prepare-Forms.ps1'
    $cmd = "& '$cli' -Names ZCLA_PARTLONGDESC,ZCLA_PARTLONGDHIST,ZCLA_PARTLONGDREV -Environment DEV -SkipCli -SkipWeb -HoldParkSeconds 60"
    $arg = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-Command', $cmd)
    $proc = Start-Process -FilePath 'powershell.exe' -ArgumentList $arg -WorkingDirectory $script:RepoRoot -PassThru -WindowStyle Hidden -RedirectStandardOutput $outLog -RedirectStandardError $errLog

    $openN = 0
    $deadline = (Get-Date).AddSeconds(25)
    do {
        Start-Sleep -Seconds 1
        $openN = [int](Invoke-FormPrepSql -Connection $conn -Query "SELECT COUNT(*) FROM $parkTable WHERE restored_at IS NULL" -Scalar)
        if ($openN -ge 5) { break }
        if ($proc.HasExited) { break }
    } while ((Get-Date) -lt $deadline)

    if ($openN -ne 5) {
        $tail = ''
        if (Test-Path -LiteralPath $outLog) { $tail = Get-Content -LiteralPath $outLog -Raw -ErrorAction SilentlyContinue }
        throw "AT4 park did not reach 5 OPEN rows (open=$openN exited=$($proc.HasExited)). Log: $tail"
    }

    Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
    $null = $proc.WaitForExit(10000)
    $proc = $null

    $refuse = Prepare-Forms -Names 'ZCLA_PARTLONGDESC' -Environment DEV -SkipCli -SkipWeb
    Assert-ExitCode -Result $refuse -Expected 2 -Label 'AT4 open_park refuse'
    if ($refuse.reason -ne 'open_park') {
        throw "AT4 expected reason=open_park got $($refuse.reason)"
    }
    if ([int]$refuse.parkedCount -ne 0) {
        throw "AT4 open_park refuse must not nest park (parkedCount=$($refuse.parkedCount))"
    }
    Write-Host 'AT4 open_park refuse PASS'

    $listed = Prepare-Forms -RepairOpenParks -Environment DEV
    $openErr = @($listed.errors | Where-Object { $_.text -match 'OPEN park' })
    if ($openErr.Count -eq 0) {
        throw 'AT4: no OPEN park rows after kill. Refusing PASS-WEAK.'
    }
    $guidMatch = [regex]::Match($openErr[0].text, '[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')
    if (-not $guidMatch.Success) { throw "AT4 could not parse run_id from $($openErr[0].text)" }
    $runId = [guid]$guidMatch.Value
    $repair = Prepare-Forms -RepairOpenParks -RunId $runId -Environment DEV
    if (-not $repair.restoreOk) {
        throw "AT4 repair restoreOk=false exit=$($repair.exitCode) reason=$($repair.reason) restored=$($repair.restoredCount)"
    }
    if ([int]$repair.restoredCount -ne 5) {
        throw "AT4 expected restoredCount=5 got $($repair.restoredCount)"
    }

    $left = [int](Invoke-FormPrepSql -Connection $conn -Query "SELECT COUNT(*) FROM $parkTable WHERE restored_at IS NULL" -Scalar)
    if ($left -ne 0) { throw "AT4 OPEN rows remain after repair: $left" }

    foreach ($d in $dummy) {
        $cur = Invoke-FormPrepSql -Connection $conn -Query "SELECT $lUpd AS upd FROM $lockTable WHERE $lId = @id" -Parameters @{ '@id' = $d.ExecId } -Scalar
        if ([string]$cur.Trim() -ne 'Y') {
            throw "AT4 dummy $($d.Name) UPD after repair is '$cur' (expected Y prev)"
        }
    }

    $zclaAfter = Invoke-FormPrepSql -Connection $conn -Query @"
SELECT E.$eName AS name, L.$lUpd AS upd, L.$lPrep AS last_prep
FROM $execTable E
JOIN $lockTable L ON L.$lId = E.$eId
WHERE E.$eName IN (N'ZCLA_PARTLONGDESC', N'ZCLA_PARTLONGDHIST', N'ZCLA_PARTLONGDREV')
"@
    foreach ($r in $zclaAfter.Rows) {
        $before = $zclaSnap | Where-Object { $_.Name -eq [string]$r.name } | Select-Object -First 1
        if ([string]$r.upd.Trim() -ne 'Y') { throw "AT4 ZCLA $($r.name) UPD='$($r.upd)' after repair" }
        if ([int64]$r.last_prep -ne $before.LastPrep) {
            throw "AT4 ZCLA $($r.name) LASTPREPDATE changed $($before.LastPrep) -> $($r.last_prep)"
        }
    }

    Write-Host 'AT4 PASS restored 5/5'
} finally {
    if ($proc -and -not $proc.HasExited) {
        try { Stop-Process -Id $proc.Id -Force } catch { }
    }
    try {
        $repairAll = Prepare-Forms -RepairOpenParks -Environment DEV
        $still = @($repairAll.errors | Where-Object { $_.text -match 'OPEN park' })
        foreach ($e in $still) {
            $m = [regex]::Match($e.text, '[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}')
            if ($m.Success) {
                [void](Prepare-Forms -RepairOpenParks -RunId ([guid]$m.Value) -Environment DEV)
            }
        }
    } catch {
        Write-Warning "AT4 finally RepairOpenParks: $($_.Exception.Message)"
    }
    if ($dummyForced) {
        foreach ($d in $dummy) {
            try {
                [void](Invoke-FormPrepSql -Connection $conn -Query "UPDATE $lockTable SET $lUpd = N'N' WHERE $lId = @id" -Parameters @{ '@id' = $d.ExecId } -NonQuery)
            } catch {
                Write-Warning "AT4 finally dummy $($d.Name): $($_.Exception.Message)"
            }
        }
    }
    try {
        $yEnd = Get-YCount $conn
        Write-Host "AT4 Y-count after cleanup=$yEnd"
        if ($yEnd -ne 3) {
            throw "AT4 cleanup left UPD=Y count $yEnd (expected 3)"
        }
    } catch {
        Write-Warning $_.Exception.Message
        throw
    }
    if ($conn) { $conn.Close(); $conn.Dispose() }
}
exit 0
