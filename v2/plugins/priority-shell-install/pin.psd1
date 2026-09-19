# WP0 pin for v2 shell compile/install. PinComplete stays false until a human
# reads recon (docs/wp0-recon.md) and fills every required field. Empty is
# correct for this skeleton. Do not guess Prepare Upgrade / Install Upgrade ENAMEs.
@{
    PinComplete           = $false
    PrepareUpgradeEname   = ''
    PrepareUpgradeType    = ''
    InstallUpgradeEname   = ''
    InstallUpgradeType    = ''
    VersionRevisionsEname = ''
    RevisionInputStep     = ''
    FilePathInputStep     = ''
    WcfFileStepWorks      = $null
    InstallLogTable       = ''
    InstallLogRevisionCol = ''
    InstallLogDateCol     = ''
    DbiMarker             = ''
    InstallErrorForm      = ''
    ExecTitleColumn       = ''
    UpgradesDir           = ''
    ProofInstanceId       = ''
    AllowedBuildSetRoots  = @()
}
