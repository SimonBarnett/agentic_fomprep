function Wait-TargetsPrepared {
    param($Connection, $Config, $Targets, [int]$TimeoutSeconds, [int]$PollSeconds)

    $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
    $names = @($Targets | ForEach-Object { $_.Name })
    do {
        $resolved = Get-FormExec -Connection $Connection -Config $Config -Names $names
        $all = $true
        foreach ($t in $Targets) {
            $row = $resolved.Rows | Where-Object { $_.Name -eq $t.Name } | Select-Object -First 1
            if (-not $row -or $row.Upd -ne 'N' -or -not (Test-LastPrepAdvanced -Before $t.LastPrep -After $row.LastPrep)) {
                $all = $false
                break
            }
        }
        if ($all) { return $resolved }
        Start-Sleep -Seconds $PollSeconds
    } while ((Get-Date) -lt $deadline)
    return $resolved
}

function Get-VerifyRows {
    param($Connection, $Config, $Targets)

    $names = @($Targets | ForEach-Object { $_.Name })
    return Get-FormExec -Connection $Connection -Config $Config -Names $names
}

function Convert-VerifyToResult {
    param($Result, $Targets, $Resolved, [switch]$AllowSameDayPrep)

    $prepared = @()
    $still = @()
    foreach ($t in $Targets) {
        $row = $Resolved.Rows | Where-Object { $_.Name -eq $t.Name } | Select-Object -First 1
        $after = $null
        $upd = 'Y'
        $computer = $null
        $pid = $null
        if ($row) {
            $after = ConvertTo-LastPrepJsonValue $row.LastPrep
            $upd = $row.Upd
            $computer = $row.Computer
            $pid = $row.Pid
        }
        $advanced = Test-LastPrepAdvanced -Before $t.LastPrep -After $(if ($row) { $row.LastPrep } else { $null })
        if (-not $advanced -and $AllowSameDayPrep -and $upd -eq 'N') {
            $afterN = ConvertTo-Int64Id $(if ($row) { $row.LastPrep } else { $null })
            $beforeN = ConvertTo-Int64Id $t.LastPrep
            if ($afterN -gt 0 -and $afterN -eq $beforeN) {
                $advanced = $true
                Add-FormPrepError -Result $Result -Source 'execpreplock' -Text ("AllowSameDayPrep: LASTPREPDATE unchanged at {0}" -f $afterN) -Severity 'Warning' -FormHint $t.Name
            }
        }
        $itemBase = [ordered]@{
            name               = $t.Name
            execId             = [int64]$t.ExecId
            lastPrepDateBefore = (ConvertTo-LastPrepJsonValue $t.LastPrep)
            lastPrepDateAfter  = $after
        }
        if ($upd -eq 'N' -and $advanced) {
            $itemBase.upd = 'N'
            if ($computer) { $itemBase.computer = [string]$computer }
            if ($null -ne $pid) { $itemBase.pid = [int64]$pid }
            $prepared += @([pscustomobject]$itemBase)
        } else {
            $itemBase.upd = $(if ($upd) { $upd } else { 'Y' })
            if ($itemBase.upd -ne 'Y') { $itemBase.upd = 'Y' }
            $still += @([pscustomobject]$itemBase)
            Add-FormPrepError -Result $Result -Source 'execpreplock' -Text "still UPD='$upd' lastPrep advanced=$advanced" -Severity 'Blocker' -FormHint $t.Name
        }
    }
    $Result.prepared = $prepared
    $Result.stillUnprepared = $still
}

