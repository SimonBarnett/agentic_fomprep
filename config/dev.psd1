# CE Priority DEV - Form Prep runner config.
# Frozen host/SQL/web values are also hardcoded in Get-FrozenEnvironment.ps1.
# The runner refuses to park unless this file matches those frozen values AND
# PinComplete is $true after a human has run tools/Invoke-Recon.ps1 on DEV1.
#
# Never put passwords or connection strings with passwords in this file.

@{
    Environment      = 'DEV'
    PinComplete      = $true

    WebHost          = 'prioritydev.clarksonevans.co.uk'
    WebBaseUrl       = 'https://prioritydev.clarksonevans.co.uk'

    SqlInstance      = '10.220.0.5\DEV'
    SqlDatabase      = 'system'  # dictionary DB; owns EXECPREPLOCK / T$EXEC / FORMKEYS
    SqlEncrypt       = $false    # internal SQL Server; set $true only if recon proves TLS

    ExecTable        = 'dbo.T$EXEC'  # not dbo.EXEC; ENAME + T$EXEC (bigint)
    ExecNameCol      = 'ENAME'       # nvarchar(20)
    ExecIdCol        = 'T$EXEC'      # bigint

    LockTable        = 'dbo.EXECPREPLOCK'
    LockCols         = @{
        ExecId     = 'T$EXEC'        # bigint, joins T$EXEC.T$EXEC
        Upd        = 'UPD'           # nchar; sys.max_length=2 (nchar(1))
        LastPrep   = 'LASTPREPDATE'  # bigint Priority date (0 = never)
        Computer   = 'COMPUTERNAME'  # nvarchar; sys.max_length=80
        Pid        = 'PID'           # bigint
        LockExpiry = 'LOCKEXPIRY'    # bigint
    }

    ParkTable        = 'dbo.AGENT_FORMPREP_PARK'
    FormKeysTable    = 'dbo.FORMKEYS'   # FORM bigint, NAME nvarchar(20), SEQ bigint
    FormJoinsTable   = 'dbo.FORMJOINS'  # OFORM, ONAME, TFORM, TNAME, TCOL, WEIGHT

    PriorityUser     = 'Si'
    Company          = 'base'    # SQL company DB exists; WINRUN company name kept as base
    PriorityRoot     = 'C:\Priority'
    Bin              = 'C:\Priority\bin.95'
    SystemPrep       = 'C:\Priority\system\prep'
    WinrunPath       = 'C:\Priority\bin.95\winrun.exe'
    AgentWork        = 'C:\Priority\tmp\agent-formprep'
    MutexName        = 'Global\CE-DEV-FORMPREP'
    MutexWaitMs      = 5000
    # NetBIOS COMPUTERNAME is truncated to 15 chars (CE-PRIORITY-DEV);
    # DNS/hostname is CE-PRIORITY-DEV1. Pin both so Assert-Environment matches $env:COMPUTERNAME.
    AllowedComputer  = @('CE-PRIORITY-DEV1', 'CE-PRIORITY-DEV')
    CredentialTarget = 'CE/Priority/Si'
    StorageState     = 'C:\Priority\tmp\agent-formprep\si-web-state.json'

    # Poll after CLI / web. Do not treat UI completion as success.
    SqlPollSeconds   = 5
}
