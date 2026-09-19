function Test-SqlIdentToken {
    param([string]$Token)
    return [bool]($Token -match '^[A-Za-z_][A-Za-z0-9_$]*$')
}

function ConvertTo-SqlIdent {
    [CmdletBinding()]
    param([Parameter(Mandatory = $true)][string]$Name)
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

function Get-SqlClientType {
    $existing = [AppDomain]::CurrentDomain.GetAssemblies() |
        Where-Object { $_.GetType('System.Data.SqlClient.SqlConnection', $false) }
    if ($existing) {
        return [System.Data.SqlClient.SqlConnection]
    }
    try { Add-Type -AssemblyName System.Data -ErrorAction Stop } catch { }
    $t = [Type]::GetType('System.Data.SqlClient.SqlConnection, System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
    if (-not $t) { $t = [Type]::GetType('System.Data.SqlClient.SqlConnection, System.Data.SqlClient') }
    if (-not $t) { throw 'System.Data.SqlClient is not available. Use Windows PowerShell 5.1.' }
    return $t
}

function New-InstanceSqlConnection {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Instance,
        [string]$Database
    )
    if (-not $Database) { $Database = [string]$Instance.sqlDatabase }
    if ([string]::IsNullOrWhiteSpace($Database)) { $Database = 'system' }
    if ($Database -notmatch '^[A-Za-z_][A-Za-z0-9_]*$') { throw "Refusing database name '$Database'" }
    $encrypt = if ($Instance.sqlEncrypt) { 'True' } else { 'False' }
    $server = [string]$Instance.sqlInstance
    if ([string]::IsNullOrWhiteSpace($server)) { throw 'sqlInstance is empty' }

    $cs = "Server=$server;Database=$Database;Connection Timeout=15;Encrypt=$encrypt;TrustServerCertificate=True"
    $sqlTarget = [string]$Instance.sqlCredentialTarget
    $sqlCred = $null
    if ($sqlTarget) {
        $sqlCred = Get-WinrunCredential -Target $sqlTarget
        if (-not $sqlCred -or -not $sqlCred.UserName) { throw "No SQL CredMan target '$sqlTarget'" }
    } else {
        $cs += ';Integrated Security=True'
    }

    $connType = Get-SqlClientType
    $conn = [Activator]::CreateInstance($connType)
    $conn.ConnectionString = $cs
    if ($sqlCred) {
        $secure = ConvertTo-SecureString -String ([string]$sqlCred.Password) -AsPlainText -Force
        $conn.Credential = New-Object System.Data.SqlClient.SqlCredential($sqlCred.UserName, $secure)
    }
    $conn.Open()
    return $conn
}

function New-SqlCommandObject {
    param($Connection, [string]$Query, [int]$TimeoutSec = 60)
    $cmd = $Connection.CreateCommand()
    $cmd.CommandText = $Query
    $cmd.CommandTimeout = $TimeoutSec
    return $cmd
}

function Invoke-FormPrepSql {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Connection,
        [Parameter(Mandatory = $true)][string]$Query,
        [hashtable]$Parameters,
        [switch]$NonQuery,
        [switch]$Scalar,
        [int]$TimeoutSec = 60
    )
    $cmd = New-SqlCommandObject -Connection $Connection -Query $Query -TimeoutSec $TimeoutSec
    try {
        if ($Parameters) {
            foreach ($k in $Parameters.Keys) {
                $p = $cmd.CreateParameter()
                $p.ParameterName = $k
                if ($null -eq $Parameters[$k]) { $p.Value = [DBNull]::Value } else { $p.Value = $Parameters[$k] }
                [void]$cmd.Parameters.Add($p)
            }
        }
        if ($NonQuery) { return $cmd.ExecuteNonQuery() }
        if ($Scalar) {
            $v = $cmd.ExecuteScalar()
            if ($v -is [DBNull]) { return $null }
            return $v
        }
        $adapterType = [Type]::GetType('System.Data.SqlClient.SqlDataAdapter, System.Data')
        if (-not $adapterType) { $adapterType = [Type]::GetType('System.Data.SqlClient.SqlDataAdapter, System.Data.SqlClient') }
        $table = New-Object System.Data.DataTable
        if ($adapterType) {
            $adapter = [Activator]::CreateInstance($adapterType, $cmd)
            [void]$adapter.Fill($table)
        } else {
            $reader = $cmd.ExecuteReader()
            try { $table.Load($reader) } finally { $reader.Close() }
        }
        return , $table
    } finally {
        $cmd.Dispose()
    }
}
