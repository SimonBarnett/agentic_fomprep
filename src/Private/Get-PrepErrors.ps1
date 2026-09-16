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

function Get-LatestEmsg {
    param([string]$PriorityRoot)
    $tmp = Join-Path $PriorityRoot 'tmp'
    if (-not (Test-Path -LiteralPath $tmp)) { return $null }
    $files = Get-ChildItem -LiteralPath $tmp -Filter 'e*msg' -File -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending
    if ($files) { return $files[0] }
    return $null
}

function Get-PrepErrors {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Config,
        [Parameter(Mandatory = $true)]$Result,
        [Parameter(Mandatory = $true)]$Targets,
        [Parameter(Mandatory = $true)][string]$CaptureDir
    )

    $nameHints = @($Targets | ForEach-Object { $_.Name })

    $emsg = Get-LatestEmsg -PriorityRoot $Config.PriorityRoot
    if ($emsg) {
        $dest = Join-Path $CaptureDir 'emsg.txt'
        [void](Copy-CaptureFile -Source $emsg.FullName -Dest $dest)
        $text = [System.IO.File]::ReadAllText($emsg.FullName)
        $first = (($text -split '\r?\n') | Where-Object { $_ -ne '' } | Select-Object -First 1)
        if (-not $first) { $first = $emsg.Name }
        $errN = 0
        if ($text -match 'Number of errors\s*=\s*(\d+)') { $errN = [int]$Matches[1] }
        $sev = 'Info'
        if ($errN -gt 0) { $sev = 'Warning' }
        $hint = $null
        foreach ($n in $nameHints) {
            if ($text -match [regex]::Escape($n)) { $hint = $n; $sev = 'Blocker'; break }
        }
        Add-FormPrepError -Result $Result -Source 'emsg' -Text $first -Severity $sev -FormHint $hint
    } else {
        Add-FormPrepError -Result $Result -Source 'emsg' -Text 'no e*msg file in C:\Priority\tmp' -Severity 'Info'
    }

    $prepErr = Join-Path $Config.PriorityRoot 'tmp\prep.err'
    if (Test-Path -LiteralPath $prepErr) {
        [void](Copy-CaptureFile -Source $prepErr -Dest (Join-Path $CaptureDir 'prep.err'))
        $text = [System.IO.File]::ReadAllText($prepErr)
        $hint = $null
        $sev = 'Info'
        foreach ($n in $nameHints) {
            if ($text -match [regex]::Escape($n)) { $hint = $n; $sev = 'Warning'; break }
        }
        Add-FormPrepError -Result $Result -Source 'prep.err' -Text 'prep.err captured' -Severity $sev -FormHint $hint
    }

    $report = Join-Path $CaptureDir 'errors-report.html'
    if (Test-Path -LiteralPath $report) {
        $html = [System.IO.File]::ReadAllText($report)
        $sev = 'Info'
        $hint = $null
        foreach ($n in $nameHints) {
            if ($html -match [regex]::Escape($n)) { $hint = $n; $sev = 'Blocker'; break }
        }
        Add-FormPrepError -Result $Result -Source 'errors-report' -Text 'Errors Report captured' -Severity $sev -FormHint $hint
    }
}
