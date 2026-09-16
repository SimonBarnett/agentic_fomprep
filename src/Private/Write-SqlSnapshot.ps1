function Convert-FormExecRowsToSnapshot {
    param($Rows)
    $list = New-Object System.Collections.Generic.List[object]
    foreach ($r in @($Rows)) {
        if ($null -eq $r) { continue }
        [void]$list.Add([ordered]@{
                name      = [string]$r.Name
                execId    = [int64]$r.ExecId
                upd       = $(if ($null -eq $r.Upd) { $null } else { [string]$r.Upd.Trim() })
                lastPrep  = (ConvertTo-LastPrepJsonValue $r.LastPrep)
                computer  = $r.Computer
                pid       = ConvertTo-Int64Id $r.Pid
            })
    }
    return , $list
}

function Write-FormPrepSqlSnapshot {
    param(
        $Rows,
        [string]$JsonPath,
        [string]$CsvPath
    )

    $snap = Convert-FormExecRowsToSnapshot $Rows
    $objects = @()
    foreach ($s in $snap) { $objects += $s }

    if ($JsonPath) {
        $dir = Split-Path -Parent $JsonPath
        if ($dir -and -not (Test-Path -LiteralPath $dir)) {
            [void][System.IO.Directory]::CreateDirectory($dir)
        }
        if ($objects.Count -eq 0) {
            $json = '[]'
        } elseif ($objects.Count -eq 1) {
            $json = '[' + ($objects[0] | ConvertTo-Json -Depth 5) + ']'
        } else {
            $json = $objects | ConvertTo-Json -Depth 5
        }
        [System.IO.File]::WriteAllText($JsonPath, $json)
    }
    if ($CsvPath) {
        $dir = Split-Path -Parent $CsvPath
        if ($dir -and -not (Test-Path -LiteralPath $dir)) {
            [void][System.IO.Directory]::CreateDirectory($dir)
        }
        $lines = New-Object System.Collections.Generic.List[string]
        [void]$lines.Add('name,exec_id,upd,last_prep,computer,pid')
        foreach ($s in $objects) {
            $comp = ''
            if ($s.computer) { $comp = [string]$s.computer }
            [void]$lines.Add(('{0},{1},{2},{3},{4},{5}' -f $s.name, $s.execId, $s.upd, $s.lastPrep, $comp, $s.pid))
        }
        [System.IO.File]::WriteAllLines($CsvPath, $lines)
    }
}
