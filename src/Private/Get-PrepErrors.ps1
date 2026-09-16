function Copy-CaptureFile {
    param([string]$Source, [string]$Dest)
    if (-not (Test-Path -LiteralPath $Source)) { return $false }
    $dir = Split-Path -Parent $Dest
    if ($dir -and -not (Test-Path -LiteralPath $dir)) {
        [void][System.IO.Directory]::CreateDirectory($dir)
    }
    Copy-Item -LiteralPath $Source -Destination $Dest -Force
    return $true
}

function Test-CompileFailLine {
    param([string]$Line)
    return [bool]($Line -match '(?i)(compile\s+(fail|error)|syntax error|cannot compile|failed to (compile|prepare)|trigger .*(error|fail)|#\s*\d{3,})')
}

function Add-ParsedErrorLines {
    param(
        $Result,
        [string]$Source,
        [string]$Text,
        [string[]]$NameHints,
        [int]$Cap = 200
    )
    $lines = @(($Text -split '\r?\n') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' })
    $n = 0
    $rest = New-Object System.Collections.Generic.List[string]
    foreach ($line in $lines) {
        $hint = $null
        foreach ($nm in $NameHints) {
            if ($line -match [regex]::Escape($nm)) { $hint = $nm; break }
        }
        $sev = 'Info'
        if (Test-CompileFailLine -Line $line) {
            $sev = 'Warning'
            if ($hint) { $sev = 'Warning' }
        } elseif ($hint) {
            $sev = 'Warning'
        }
        # E4: name mention is never Blocker. ok stays SQL-gated.
        if ($n -lt $Cap) {
            Add-FormPrepError -Result $Result -Source $Source -Text $line -Severity $sev -FormHint $hint
            $n++
        } else {
            [void]$rest.Add($line)
        }
    }
    return , $rest
}

function Get-LatestEmsg {
    param([string]$PriorityRoot, [datetime]$NotBeforeUtc)
    $tmp = Join-Path $PriorityRoot 'tmp'
    if (-not (Test-Path -LiteralPath $tmp)) { return $null }
    $files = @(Get-ChildItem -LiteralPath $tmp -Filter 'e*msg' -File -ErrorAction SilentlyContinue |
            Sort-Object LastWriteTime -Descending)
    foreach ($f in $files) {
        if ($f.LastWriteTime.ToUniversalTime() -ge $NotBeforeUtc.AddMinutes(-1)) { return $f }
    }
    return $null
}

function Get-PrepErrors {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Config,
        [Parameter(Mandatory = $true)]$Result,
        [Parameter(Mandatory = $true)]$Targets,
        [Parameter(Mandatory = $true)][string]$CaptureDir,
        [datetime]$StartedAt = [datetime]::SpecifyKind([datetime]::MinValue, 'Utc')
    )

    $nameHints = @($Targets | ForEach-Object { $_.Name })
    $notBefore = $StartedAt
    if ($StartedAt -eq [datetime]::MinValue) { $notBefore = [datetime]::UtcNow.AddHours(-1) }

    $emsg = Get-LatestEmsg -PriorityRoot $Config.PriorityRoot -NotBeforeUtc $notBefore
    if ($emsg) {
        $dest = Join-Path $CaptureDir 'emsg.txt'
        [void](Copy-CaptureFile -Source $emsg.FullName -Dest $dest)
        $text = [System.IO.File]::ReadAllText($emsg.FullName)
        $rest = Add-ParsedErrorLines -Result $Result -Source 'emsg' -Text $text -NameHints $nameHints
        if ($rest.Count -gt 0) {
            [System.IO.File]::WriteAllLines((Join-Path $CaptureDir 'emsg-rest.txt'), $rest)
        }
    } else {
        Add-FormPrepError -Result $Result -Source 'emsg' -Text 'no e*msg file newer than startedAt' -Severity 'Info'
    }

    $prepErr = Join-Path $Config.PriorityRoot 'tmp\prep.err'
    if (Test-Path -LiteralPath $prepErr) {
        $item = Get-Item -LiteralPath $prepErr
        if ($item.LastWriteTime.ToUniversalTime() -ge $notBefore.AddMinutes(-1)) {
            [void](Copy-CaptureFile -Source $prepErr -Dest (Join-Path $CaptureDir 'prep.err'))
            $text = [System.IO.File]::ReadAllText($prepErr)
            $rest = Add-ParsedErrorLines -Result $Result -Source 'prep.err' -Text $text -NameHints $nameHints
            if ($rest.Count -gt 0) {
                [System.IO.File]::WriteAllLines((Join-Path $CaptureDir 'prep.err-rest.txt'), $rest)
            }
        }
    }

    $jsonl = Join-Path $CaptureDir 'errors-report.jsonl'
    if (Test-Path -LiteralPath $jsonl) {
        $n = 0
        Get-Content -LiteralPath $jsonl | ForEach-Object {
            if ($n -ge 200) { return }
            $line = $_.Trim()
            if (-not $line) { return }
            $obj = $null
            try { $obj = $line | ConvertFrom-Json } catch { $obj = $null }
            $text = if ($obj -and $obj.text) { [string]$obj.text } else { $line }
            $hint = $null
            foreach ($nm in $nameHints) {
                if ($text -match [regex]::Escape($nm)) { $hint = $nm; break }
            }
            $sev = 'Info'
            if (Test-CompileFailLine -Line $text) { $sev = 'Warning' }
            elseif ($hint) { $sev = 'Warning' }
            Add-FormPrepError -Result $Result -Source 'errors-report' -Text $text -Severity $sev -FormHint $hint
            $n++
        }
    } elseif (Test-Path -LiteralPath (Join-Path $CaptureDir 'errors-report.html')) {
        Add-FormPrepError -Result $Result -Source 'errors-report' -Text 'errors-report.html present but no JSONL scrape' -Severity 'Info'
    }
}
