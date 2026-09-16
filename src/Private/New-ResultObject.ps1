function New-ResultObject {
    param(
        [guid]$RunId = [guid]::NewGuid(),
        [datetime]$StartedAt = (Get-Date).ToUniversalTime()
    )

    $id = $RunId.ToString().ToLowerInvariant()
    return [ordered]@{
        ok              = $false
        runId           = $id
        environment     = 'DEV'
        executor        = 'none'
        startedAt       = $StartedAt.ToString('o')
        endedAt         = $null
        durationSec     = 0
        parkedCount     = 0
        restoredCount   = 0
        restoreOk       = $true
        prepared        = @()
        stillUnprepared = @()
        errors          = @()
        dialogs         = @()
        auth            = 'unknown'
        whatIf          = $false
        reason          = $null
        exitCode        = 2
    }
}

function Add-FormPrepError {
    param(
        $Result,
        [string]$Source,
        [string]$Text,
        [ValidateSet('Info', 'Warning', 'Blocker')]
        [string]$Severity,
        [string]$FormHint
    )

    $item = [ordered]@{
        source   = $Source
        text     = $Text
        severity = $Severity
        formHint = $(if ($FormHint) { $FormHint } else { '' })
    }
    $Result.errors += @([pscustomobject]$item)
}

function Add-FormPrepDialog {
    param(
        $Result,
        [string]$Text,
        [ValidateSet('captured-left', 'dismissed-safe', 'blocked-run')]
        [string]$Action
    )
    $Result.dialogs += @([pscustomobject]@{
            text   = $Text
            action = $Action
        })
}

function Complete-ResultObject {
    param(
        $Result,
        [datetime]$StartedAt,
        $Targets,
        [string[]]$RequestedNames,
        [switch]$ApplySuccessRule
    )

    $ended = (Get-Date).ToUniversalTime()
    $Result.endedAt = $ended.ToString('o')
    $dur = [int][Math]::Max(0, ($ended - $StartedAt).TotalSeconds)
    $Result.durationSec = $dur

    if (-not $ApplySuccessRule) { return }

    $blockerOnTarget = $false
    $nameSet = @{}
    foreach ($n in @($RequestedNames)) { $nameSet[$n] = $true }
    foreach ($e in @($Result.errors)) {
        $hint = ''
        if ($e.PSObject.Properties['formHint']) { $hint = [string]$e.formHint }
        if ($e.severity -eq 'Blocker' -and $hint -and $nameSet.ContainsKey($hint)) {
            $blockerOnTarget = $true
        }
        if ($e.severity -eq 'Blocker' -and $e.source -eq 'execpreplock' -and $e.text -match 'restore short') {
            $blockerOnTarget = $true
        }
    }

    $allPrepared = $true
    if ($RequestedNames -and $RequestedNames.Count -gt 0) {
        $prepNames = @($Result.prepared | ForEach-Object { $_.name })
        foreach ($n in $RequestedNames) {
            if ($prepNames -notcontains $n) { $allPrepared = $false }
        }
    } else {
        $allPrepared = $false
    }

    $Result.restoreOk = [bool]($Result.restoredCount -eq $Result.parkedCount)
    $Result.ok = [bool](
        $allPrepared -and
        $Result.restoreOk -and
        -not $blockerOnTarget -and
        -not $Result.whatIf
    )

    if ($Result.whatIf) {
        $Result.ok = $false
        $Result.exitCode = 0
        return
    }

    if ($Result.ok) {
        $Result.exitCode = 0
    }
}
