# AT6: fake SQL / web. Must be refused before any park row is written.
@{
    Environment      = 'DEV'
    PinComplete      = $true
    WebHost          = 'example.invalid'
    WebBaseUrl       = 'https://example.invalid'
    SqlInstance      = '127.0.0.1\FAKE'
    SqlDatabase      = 'nope'
    SqlEncrypt       = $false
    ExecTable        = 'dbo.EXEC'
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
    FormKeysTable    = 'dbo.FORMKEYS'
    FormJoinsTable   = 'dbo.FORMJOINS'
    PriorityUser     = 'Si'
    Company          = 'base'
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
    SqlPollSeconds   = 5
}
