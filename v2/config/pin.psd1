# WP0 pin for v2 shell compile/install on CE Priority DEV (ce-priority-dev).
# Values are dictionary-backed — see docs/wp0-recon.md. Do not invent ENAMEs.
# Simon confirmed Medatech wrappers (ZEMG_TAKEUPGRADE / ZEMG_EXECUPGRADES)
# on 2026-09-19 Europe/London. PinComplete is true. Stock TAKEUPGRADE /
# EXECUPGRADES remain dictionary siblings, not the pinned path.
# DbiMarker left empty (not observed; do not invent).
@{
    PinComplete           = $true
    PrepareUpgradeEname   = 'ZEMG_TAKEUPGRADE'
    PrepareUpgradeType    = 'P'
    InstallUpgradeEname   = 'ZEMG_EXECUPGRADES'
    InstallUpgradeType    = 'P'
    VersionRevisionsEname = 'UPGRADES'
    RevisionInputStep     = 'PAR'
    FilePathInputStep     = 'FN'
    WcfFileStepWorks      = $null
    InstallLogTable       = 'INSTALLEDUPGRADES'
    InstallLogRevisionCol = 'UPG'
    InstallLogDateCol     = 'STARTDATE'
    DbiMarker             = ''
    InstallErrorForm      = 'EXECUPGRERR'
    ExecTitleColumn       = 'TITLE'
    # SQL dictionary pins (CE DEV system DB; see docs/wp0-recon.md). v1 config/dev.psd1 matches Exec/Lock.
    ExecTable             = 'dbo.T$EXEC'
    ExecNameCol           = 'ENAME'
    ExecIdCol             = 'T$EXEC'
    LockTable             = 'dbo.EXECPREPLOCK'
    LockCols              = @{
        ExecId   = 'T$EXEC'
        Upd      = 'UPD'
        LastPrep = 'LASTPREPDATE'
    }
    FormLimitedTable      = 'dbo.FORMLIMITED'
    FormLimitedExecCol    = 'T$EXEC'
    UpgradesDir           = 'C:\Priority\system\upgrades'
    ProofInstanceId       = 'ce-priority-dev'
    AllowedBuildSetRoots  = @('C:\Priority\system\upgrades')
}
