function Restore-ParkSnapshot {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Connection,
        [Parameter(Mandatory = $true)]$Config,
        [Parameter(Mandatory = $true)][string]$RunId
    )

    $lockTable = ConvertTo-SqlIdent $Config.LockTable
    $parkTable = ConvertTo-SqlIdent $Config.ParkTable
    $lId = ConvertTo-SqlIdent $Config.LockCols.ExecId
    $lUpd = ConvertTo-SqlIdent $Config.LockCols.Upd
    $lPrep = ConvertTo-SqlIdent $Config.LockCols.LastPrep
    $lComp = ConvertTo-SqlIdent $Config.LockCols.Computer
    $lPid = ConvertTo-SqlIdent $Config.LockCols.Pid
    $lExp = ConvertTo-SqlIdent $Config.LockCols.LockExpiry

    $sqlOpen = @"
SELECT exec_id, prev_upd, prev_lastprep, prev_computer, prev_pid, prev_lockexpiry
FROM $parkTable
WHERE run_id = @run AND restored_at IS NULL
"@
    $open = Invoke-FormPrepSql -Connection $Connection -Query $sqlOpen -Parameters @{ '@run' = $RunId }
    $restored = 0
    $failed = 0

    foreach ($r in $open.Rows) {
        $execId = [int64]$r.exec_id
        $prevUpd = [string]$r.prev_upd
        $prevPrep = $(if ($r.prev_lastprep -is [DBNull]) { [int64]0 } else { [int64]$r.prev_lastprep })
        $prevComp = $(if ($r.prev_computer -is [DBNull]) { '' } else { [string]$r.prev_computer })
        $prevPid = $(if ($r.prev_pid -is [DBNull]) { [int64]0 } else { [int64]$r.prev_pid })
        $prevExp = $(if ($r.prev_lockexpiry -is [DBNull]) { [int64]0 } else { [int64]$r.prev_lockexpiry })

        $tx = $Connection.BeginTransaction()
        $script:FormPrepTransaction = $tx
        try {
            $sqlU = @"
UPDATE $lockTable
SET $lUpd = @upd,
    $lPrep = @prep,
    $lComp = @comp,
    $lPid = @pid,
    $lExp = @exp
WHERE $lId = @id
"@
            $n = Invoke-FormPrepSql -Connection $Connection -Query $sqlU -Parameters @{
                '@upd'  = $prevUpd
                '@prep' = $prevPrep
                '@comp' = $prevComp
                '@pid'  = $prevPid
                '@exp'  = $prevExp
                '@id'   = $execId
            } -NonQuery

            $ok = 'N'
            if ($n -eq 1) {
                $ok = 'Y'
                $restored++
            } else {
                $still = [int](Invoke-FormPrepSql -Connection $Connection -Query "SELECT COUNT(*) FROM $lockTable WHERE $lId = @id" -Parameters @{ '@id' = $execId } -Scalar)
                $execTable = ConvertTo-SqlIdent $Config.ExecTable
                $eId = ConvertTo-SqlIdent $Config.ExecIdCol
                $execN = [int](Invoke-FormPrepSql -Connection $Connection -Query "SELECT COUNT(*) FROM $execTable WHERE $eId = @id" -Parameters @{ '@id' = $execId } -Scalar)
                if ($still -eq 0 -and $execN -eq 0) {
                    $ok = 'Y'
                    $restored++
                } else {
                    $failed++
                }
            }

            $sqlMark = @"
UPDATE $parkTable
SET restored_at = GETDATE(), restore_ok = @ok
WHERE run_id = @run AND exec_id = @id AND restored_at IS NULL
"@
            [void](Invoke-FormPrepSql -Connection $Connection -Query $sqlMark -Parameters @{
                    '@ok'  = $ok
                    '@run' = $RunId
                    '@id'  = $execId
                } -NonQuery)

            $tx.Commit()
            $script:FormPrepTransaction = $null
        } catch {
            try { $tx.Rollback() } catch { }
            $script:FormPrepTransaction = $null
            $failed++
        }
    }

    $sqlLeft = "SELECT COUNT(*) FROM $parkTable WHERE run_id = @run AND restored_at IS NULL"
    $left = [int](Invoke-FormPrepSql -Connection $Connection -Query $sqlLeft -Parameters @{ '@run' = $RunId } -Scalar)

    return [pscustomobject]@{
        RestoredCount = $restored
        FailedCount   = $failed
        OpenLeft      = $left
        RestoreOk     = [bool]($left -eq 0 -and $failed -eq 0)
    }
}
