function Wait-FormPrepIdle {
    <#
    .SYNOPSIS
        P0-BG: do not restore while EXECPREPLOCK still has a live PID/LOCKEXPIRY.
        Then require a short quiet period with no Y-count change.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Connection,
        [Parameter(Mandatory = $true)]$Config,
        [int]$TimeoutSeconds = 120,
        [int]$QuietSeconds = 15,
        $Result
    )

    $lockTable = ConvertTo-SqlIdent $Config.LockTable
    $lUpd = ConvertTo-SqlIdent $Config.LockCols.Upd
    $lPid = ConvertTo-SqlIdent $Config.LockCols.Pid
    $lExp = ConvertTo-SqlIdent $Config.LockCols.LockExpiry
    $lComp = ConvertTo-SqlIdent $Config.LockCols.Computer
    $lId = ConvertTo-SqlIdent $Config.LockCols.ExecId

    $deadline = (Get-Date).AddSeconds([Math]::Max(5, $TimeoutSeconds))
    $live = @()
    do {
        $liveTable = Invoke-FormPrepSql -Connection $Connection -Query @"
SELECT $lId AS exec_id, $lComp AS computer, $lPid AS pid, $lExp AS lock_expiry
FROM $lockTable
WHERE $lPid <> 0
"@
        $live = @()
        foreach ($lr in $liveTable.Rows) {
            $probe = [pscustomobject]@{
                Pid        = $(if ($lr.pid -is [DBNull]) { 0 } else { $lr.pid })
                LockExpiry = $(if ($lr.lock_expiry -is [DBNull]) { $null } else { $lr.lock_expiry })
                Computer   = $(if ($lr.computer -is [DBNull]) { $null } else { [string]$lr.computer })
            }
            $pidVal = ConvertTo-Int64Id $probe.Pid
            $onThisBox = -not [string]::IsNullOrWhiteSpace($probe.Computer) -and ($probe.Computer -like ('*{0}*' -f $env:COMPUTERNAME))
            $pidAlive = $false
            if ($pidVal -ne 0 -and $onThisBox) {
                $pidAlive = [bool](Get-Process -Id $pidVal -ErrorAction SilentlyContinue)
            }
            if ((Test-LockIsLive -Row $probe) -or $pidAlive) {
                $live += ('exec={0} pid={1} exp={2} computer={3} alive={4}' -f $lr.exec_id, $probe.Pid, $probe.LockExpiry, $probe.Computer, $pidAlive)
            }
        }
        $procs = @(Get-Process -ErrorAction SilentlyContinue | Where-Object {
                $_.ProcessName -match '^(winrun|winactiv|formprep)$'
            })
        if ($live.Count -eq 0 -and $procs.Count -eq 0) { break }
        if ($Result) {
            $procTxt = ($procs | ForEach-Object { '{0}:{1}' -f $_.ProcessName, $_.Id }) -join ','
            Add-FormPrepError -Result $Result -Source 'execpreplock' -Text ('P0-BG live lock: ' + ($live -join '; ') + ' procs=' + $procTxt) -Severity 'Info'
        }
        Start-Sleep -Seconds ([int]$Config.SqlPollSeconds)
    } while ((Get-Date) -lt $deadline)

    $procLeft = @(Get-Process -ErrorAction SilentlyContinue | Where-Object {
            $_.ProcessName -match '^(winrun|winactiv|formprep)$'
        })
    if ($live.Count -gt 0 -or $procLeft.Count -gt 0) {
        if ($Result) {
            Add-FormPrepError -Result $Result -Source 'execpreplock' -Text 'P0-BG timeout still seeing live PID or Form Prep process; not restoring' -Severity 'Warning'
        }
        return [pscustomobject]@{ Idle = $false }
    }

    $ySql = "SELECT COUNT(*) FROM $lockTable WHERE $lUpd = N'Y'"
    $y0 = [int](Invoke-FormPrepSql -Connection $Connection -Query $ySql -Scalar)
    $quietUntil = (Get-Date).AddSeconds([Math]::Max(5, $QuietSeconds))
    while ((Get-Date) -lt $quietUntil) {
        Start-Sleep -Seconds 5
        $y1 = [int](Invoke-FormPrepSql -Connection $Connection -Query $ySql -Scalar)
        if ($y1 -ne $y0) {
            $y0 = $y1
            $quietUntil = (Get-Date).AddSeconds([Math]::Max(5, $QuietSeconds))
            if ($Result) {
                Add-FormPrepError -Result $Result -Source 'execpreplock' -Text ("P0-BG Y-count changed to {0}; restarting quiet wait" -f $y1) -Severity 'Info'
            }
        }
    }
    if ($Result) {
        Add-FormPrepError -Result $Result -Source 'execpreplock' -Text ("P0-BG idle Y={0}" -f $y0) -Severity 'Info'
    }
    return [pscustomobject]@{ Idle = $true }
}
