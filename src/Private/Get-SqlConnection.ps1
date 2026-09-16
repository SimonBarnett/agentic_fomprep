function Get-SqlClientType {
    $existing = [AppDomain]::CurrentDomain.GetAssemblies() |
        Where-Object { $_.GetType('System.Data.SqlClient.SqlConnection', $false) }
    if ($existing) {
        return [System.Data.SqlClient.SqlConnection]
    }

    try {
        Add-Type -AssemblyName System.Data -ErrorAction Stop
    } catch {
        # PS7 may not load System.Data.SqlClient this way
    }

    $t = [Type]::GetType('System.Data.SqlClient.SqlConnection, System.Data, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
    if (-not $t) {
        $t = [Type]::GetType('System.Data.SqlClient.SqlConnection, System.Data.SqlClient')
    }
    if (-not $t) {
        throw 'System.Data.SqlClient is not available. Use Windows PowerShell 5.1 on DEV1.'
    }
    return $t
}

function New-FormPrepSqlConnection {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Config,
        [string]$Database
    )

    if (-not $Database) { $Database = $Config.SqlDatabase }
    if ([string]::IsNullOrWhiteSpace($Database) -or $Database -eq '<PIN>') {
        throw 'SqlDatabase is not pinned. Run tools/Invoke-Recon.ps1 on DEV1.'
    }
    if ($Database -notmatch '^[A-Za-z_][A-Za-z0-9_]*$') {
        throw "Refusing database name '$Database'"
    }

    $encrypt = if ($Config.SqlEncrypt) { 'True' } else { 'False' }
    $cs = "Server=$($Config.SqlInstance);Database=$Database;Integrated Security=True;Connection Timeout=15;Encrypt=$encrypt;TrustServerCertificate=True"
    $connType = Get-SqlClientType
    $conn = [Activator]::CreateInstance($connType)
    $conn.ConnectionString = $cs
    $conn.Open()
    return $conn
}
