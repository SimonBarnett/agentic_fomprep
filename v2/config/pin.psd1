# WP0 pin for v2 shell compile/install on CE Priority DEV (ce-priority-dev).
# Values are dictionary-backed — see docs/wp0-recon.md. Do not invent ENAMEs.
# PinComplete stays false until Simon confirms Medatech wrappers
# (ZEMG_TAKEUPGRADE / ZEMG_EXECUPGRADES) vs stock TAKEUPGRADE / EXECUPGRADES
# for the WP0 walker. DbiMarker left empty (not observed; do not invent).
@{
    PinComplete           = $false
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
    UpgradesDir           = 'C:\Priority\system\upgrades'
    ProofInstanceId       = 'ce-priority-dev'
    AllowedBuildSetRoots  = @('C:\Priority\system\upgrades')
}
