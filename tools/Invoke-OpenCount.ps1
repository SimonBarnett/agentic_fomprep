#requires -Version 5.1
# Read-only OPEN park count. Exit 3 if any restored_at IS NULL.
$ErrorActionPreference = 'Stop'
Import-Module (Join-Path (Split-Path -Parent $PSScriptRoot) 'src\CE.FormPrep.psd1') -Force
$conn = New-FormPrepSqlConnection -Config (Get-FormPrepConfig)
$open = Invoke-FormPrepSql -Connection $conn -Query "SELECT COUNT(*) FROM dbo.AGENT_FORMPREP_PARK WHERE restored_at IS NULL" -Scalar
Write-Host ("OPEN={0}" -f $open)
$conn.Close(); $conn.Dispose()
if ([int]$open -ne 0) { exit 3 }
exit 0
