function Get-FrozenEnvironment {
    <#
    .SYNOPSIS
        Fail-closed constants for CE Priority DEV. Config may pin table names, not hosts.
    #>
    [CmdletBinding()]
    param()

    return [pscustomobject]@{
        Environment     = 'DEV'
        WebHost         = 'prioritydev.clarksonevans.co.uk'
        SqlInstance     = '10.220.0.5\DEV'
        PriorityRoot    = 'C:\Priority'
        Bin             = 'C:\Priority\bin.95'
        SystemPrep      = 'C:\Priority\system\prep'
        MutexName       = 'Global\CE-DEV-FORMPREP'
        AllowedComputer = @('CE-PRIORITY-DEV1')
        AgentWork       = 'C:\Priority\tmp\agent-formprep'
    }
}
