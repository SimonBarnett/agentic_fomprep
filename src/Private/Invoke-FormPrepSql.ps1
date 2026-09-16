function New-SqlCommandObject {
    param($Connection, [string]$Query, [int]$TimeoutSec = 60)

    $cmd = $Connection.CreateCommand()
    $cmd.CommandText = $Query
    $cmd.CommandTimeout = $TimeoutSec
    if ($script:FormPrepTransaction) {
        $cmd.Transaction = $script:FormPrepTransaction
    }
    return $cmd
}

function Add-SqlParameter {
    param($Command, [string]$Name, $Value)

    $p = $Command.CreateParameter()
    $p.ParameterName = $Name
    if ($null -eq $Value) {
        $p.Value = [DBNull]::Value
    } else {
        $p.Value = $Value
    }
    [void]$Command.Parameters.Add($p)
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
                Add-SqlParameter -Command $cmd -Name $k -Value $Parameters[$k]
            }
        }
        if ($NonQuery) {
            return $cmd.ExecuteNonQuery()
        }
        if ($Scalar) {
            $v = $cmd.ExecuteScalar()
            if ($v -is [DBNull]) { return $null }
            return $v
        }
        $adapterType = [Type]::GetType('System.Data.SqlClient.SqlDataAdapter, System.Data')
        if (-not $adapterType) {
            $adapterType = [Type]::GetType('System.Data.SqlClient.SqlDataAdapter, System.Data.SqlClient')
        }
        $table = New-Object System.Data.DataTable
        if ($adapterType) {
            $adapter = [Activator]::CreateInstance($adapterType, $cmd)
            [void]$adapter.Fill($table)
        } else {
            $reader = $cmd.ExecuteReader()
            try { $table.Load($reader) } finally { $reader.Close() }
        }
        return $table
    } finally {
        $cmd.Dispose()
    }
}
