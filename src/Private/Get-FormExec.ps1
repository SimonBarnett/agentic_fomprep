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
            ExecId     = [int]$r.exec_id
            Upd        = $(if ($r.upd -is [DBNull]) { $null } else { [string]$r.upd })
            LastPrep   = $(if ($r.last_prep -is [DBNull]) { $null } else { $r.last_prep })
            Computer   = $(if ($r.computer -is [DBNull]) { $null } else { [string]$r.computer })
            Pid        = $(if ($r.pid -is [DBNull]) { 0 } else { [int]$r.pid })
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

function ConvertTo-LastPrepJsonValue {
    param($Value)
    if ($null -eq $Value -or $Value -is [DBNull]) { return $null }
    if ($Value -is [datetime]) { return ([datetime]$Value).ToString('o') }
    if ($Value -is [string] -or $Value -is [int] -or $Value -is [long] -or $Value -is [decimal] -or $Value -is [double]) {
        return $Value
    }
    return [string]$Value
}

function Test-LastPrepAdvanced {
    param($Before, $After)
    if ($null -eq $After) { return $false }
    if ($null -eq $Before) { return $true }
    try {
        if ($After -is [datetime] -and $Before -is [datetime]) {
            return $After -gt $Before
        }
        $ab = [datetime]$After
        $bb = [datetime]$Before
        return $ab -gt $bb
    } catch {
        return ([string]$After) -ne ([string]$Before) -and -not [string]::IsNullOrWhiteSpace([string]$After)
    }
}
