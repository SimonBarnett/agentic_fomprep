function ConvertTo-Int64Id {
    param($Value)
    if ($null -eq $Value -or $Value -is [DBNull]) { return [int64]0 }
    return [int64]$Value
}

function Test-LockIsLive {
    param($Row)

    # LOCKEXPIRY is bigint (WP0). 0 / null / PID=0 is stale. No Priority epoch decoder.
    $pid = ConvertTo-Int64Id $Row.Pid
    $expVal = ConvertTo-Int64Id $Row.LockExpiry
    $expiryLive = ($pid -ne 0 -and $expVal -gt 0)

    $hostLive = $false
    $computer = [string]$Row.Computer
    if (-not [string]::IsNullOrWhiteSpace($computer)) {
        try {
            $hostLive = Test-Connection -ComputerName $computer -Count 1 -Quiet -ErrorAction SilentlyContinue
        } catch {
            $hostLive = $false
        }
    }

    return [bool]($expiryLive -or $hostLive)
}

function Get-OpenParkRows {
    param($Connection, $Config, [string]$ExceptRunId)

    $park = ConvertTo-SqlIdent $Config.ParkTable
    $sql = "SELECT run_id, exec_id, ename, parked_at FROM $park WHERE restored_at IS NULL"
    $table = Invoke-FormPrepSql -Connection $Connection -Query $sql
    $rows = @()
    foreach ($r in $table.Rows) {
        $rid = [string]$r.run_id
        if ($ExceptRunId -and $rid -eq $ExceptRunId) { continue }
        $rows += [pscustomobject]@{
            RunId    = $rid
            ExecId   = [int64]$r.exec_id
            Name     = $(if ($r.ename -is [DBNull]) { $null } else { [string]$r.ename })
            ParkedAt = $r.parked_at
        }
    }
    return , @($rows)
}

function New-ParkSnapshot {
    <#
    .SYNOPSIS
        Isolate named targets by parking every other UPD='Y' row. Always pair with Restore-ParkSnapshot.
        Writes happen in one transaction; assert Y-count == target count before commit (safer than commit-then-restore).
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Connection,
        [Parameter(Mandatory = $true)]$Config,
        [Parameter(Mandatory = $true)]$Targets,
        [Parameter(Mandatory = $true)][string]$RunId,
        [string]$DumpPath,
        [switch]$ResetLastPrepDate
    )

    $lockTable = ConvertTo-SqlIdent $Config.LockTable
    $execTable = ConvertTo-SqlIdent $Config.ExecTable
    $parkTable = ConvertTo-SqlIdent $Config.ParkTable
    $lId = ConvertTo-SqlIdent $Config.LockCols.ExecId
    $lUpd = ConvertTo-SqlIdent $Config.LockCols.Upd
    $lPrep = ConvertTo-SqlIdent $Config.LockCols.LastPrep
    $lComp = ConvertTo-SqlIdent $Config.LockCols.Computer
    $lPid = ConvertTo-SqlIdent $Config.LockCols.Pid
    $lExp = ConvertTo-SqlIdent $Config.LockCols.LockExpiry
    $eId = ConvertTo-SqlIdent $Config.ExecIdCol
    $eName = ConvertTo-SqlIdent $Config.ExecNameCol

    $ids = @($Targets | ForEach-Object { [int64]$_.ExecId })
    if ($ids.Count -eq 0) { throw 'No target exec ids' }

    $tx = $Connection.BeginTransaction()
    $script:FormPrepTransaction = $tx
    $parkedCount = 0
    try {
        # 1. Set targets UPD='Y', clear stale locks. LASTPREPDATE is bigint; reset to 0 not NULL.
        # EXECPREPLOCK columns are all NOT NULL - do not INSERT a skeleton row.
        foreach ($id in $ids) {
            $resetPrep = ''
            if ($ResetLastPrepDate) {
                $resetPrep = ", $lPrep = 0"
            }
            $sqlT = @"
UPDATE $lockTable
SET $lUpd = 'Y',
    $lComp = '',
    $lPid = 0,
    $lExp = 0
    $resetPrep
WHERE $lId = @id
"@
            $n = Invoke-FormPrepSql -Connection $Connection -Query $sqlT -Parameters @{ '@id' = $id } -NonQuery
            if ($n -lt 1) {
                throw "Target exec_id $id has no $lockTable row. Refusing INSERT (EXECPREPLOCK columns are NOT NULL)."
            }
        }

        # 2. Snapshot + park everyone else currently Y
        $idParams = @{}
        $idList = @()
        for ($i = 0; $i -lt $ids.Count; $i++) {
            $pn = "@id$i"
            $idList += $pn
            $idParams[$pn] = $ids[$i]
        }
        $notIn = $idList -join ', '

        $sqlPark = @"
INSERT INTO $parkTable (run_id, exec_id, ename, prev_upd, prev_lastprep, prev_computer, prev_pid, parked_at)
SELECT @run, L.$lId, E.$eName, L.$lUpd, L.$lPrep, L.$lComp, L.$lPid, GETDATE()
FROM $lockTable L
LEFT JOIN $execTable E ON E.$eId = L.$lId
WHERE L.$lUpd = 'Y'
  AND L.$lId NOT IN ($notIn)
"@
        $parkParams = @{ '@run' = $RunId }
        foreach ($k in $idParams.Keys) { $parkParams[$k] = $idParams[$k] }
        $parkedCount = Invoke-FormPrepSql -Connection $Connection -Query $sqlPark -Parameters $parkParams -NonQuery

        $sqlFlip = @"
UPDATE $lockTable
SET $lUpd = 'N'
WHERE $lUpd = 'Y'
  AND $lId NOT IN ($notIn)
"@
        [void](Invoke-FormPrepSql -Connection $Connection -Query $sqlFlip -Parameters $idParams -NonQuery)

        $sqlCount = "SELECT COUNT(*) FROM $lockTable WHERE $lUpd = 'Y'"
        $yCount = [int](Invoke-FormPrepSql -Connection $Connection -Query $sqlCount -Scalar)
        if ($yCount -ne $ids.Count) {
            throw "park_assert: UPD='Y' count is $yCount, expected $($ids.Count)"
        }

        $tx.Commit()
        $script:FormPrepTransaction = $null
    } catch {
        try { $tx.Rollback() } catch { }
        $script:FormPrepTransaction = $null
        throw
    }

    if ($DumpPath) {
        $dump = New-Object System.Collections.Generic.List[string]
        [void]$dump.Add("run_id=$RunId parkedCount=$parkedCount")
        $sqlDump = "SELECT exec_id, ename, prev_upd FROM $parkTable WHERE run_id = @run AND restored_at IS NULL"
        $dt = Invoke-FormPrepSql -Connection $Connection -Query $sqlDump -Parameters @{ '@run' = $RunId }
        foreach ($r in $dt.Rows) {
            [void]$dump.Add(("{0}`t{1}`t{2}" -f $r.exec_id, $r.ename, $r.prev_upd))
        }
        $dir = Split-Path -Parent $DumpPath
        if ($dir -and -not (Test-Path -LiteralPath $dir)) {
            [void][System.IO.Directory]::CreateDirectory($dir)
        }
        [System.IO.File]::WriteAllLines($DumpPath, $dump)
    }

    return $parkedCount
}
