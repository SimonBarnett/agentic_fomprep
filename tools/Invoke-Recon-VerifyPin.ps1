#requires -Version 5.1
# WP0 done-when: ConvertTo-SqlIdent accepts T$EXEC; lock SELECT works; three ZCLA names resolve.
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
Import-Module (Join-Path $repo 'src\CE.FormPrep.psd1') -Force

$cfg = Get-FormPrepConfig
if (-not $cfg.PinComplete) { throw 'PinComplete is false' }
if ($cfg.SqlDatabase -eq '<PIN>' -or $cfg.ExecTable -eq '<PIN>') { throw 'SqlDatabase/ExecTable still <PIN>' }
if ($env:COMPUTERNAME -notin @($cfg.AllowedComputer)) {
    throw "Refuse verify on '$($env:COMPUTERNAME)'"
}

Write-Host "ConvertTo-SqlIdent ExecTable = $(ConvertTo-SqlIdent $cfg.ExecTable)"
Write-Host "ConvertTo-SqlIdent ExecIdCol = $(ConvertTo-SqlIdent $cfg.ExecIdCol)"
Write-Host "ConvertTo-SqlIdent Lock ExecId = $(ConvertTo-SqlIdent $cfg.LockCols.ExecId)"

$names = @('ZCLA_PARTLONGDESC', 'ZCLA_PARTLONGDHIST', 'ZCLA_PARTLONGDREV')
$result = Prepare-Forms -Names $names -Environment DEV -WhatIf
if ($result.exitCode -ne 0) {
    throw "WhatIf exitCode=$($result.exitCode) reason=$($result.reason)"
}
if ($result.reason -notmatch 'targets=3') {
    throw "WhatIf did not resolve 3 targets: $($result.reason)"
}
Write-Host 'WP0 verify PASS: lock SELECT works; three ZCLA names resolve.'

