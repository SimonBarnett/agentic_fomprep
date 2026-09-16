function Get-FormExec {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Connection,
        [Parameter(Mandatory = $true)]$Config,
        [Parameter(Mandatory = $true)][string[]]$Names
    )

    foreach ($n in $Names) {
        if (-not (Test-FormName $n)) {
            throw "Refusing form name '$n'"
        }
    }

    $execTable = ConvertTo-SqlIdent $Config.ExecTable
    $lockTable = ConvertTo-SqlIdent $Config.LockTable
    $nameCol = ConvertTo-SqlIdent $Config.ExecNameCol
    $idCol = ConvertTo-SqlIdent $Config.ExecIdCol
    $lId = ConvertTo-SqlIdent $Config.LockCols.ExecId
    $lUpd = ConvertTo-SqlIdent $Config.LockCols.Upd
    $lPrep = ConvertTo-SqlIdent $Config.LockCols.LastPrep
    $lComp = ConvertTo-SqlIdent $Config.LockCols.Computer
    $lPid = ConvertTo-SqlIdent $Config.LockCols.Pid
    $lExp = ConvertTo-SqlIdent $Config.LockCols.LockExpiry

    $paramNames = @()
    $parameters = @{}
    for ($i = 0; $i -lt $Names.Count; $i++) {
        $pn = "@n$i"
        $paramNames += $pn
        $parameters[$pn] = $Names[$i]
    }
    $inList = $paramNames -join ', '

    $sql = @"
SELECT E.$nameCol AS name,
       E.$idCol   AS exec_id,
       L.$lUpd    AS upd,
       L.$lPrep   AS last_prep,
       L.$lComp   AS computer,
       L.$lPid    AS pid,
       L.$lExp    AS lock_expiry
FROM $execTable E
LEFT JOIN $lockTable L ON L.$lId = E.$idCol
WHERE E.$nameCol IN ($inList)
"@

    $table = Invoke-FormPrepSql -Connection $Connection -Query $sql -Parameters $parameters
    $rows = @()
    foreach ($r in $table.Rows) {
        $rows += [pscustomobject]@{
            Name       = [string]$r.name
            ExecId     = [int64]$r.exec_id
            Upd        = $(if ($r.upd -is [DBNull]) { $null } else { [string]$r.upd })
            LastPrep   = $(if ($r.last_prep -is [DBNull]) { $null } else { $r.last_prep })
            Computer   = $(if ($r.computer -is [DBNull]) { $null } else { [string]$r.computer })
            Pid        = $(if ($r.pid -is [DBNull]) { [int64]0 } else { [int64]$r.pid })
            LockExpiry = $(if ($r.lock_expiry -is [DBNull]) { $null } else { $r.lock_expiry })
        }
    }

    $found = @($rows | ForEach-Object { $_.Name })
    $missing = @($Names | Where-Object { $found -notcontains $_ })
    return [pscustomobject]@{
        Rows    = $rows
        Missing = $missing
    }
}

function ConvertTo-Int64Id {
    param($Value)
    if ($null -eq $Value -or $Value -is [DBNull]) { return [int64]0 }
    return [int64]$Value
}

function ConvertTo-LastPrepJsonValue {
    param($Value)
    if ($null -eq $Value -or $Value -is [DBNull]) { return $null }
    if ($Value -is [datetime]) { return ([datetime]$Value).ToString('o') }
    if ($Value -is [int] -or $Value -is [long] -or $Value -is [int64] -or $Value -is [decimal] -or $Value -is [double]) {
        return [int64]$Value
    }
    if ($Value -is [string]) { return $Value }
    return [string]$Value
}

function Test-LastPrepAdvanced {
    param($Before, $After)
    # LASTPREPDATE is bigint (WP0 / P0-V1). 0 = never. No DateTime parse.
    # Success: after > before (covers before=0 AND after>0).
    if ($null -eq $After -or $After -is [DBNull]) { return $false }
    $a = ConvertTo-Int64Id $After
    $b = ConvertTo-Int64Id $Before
    return ($a -gt $b)
}
