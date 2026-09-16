#requires -Version 5.1
<#
.SYNOPSIS
    WP0: read-only reconnaissance against CE Priority DEV. Pin the printed values into config/dev.psd1.
    Refuses to run unless this computer is AllowedComputer and SqlInstance matches the frozen DEV instance.
#>
[CmdletBinding()]
param(
    [string]$ConfigPath
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
Import-Module (Join-Path $repo 'src\CE.FormPrep.psd1') -Force

$cfg = Get-FormPrepConfig -Path $ConfigPath -Environment DEV
$frozen = Get-FrozenEnvironment
if ($env:COMPUTERNAME -notin @($cfg.AllowedComputer)) {
    throw "Refuse recon on '$($env:COMPUTERNAME)'. Allowed: $($cfg.AllowedComputer -join ', ')"
}
if ($cfg.SqlInstance -ne $frozen.SqlInstance) {
    throw "Refuse recon: SqlInstance '$($cfg.SqlInstance)' is not $($frozen.SqlInstance)"
}

Write-Host "Connecting Windows-integrated to $($cfg.SqlInstance) (master) ..."
# Connect to master first to list databases. SqlDatabase may still be <PIN>.
$masterCfg = $cfg.PSObject.Copy()
# Get-FormPrepConfig returns pscustomobject; clone via JSON
$master = $cfg | ConvertTo-Json -Depth 6 | ConvertFrom-Json
$master.SqlDatabase = 'master'
$conn = New-FormPrepSqlConnection -Config $master -Database 'master'
try {
    $session = Invoke-FormPrepSql -Connection $conn -Query "SELECT DB_NAME() AS db, SUSER_SNAME() AS login, HOST_NAME() AS host, @@SERVERNAME AS server_name"
    $session | Format-Table -AutoSize | Out-String | Write-Host

    $dbs = Invoke-FormPrepSql -Connection $conn -Query "SELECT name FROM sys.databases WHERE name NOT IN ('master','tempdb','model','msdb') ORDER BY name"
    Write-Host 'User databases:'
    $dbs | Format-Table -AutoSize | Out-String | Write-Host

    foreach ($row in $dbs.Rows) {
        $dbName = [string]$row.name
        Write-Host "---- $dbName ----"
        $dbConn = New-FormPrepSqlConnection -Config $cfg -Database $dbName
        try {
            $prep = Invoke-FormPrepSql -Connection $dbConn -Query @"
SELECT s.name AS sch, t.name AS tbl
FROM sys.tables t
JOIN sys.schemas s ON s.schema_id = t.schema_id
WHERE t.name LIKE '%PREP%' OR t.name LIKE '%EXEC%' OR t.name LIKE '%FORMKEY%'
ORDER BY t.name
"@
            $prep | Format-Table -AutoSize | Out-String | Write-Host

            $pair = Invoke-FormPrepSql -Connection $dbConn -Query @"
SELECT s.name AS sch, t.name AS tbl
FROM sys.tables t
JOIN sys.schemas s ON s.schema_id = t.schema_id
WHERE EXISTS (SELECT 1 FROM sys.columns c WHERE c.object_id = t.object_id AND c.name = 'UPD')
  AND EXISTS (SELECT 1 FROM sys.columns c WHERE c.object_id = t.object_id AND c.name = 'LASTPREPDATE')
"@
            Write-Host 'Tables with UPD + LASTPREPDATE:'
            $pair | Format-Table -AutoSize | Out-String | Write-Host

            foreach ($t in $pair.Rows) {
                $ident = ConvertTo-SqlIdent ('{0}.{1}' -f $t.sch, $t.tbl)
                $cols = Invoke-FormPrepSql -Connection $dbConn -Query @"
SELECT c.name, ty.name AS type_name, c.max_length
FROM sys.columns c
JOIN sys.types ty ON ty.user_type_id = c.user_type_id
WHERE c.object_id = OBJECT_ID(@obj)
"@ -Parameters @{ '@obj' = ('{0}.{1}' -f $t.sch, $t.tbl) }
                Write-Host "Columns of $ident :"
                $cols | Format-Table -AutoSize | Out-String | Write-Host
            }

            try {
                $forms = Invoke-FormPrepSql -Connection $dbConn -Query "SELECT TOP 20 * FROM dbo.EXEC WHERE ENAME LIKE 'ZCLA_PARTLONG%'"
                Write-Host 'ZCLA_PARTLONG% via dbo.EXEC:'
                $forms | Format-Table -AutoSize | Out-String | Write-Host
            } catch {
                Write-Host "dbo.EXEC not readable in ${dbName}: $($_.Exception.Message)"
            }
        } finally {
            $dbConn.Close(); $dbConn.Dispose()
        }
    }
} finally {
    $conn.Close(); $conn.Dispose()
}

Write-Host @'
Recon finished. Pin config/dev.psd1:
  SqlDatabase, ExecTable, ExecNameCol, ExecIdCol, LockTable, LockCols.*, FormKeysTable
  Company (actual), AllowedComputer if the DEV RDP host is not CE-PRIORITY-DEV1
Then set PinComplete = $true and bump nothing in Get-FrozenEnvironment.ps1 (hosts stay frozen).
'@
