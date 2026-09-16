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

    $sqlOpen = @"
SELECT exec_id, prev_upd, prev_lastprep, prev_computer, prev_pid
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

        $tx = $Connection.BeginTransaction()
        $script:FormPrepTransaction = $tx
        try {
            $sqlU = @"
UPDATE $lockTable
SET $lUpd = @upd,
    $lPrep = @prep,
    $lComp = @comp,
    $lPid = @pid
WHERE $lId = @id
"@
            $n = Invoke-FormPrepSql -Connection $Connection -Query $sqlU -Parameters @{
                '@upd'  = $prevUpd
                '@prep' = $prevPrep
                '@comp' = $prevComp
                '@pid'  = $prevPid
                '@id'   = $execId
            } -NonQuery

            $ok = 'N'
            if ($n -eq 1) { $ok = 'Y'; $restored++ } else { $failed++ }

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
