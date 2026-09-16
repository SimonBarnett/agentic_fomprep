@{
    RootModule        = 'CE.FormPrep.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = '7c8e2a91-4b3f-4d6a-9e1c-2f0a8b7c6d5e'
    Author            = 'Clarkson Evans'
    CompanyName       = 'Clarkson Evans'
    Copyright         = '(c) 2026 Clarkson Evans. DEV only.'
    Description       = 'Unattended Priority Form Prep for CE DEV (Hybrid F). Never targets live/PRI.'
    PowerShellVersion = '5.1'
    FunctionsToExport = @(
        'Prepare-Forms'
        'Get-FormPrepConfig'
        'Get-FrozenEnvironment'
        'New-FormPrepSqlConnection'
        'Invoke-FormPrepSql'
        'ConvertTo-SqlIdent'
    )
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
    PrivateData       = @{
        PSData = @{
            Tags       = @('Priority', 'FormPrep', 'DEV')
            ProjectUri = ''
        }
    }
}
