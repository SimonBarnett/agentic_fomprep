#requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$script:FormPrepRoot = Split-Path -Parent $PSScriptRoot
if (-not (Test-Path -LiteralPath (Join-Path $script:FormPrepRoot 'config'))) {
    # Module lives in src\; repo root is parent.
    $script:FormPrepRoot = Split-Path -Parent $PSScriptRoot
}
$script:FormPrepTransaction = $null

$privateDir = Join-Path $PSScriptRoot 'Private'
$publicDir = Join-Path $PSScriptRoot 'Public'

Get-ChildItem -LiteralPath $privateDir -Filter '*.ps1' | Sort-Object Name | ForEach-Object {
    . $_.FullName
}
Get-ChildItem -LiteralPath $publicDir -Filter '*.ps1' | Sort-Object Name | ForEach-Object {
    . $_.FullName
}

Export-ModuleMember -Function Prepare-Forms, Get-FormPrepConfig, Get-FrozenEnvironment, New-FormPrepSqlConnection, Invoke-FormPrepSql, ConvertTo-SqlIdent
