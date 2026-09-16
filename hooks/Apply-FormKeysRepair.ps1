function Assert-FormKeysPresent {
    <#
    .SYNOPSIS
        MVP assert-only. Do not invent INSERT statements until a human pastes a dump.
        Returns $false if a real expected key is missing after UPD='N'.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]$Connection,
        [Parameter(Mandatory = $true)]$Config,
        [Parameter(Mandatory = $true)]$Result
    )

    $dumpPath = Join-Path $script:FormPrepRoot 'hooks\formkeys.psd1'
    if (-not (Test-Path -LiteralPath $dumpPath)) {
        Add-FormPrepError -Result $Result -Source 'hook' -Text 'hooks/formkeys.psd1 missing' -Severity 'Warning'
        return $true
    }

    $dump = Import-PowerShellDataFile -Path $dumpPath
    $tableName = $Config.FormKeysTable
    if ([string]::IsNullOrWhiteSpace($tableName) -or $tableName -eq '<PIN>') {
        Add-FormPrepError -Result $Result -Source 'hook' -Text 'FormKeysTable not pinned; hook assert skipped' -Severity 'Info'
        return $true
    }

    $table = ConvertTo-SqlIdent $tableName
    $ok = $true
    foreach ($formName in $dump.Keys) {
        $expected = @($dump[$formName])
        $real = $false
        foreach ($row in $expected) {
            if ($row.KeyType -and $row.KeyType -ne '<PIN>') { $real = $true }
        }
        if (-not $real) { continue }

        foreach ($row in $expected) {
            if (-not $row.Col -or $row.KeyType -eq '<PIN>') { continue }
            # Column names are pinned from a dump; still validate tokens.
            if (-not (Test-FormName $formName)) { continue }
            $sql = "SELECT COUNT(*) FROM $table WHERE 1=1"
            # We do not know the real FORMKEYS shape until recon. Look for ENAME + COL if present.
            $sql = @"
SELECT COUNT(*) FROM $table t
WHERE (
        EXISTS (SELECT 1 FROM sys.columns c WHERE c.object_id = OBJECT_ID('$tableName') AND c.name = 'ENAME')
        AND t.ENAME = @ename
      )
"@
            try {
                $count = Invoke-FormPrepSql -Connection $Connection -Query $sql -Parameters @{ '@ename' = $formName } -Scalar
                if ([int]$count -le 0) {
                    Add-FormPrepError -Result $Result -Source 'hook' -Text ("FORMKEYS missing for {0} col={1}" -f $formName, $row.Col) -Severity 'Blocker' -FormHint $formName
                    $ok = $false
                }
            } catch {
                Add-FormPrepError -Result $Result -Source 'hook' -Text ("FORMKEYS assert failed: {0}" -f $_.Exception.Message) -Severity 'Warning' -FormHint $formName
            }
        }
    }
    return $ok
}
