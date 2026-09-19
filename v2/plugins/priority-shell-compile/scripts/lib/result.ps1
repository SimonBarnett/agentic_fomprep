function New-ShellResult {
    param(
        [Parameter(Mandatory = $true)][string]$Skill,
        [string]$InstanceId,
        [datetime]$StartedAt = [datetime]::UtcNow
    )
    return [ordered]@{
        ok             = $false
        runId          = [guid]::NewGuid().ToString().ToLowerInvariant()
        instanceId     = $(if ($InstanceId) { $InstanceId } else { $null })
        skill          = $Skill
        executor       = 'none'
        startedAt      = $StartedAt.ToString('o')
        endedAt        = $null
        durationSec    = 0
        reason         = $null
        exitCode       = 2
        errors         = @()
        whatIf         = $false
        wcfAttempted   = $false
    }
}

function Add-ShellError {
    param(
        $Result,
        [string]$Source,
        [string]$Severity,
        [string]$Text,
        [string]$EntityHint
    )
    $item = [ordered]@{
        source   = $Source
        severity = $Severity
        text     = $Text
    }
    if ($EntityHint) { $item.entityHint = $EntityHint }
    $Result.errors = @($Result.errors) + @([pscustomobject]$item)
}

function Complete-ShellResult {
    param($Result, [datetime]$StartedAt)
    $ended = [datetime]::UtcNow
    $Result.endedAt = $ended.ToString('o')
    $Result.durationSec = [int][Math]::Max(0, ($ended - $StartedAt).TotalSeconds)
    if (-not $Result.ok -and @($Result.errors).Count -lt 1) {
        Add-ShellError -Result $Result -Source 'policy' -Severity 'Blocker' -Text 'errors[] was empty on fail'
    }
}

function Get-ShellWorkRoot {
    param($Instance, [string]$Skill)
    $work = $null
    if ($Instance -and $Instance.agentWork) { $work = [string]$Instance.agentWork }
    if (-not $work) {
        $id = 'default'
        if ($Instance -and $Instance.id) { $id = [string]$Instance.id }
        $work = Join-Path $env:TEMP ("priority-shell-" + $id)
    }
    New-Item -ItemType Directory -Path $work -Force | Out-Null
    return $work
}

function Write-ShellJson {
    param($Result, [string]$WorkRoot, [string]$LastName)
    $json = $Result | ConvertTo-Json -Depth 8 -Compress
    if ($WorkRoot -and $LastName) {
        New-Item -ItemType Directory -Path $WorkRoot -Force | Out-Null
        $last = Join-Path $WorkRoot $LastName
        [System.IO.File]::WriteAllText($last, $json)
        $runDir = Join-Path $WorkRoot $Result.runId
        New-Item -ItemType Directory -Path $runDir -Force | Out-Null
        [System.IO.File]::WriteAllText((Join-Path $runDir 'result.json'), $json)
        Write-Host ("resultJson={0}" -f (Join-Path $runDir 'result.json'))
    }
    Write-Output $json
}

function Test-IsWindowsShellRunner {
    return ($env:OS -eq 'Windows_NT' -or $PSVersionTable.PSEdition -eq 'Desktop')
}
