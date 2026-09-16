# CE Priority DEV - Form Prep runner config.
# Frozen host/SQL/web values are also hardcoded in Get-FrozenEnvironment.ps1.
# The runner refuses to park unless this file matches those frozen values AND
# PinComplete is $true after a human has run tools/Invoke-Recon.ps1 on DEV1.
#
# Never put passwords or connection strings with passwords in this file.

@{
    Environment      = 'DEV'
    PinComplete      = $false

    WebHost          = 'prioritydev.clarksonevans.co.uk'
    WebBaseUrl       = 'https://prioritydev.clarksonevans.co.uk'

    SqlInstance      = '10.220.0.5\DEV'
    SqlDatabase      = '<PIN>'   # company DB that owns EXECPREPLOCK; recon must fill this
    SqlEncrypt       = $false    # internal SQL Server; set $true only if recon proves TLS

    ExecTable        = '<PIN>'   # e.g. dbo.EXEC or dbo.TSEXEC
    ExecNameCol      = 'ENAME'
    ExecIdCol        = 'EXEC'

    LockTable        = 'dbo.EXECPREPLOCK'
    LockCols         = @{
        ExecId     = 'EXEC'
        Upd        = 'UPD'
        LastPrep   = 'LASTPREPDATE'
        Computer   = 'COMPUTERNAME'
        Pid        = 'PID'
        LockExpiry = 'LOCKEXPIRY'
    }

    ParkTable        = 'dbo.AGENT_FORMPREP_PARK'
    FormKeysTable    = '<PIN>'   # e.g. dbo.FORMKEYS; leave <PIN> for assert-skip
    FormJoinsTable   = '<PIN>'

    PriorityUser     = 'Si'
    Company          = 'base'    # confirm at recon; log actual
    PriorityRoot     = 'C:\Priority'
    Bin              = 'C:\Priority\bin.95'
    SystemPrep       = 'C:\Priority\system\prep'
    WinrunPath       = 'C:\Priority\bin.95\winrun.exe'
    AgentWork        = 'C:\Priority\tmp\agent-formprep'
    MutexName        = 'Global\CE-DEV-FORMPREP'
    MutexWaitMs      = 5000
    AllowedComputer  = @('CE-PRIORITY-DEV1')
    CredentialTarget = 'CE/Priority/Si'
    StorageState     = 'C:\Priority\tmp\agent-formprep\si-web-state.json'

    # Poll after CLI / web. Do not treat UI completion as success.
    SqlPollSeconds   = 5
}