function Prepare-Forms {
    <#
    .SYNOPSIS
        Unattended Priority Form Prep on CE DEV only.

    .DESCRIPTION
        Hybrid F: park every other UPD='Y' row, CLI probe (killed on timeout), web Form Prep,
        verify EXECPREPLOCK, restore park. Never reports Ok unless UPD='N' AND LASTPREPDATE moved.

    .PARAMETER Names
        EXEC form names (ENAME). 1-10 typical.

    .PARAMETER Environment
        Must be DEV. Any other value is refused.

    .PARAMETER WhatIf
        Resolve + print park count. No UPDATE, no web, no CLI. Exit 0 with whatIf=true, ok=false.
    #>
    [CmdletBinding(DefaultParameterSetName = 'Prepare')]
    param(
        [Parameter(ParameterSetName = 'Prepare', Position = 0)]
        [string[]]$Names,

        [ValidateSet('DEV')]
        [string]$Environment = 'DEV',

        [int]$TimeoutMinutes = 15,
        [int]$CliTimeoutSeconds = 60,
        [switch]$RestoreQueue,
        [string[]]$PostHooks,
        [string]$ResultJson,
        [switch]$WhatIf,
        [switch]$SkipCli,
        [switch]$SkipWeb,
        [switch]$Force,
        [ValidateSet('Named', 'AllUnprepared')]
        [string]$Scope = 'Named',
        [string]$ChangeTicket,

        [Parameter(ParameterSetName = 'Repair')]
        [switch]$RepairOpenParks,

        [guid]$RunId,
        [switch]$ResetLastPrepDate,
        [string]$ConfigPath,
        [switch]$SkipPark,
        [int]$HoldParkSeconds = 0,
        [switch]$AllowSameDayPrep
    )

    $started = (Get-Date).ToUniversalTime()
    if (-not $RunId) { $RunId = [guid]::NewGuid() }
    $result = New-ResultObject -RunId $RunId -StartedAt $started
    $result.whatIf = [bool]$WhatIf
    $lock = $null
    $conn = $null
    $parked = $false
    $dirs = $null
    $cfg = $null
    $targets = @()

    try {
        if ($Scope -eq 'AllUnprepared') {
            Add-FormPrepError -Result $result -Source 'execpreplock' -Text 'Scope AllUnprepared is not implemented in MVP (needs -ChangeTicket AND a post-WP5 change).' -Severity 'Blocker'
            $result.reason = 'all_unprepared_forbidden'
            $result.exitCode = 2
            return $result
        }

        $cfg = Get-FormPrepConfig -Path $ConfigPath -Environment $Environment
        $requirePin = -not $WhatIf
        if ($RepairOpenParks) { $requirePin = $true }

        $envOk = Assert-FormPrepEnvironment -Config $cfg -Result $result -RequirePin:$requirePin -RequirePriorityRoot:(-not $WhatIf) -RequireComputer
        if (-not $envOk) { return $result }

        $dirs = New-RunDirectory -Config $cfg -RunId $result.runId

        if ($RepairOpenParks) {
            $lock = Lock-FormPrepMutex -Name $cfg.MutexName -WaitMs $cfg.MutexWaitMs
            if (-not $lock.Held) {
                $result.reason = 'mutex_held'
                $result.exitCode = 2
                Add-FormPrepError -Result $result -Source 'execpreplock' -Text 'mutex_held' -Severity 'Blocker'
                return $result
            }
            $conn = New-FormPrepSqlConnection -Config $cfg
            $open = Get-OpenParkRows -Connection $conn -Config $cfg
            if (-not $PSBoundParameters.ContainsKey('RunId')) {
                $result.reason = 'repair_list'
                $result.exitCode = 0
                foreach ($o in $open) {
                    Add-FormPrepError -Result $result -Source 'execpreplock' -Text ("OPEN park run={0} exec={1} {2} at {3}" -f $o.RunId, $o.ExecId, $o.Name, $o.ParkedAt) -Severity 'Warning'
                }
                if ($open.Count -eq 0) { $result.ok = $true }
                return $result
            }
            $restore = Restore-ParkSnapshot -Connection $conn -Config $cfg -RunId $result.runId
            $result.restoredCount = [int]$restore.RestoredCount
            $result.parkedCount = [int]($restore.RestoredCount + $restore.OpenLeft + $restore.FailedCount)
            $result.restoreOk = [bool]$restore.RestoreOk
            if ($restore.RestoreOk) {
                $result.ok = $true
                $result.exitCode = 0
                $result.reason = 'repaired'
            } else {
                $result.exitCode = 3
                $result.reason = 'restore_short'
                Add-FormPrepError -Result $result -Source 'execpreplock' -Text ("restore short: {0}/{1}" -f $restore.RestoredCount, $result.parkedCount) -Severity 'Blocker'
            }
            return $result
        }

        if (-not $Names -or $Names.Count -eq 0) {
            Add-FormPrepError -Result $result -Source 'execpreplock' -Text 'Names is empty' -Severity 'Blocker'
            $result.reason = 'no_names'
            $result.exitCode = 2
            return $result
        }
        if ($Names.Count -gt 10) {
            Add-FormPrepError -Result $result -Source 'execpreplock' -Text 'Refusing more than 10 names in MVP' -Severity 'Blocker'
            $result.reason = 'too_many_names'
            $result.exitCode = 2
            return $result
        }
        if ($SkipPark -and -not $WhatIf -and (-not $SkipCli -or -not $SkipWeb)) {
            Add-FormPrepError -Result $result -Source 'execpreplock' -Text 'SkipPark requires -SkipCli and -SkipWeb (dump-only).' -Severity 'Blocker'
            $result.reason = 'dump_requires_skip'
            $result.exitCode = 2
            return $result
        }

        $needWeb = -not $WhatIf -and -not $SkipWeb -and -not $SkipPark
        $session = Test-WebSession -Config $cfg
        $result.auth = $session.Auth
        if ($needWeb -and $session.Auth -eq 'expired') {
            Add-FormPrepError -Result $result -Source 'execpreplock' -Text ("auth_expired: {0}" -f $session.Reason) -Severity 'Blocker'
            $result.reason = 'auth_expired'
            $result.exitCode = 2
            return $result
        }
        if ($needWeb) {
            if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
                Add-FormPrepError -Result $result -Source 'execpreplock' -Text 'node_missing: cannot probe session or run web Form Prep' -Severity 'Blocker'
                $result.reason = 'node_missing'
                $result.exitCode = 2
                return $result
            }
            $probe = Invoke-WebSessionProbe -Config $cfg
            $result.auth = $probe.Auth
            if ($probe.Auth -ne 'ok') {
                $why = if ($probe.Reason -eq 'node_missing') { 'node_missing' } else { 'auth_expired' }
                Add-FormPrepError -Result $result -Source 'execpreplock' -Text ("${why}: {0}" -f $probe.Reason) -Severity 'Blocker'
                $result.reason = $why
                $result.exitCode = 2
                return $result
            }
        } elseif ($session.Auth -eq 'expired' -and -not $WhatIf -and -not $SkipWeb) {
            Add-FormPrepError -Result $result -Source 'execpreplock' -Text ("auth_expired: {0}" -f $session.Reason) -Severity 'Blocker'
            $result.reason = 'auth_expired'
            $result.exitCode = 2
            return $result
        }

        $conn = New-FormPrepSqlConnection -Config $cfg
        $resolved = Get-FormExec -Connection $conn -Config $cfg -Names $Names
        if ($resolved.Missing.Count -gt 0) {
            Add-FormPrepError -Result $result -Source 'execpreplock' -Text ("names not found: {0}" -f ($resolved.Missing -join ', ')) -Severity 'Blocker'
            $result.reason = 'name_missing'
            $result.exitCode = 2
            return $result
        }
        $targets = @($resolved.Rows)

        if ($dirs -and -not $WhatIf) {
            Write-FormPrepSqlSnapshot -Rows $targets -JsonPath (Join-Path $dirs.RunDir 'sql-before.json') -CsvPath (Join-Path $dirs.RunDir 'targets.csv')
        }

        if ($WhatIf) {
            $lockTable = ConvertTo-SqlIdent $cfg.LockTable
            $lUpd = ConvertTo-SqlIdent $cfg.LockCols.Upd
            $would = [int](Invoke-FormPrepSql -Connection $conn -Query "SELECT COUNT(*) FROM $lockTable WHERE $lUpd = 'Y'" -Scalar)
            $targetCount = $targets.Count
            $wouldPark = [Math]::Max(0, $would - $targetCount)
            $result.parkedCount = 0
            $result.reason = 'whatIf'
            Write-Host ("whatIf wouldPark={0} currentY={1} targets={2}" -f $wouldPark, $would, $targetCount)
            foreach ($t in $targets) {
                Write-Host ("  {0} exec={1} upd={2} lastPrep={3}" -f $t.Name, $t.ExecId, $t.Upd, $t.LastPrep)
            }
            $result.whatIf = $true
            $result.exitCode = 0
            $result.ok = $false
            return $result
        }

        if (-not $SkipPark) {
            $lock = Lock-FormPrepMutex -Name $cfg.MutexName -WaitMs $cfg.MutexWaitMs
            if (-not $lock.Held) {
                $result.reason = 'mutex_held'
                $result.exitCode = 2
                Add-FormPrepError -Result $result -Source 'execpreplock' -Text 'mutex_held' -Severity 'Blocker'
                return $result
            }
            if ($lock.Abandoned) {
                Add-FormPrepError -Result $result -Source 'execpreplock' -Text 'acquired abandoned mutex; continuing' -Severity 'Warning'
            }

            $otherOpen = Get-OpenParkRows -Connection $conn -Config $cfg -ExceptRunId $result.runId
            if ($otherOpen.Count -gt 0) {
                $rid = $otherOpen[0].RunId
                Add-FormPrepError -Result $result -Source 'execpreplock' -Text "OPEN park rows exist for run_id $rid" -Severity 'Blocker' -FormHint $null
                $result.reason = 'open_park'
                $result.exitCode = 2
                return $result
            }

            $lUpdCol = ConvertTo-SqlIdent $cfg.LockCols.Upd
            $lockTable = ConvertTo-SqlIdent $cfg.LockTable
            $lIdCol = ConvertTo-SqlIdent $cfg.LockCols.ExecId
            $lPidCol = ConvertTo-SqlIdent $cfg.LockCols.Pid
            $lExpCol = ConvertTo-SqlIdent $cfg.LockCols.LockExpiry
            $lCompCol = ConvertTo-SqlIdent $cfg.LockCols.Computer
            $liveSql = @"
SELECT $lIdCol AS exec_id, $lCompCol AS computer, $lPidCol AS pid, $lExpCol AS lock_expiry
FROM $lockTable
WHERE $lUpdCol = 'Y' OR $lIdCol IN ($(($targets | ForEach-Object { $_.ExecId }) -join ','))
"@
            $liveTable = Invoke-FormPrepSql -Connection $conn -Query $liveSql
            foreach ($lr in $liveTable.Rows) {
                $probe = [pscustomobject]@{
                    Pid        = $(if ($lr.pid -is [DBNull]) { 0 } else { $lr.pid })
                    LockExpiry = $(if ($lr.lock_expiry -is [DBNull]) { $null } else { $lr.lock_expiry })
                    Computer   = $(if ($lr.computer -is [DBNull]) { $null } else { [string]$lr.computer })
                }
                if (Test-LockIsLive -Row $probe) {
                    Add-FormPrepError -Result $result -Source 'execpreplock' -Text ("lock_held exec={0} computer={1} pid={2}" -f $lr.exec_id, $probe.Computer, $probe.Pid) -Severity 'Blocker'
                    $result.reason = 'lock_held'
                    $result.exitCode = 2
                    return $result
                }
            }
        }

        if (-not $SkipPark) {
            $dump = Join-Path $dirs.RunDir 'parked_execs.txt'
            $parkedCount = New-ParkSnapshot -Connection $conn -Config $cfg -Targets $targets -RunId $result.runId -DumpPath $dump -ResetLastPrepDate:$ResetLastPrepDate
            $result.parkedCount = [int]$parkedCount
            $parked = $true
        }

        if ($HoldParkSeconds -gt 0) {
            if (-not $parked) {
                throw 'HoldParkSeconds requires a park (do not combine with -SkipPark / -WhatIf).'
            }
            Write-Host ("HoldParkSeconds={0} runId={1} parkedCount={2}" -f $HoldParkSeconds, $result.runId, $result.parkedCount)
            Start-Sleep -Seconds $HoldParkSeconds
        }

        $cliStatus = 'skipped'
        $webStatus = 'skipped'
        $allCli = $false
        if (-not $SkipCli) {
            $cli = Invoke-CliFormPrep -Config $cfg -RunDir $dirs.RunDir -TimeoutSeconds $CliTimeoutSeconds
            $cliStatus = $cli.Status
            $cliReason = [string]$cli.Reason
            Add-FormPrepError -Result $result -Source 'execpreplock' -Text ("cli {0} {1}" -f $cliStatus, $cliReason) -Severity 'Info'
            # Success is SQL, not process exit. Do not stack a second CliTimeoutSeconds wait after skip/timeout.
            if ($cliStatus -eq 'exited' -or $cliStatus -eq 'timeout') {
                $poll = Get-FormExec -Connection $conn -Config $cfg -Names @($targets | ForEach-Object { $_.Name })
                $allCli = $true
                foreach ($t in $targets) {
                    $row = $poll.Rows | Where-Object { $_.Name -eq $t.Name } | Select-Object -First 1
                    $upd = if ($row -and $row.Upd) { [string]$row.Upd.Trim() } else { '' }
                    if (-not $row -or $upd -ne 'N' -or -not (Test-LastPrepAdvanced -Before $t.LastPrep -After $row.LastPrep)) {
                        $allCli = $false
                    }
                }
                if ($allCli) {
                    $result.executor = 'cli'
                    $SkipWeb = $true
                }
            }
        }

        if (-not $SkipWeb) {
            $web = Invoke-WebFormPrep -Config $cfg -RunDir $dirs.RunDir -TimeoutMinutes $TimeoutMinutes
            $webStatus = $web.Status
            $result.auth = $web.Auth
            foreach ($d in @($web.Dialogs)) {
                $action = 'captured-left'
                if ($d.action) { $action = [string]$d.action }
                $text = [string]$d.text
                Add-FormPrepDialog -Result $result -Text $text -Action $action
                if ($action -eq 'blocked-run') {
                    Add-FormPrepError -Result $result -Source 'modal' -Text $text -Severity 'Blocker'
                }
            }
            if ($result.executor -eq 'cli') { $result.executor = 'cli+web' } else { $result.executor = 'web' }

            if ($webStatus -eq 'auth_expired') {
                Add-FormPrepError -Result $result -Source 'execpreplock' -Text 'auth_expired_after_park' -Severity 'Blocker'
                $result.reason = 'auth_expired_after_park'
                $result.exitCode = 3
            } elseif ($webStatus -eq 'blocked-run') {
                $result.reason = 'blocked-run'
                $result.exitCode = 3
            } elseif ($webStatus -eq 'other_session') {
                Add-FormPrepError -Result $result -Source 'modal' -Text 'another Form Prep session is visible' -Severity 'Blocker'
                $result.reason = 'other_session'
                $result.exitCode = 3
            } else {
                [void](Wait-TargetsPrepared -Connection $conn -Config $cfg -Targets $targets -TimeoutSeconds ($TimeoutMinutes * 60) -PollSeconds $cfg.SqlPollSeconds)
            }
        }

        Get-PrepErrors -Config $cfg -Result $result -Targets $targets -CaptureDir $dirs.Capture

        $verified = Get-VerifyRows -Connection $conn -Config $cfg -Targets $targets
        Convert-VerifyToResult -Result $result -Targets $targets -Resolved $verified -AllowSameDayPrep:$AllowSameDayPrep
        if ($dirs) {
            Write-FormPrepSqlSnapshot -Rows $verified.Rows -JsonPath (Join-Path $dirs.RunDir 'sql-after.json')
        }

        if ($SkipPark) {
            $result.reason = 'dump'
            $result.exitCode = 0
            $result.ok = $false
            $result.parkedCount = 0
            $result.restoreOk = $true
            $result.executor = 'none'
        } elseif ($SkipWeb -and -not $allCli -and $parked) {
            $result.reason = 'cli_noop'
            $result.exitCode = 3
        }

        if ($PostHooks -and $result.prepared.Count -eq $targets.Count) {
            $hooksOk = Assert-PostHooks -Connection $conn -Config $cfg -Result $result -HookNames $PostHooks
            if (-not $hooksOk) {
                $result.exitCode = 4
                $result.reason = 'hook_failed'
            }
        }
    } catch {
        Add-FormPrepError -Result $result -Source 'execpreplock' -Text $_.Exception.Message -Severity 'Blocker'
        if (-not $result.reason) { $result.reason = 'error' }
        if ($parked) { $result.exitCode = 3 } elseif ($result.exitCode -eq 0) { $result.exitCode = 2 }
    } finally {
        if ($parked -and $conn) {
            try {
                Wait-FormPrepIdle -Connection $conn -Config $cfg -TimeoutSeconds 180 -QuietSeconds 30 -Result $result
                $restore = Restore-ParkSnapshot -Connection $conn -Config $cfg -RunId $result.runId
                $result.restoredCount = [int]$restore.RestoredCount
                $result.restoreOk = [bool]$restore.RestoreOk
                if (-not $restore.RestoreOk) {
                    Add-FormPrepError -Result $result -Source 'execpreplock' -Text ("restore short: {0}/{1}" -f $restore.RestoredCount, $result.parkedCount) -Severity 'Blocker'
                    $result.ok = $false
                    $result.exitCode = 3
                    $result.reason = 'restore_short'
                }
            } catch {
                Add-FormPrepError -Result $result -Source 'execpreplock' -Text ("restore failed: {0}" -f $_.Exception.Message) -Severity 'Blocker'
                $result.restoreOk = $false
                $result.ok = $false
                $result.exitCode = 3
                $result.reason = 'restore_failed'
            }
        }

        if ($conn) {
            try { $conn.Close(); $conn.Dispose() } catch { }
        }

        Unlock-FormPrepMutex -Lock $lock

        $applyRule = [bool]($Names -and $Names.Count -gt 0 -and -not $RepairOpenParks)
        Complete-ResultObject -Result $result -StartedAt $started -Targets $targets -RequestedNames $Names -ApplySuccessRule:$applyRule

        if ($result.exitCode -eq 4) {
            $result.ok = $false
        }

        $json = ConvertTo-FormPrepJson -Result $result
        if (Test-ResultHasPassword -Json $json) {
            Add-FormPrepError -Result $result -Source 'execpreplock' -Text 'refusing to write result JSON because it looks like it contains a password' -Severity 'Blocker'
            $result.ok = $false
        } elseif ($dirs) {
            $jsonPath = $ResultJson
            if (-not $jsonPath) { $jsonPath = Join-Path $dirs.RunDir 'result.json' }
            [void](Write-ResultJson -Result $result -Path $jsonPath -RunDir $dirs.RunDir -AgentWork $cfg.AgentWork)
        } elseif ($ResultJson) {
            [void](Write-ResultJson -Result $result -Path $ResultJson)
        }
    }

    return [pscustomobject]$result
}
