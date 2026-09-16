function Test-SqlIdentToken {
    param([string]$Token)
    # Priority dictionary ids use $ (T$EXEC, T$USER). Still reject ; ] whitespace.
    return [bool]($Token -match '^[A-Za-z_][A-Za-z0-9_$]*$')
}

function ConvertTo-SqlIdent {
    <#
    .SYNOPSIS
        Bracket a schema.table or column name. Rejects anything that is not a simple identifier.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    $trimmed = $Name.Trim()
    if ([string]::IsNullOrWhiteSpace($trimmed) -or $trimmed -eq '<PIN>') {
        throw "SQL identifier is not pinned: '$Name'"
    }

    $parts = $trimmed.Split('.')
    $out = New-Object System.Collections.Generic.List[string]
    foreach ($p in $parts) {
        $token = $p.Trim().TrimStart('[').TrimEnd(']')
        if (-not (Test-SqlIdentToken $token)) {
            throw "Refusing SQL identifier '$Name' (token '$token')"
        }
        [void]$out.Add('[' + $token + ']')
    }
    return ($out -join '.')
}

function Test-FormName {
    param([string]$Name)
    return [bool]($Name -match '^[A-Za-z][A-Za-z0-9_]*$')
}
