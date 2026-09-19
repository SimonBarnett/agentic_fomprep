# Priority upgrade-shell parser (skeleton text format).
# Modification codes below are the public Version Revision step codes
# (Priority Developer Portal: Installing Customizations), not procedure ENAMEs.
# Real on-disk .sh layout is a WP0 pin (DbiMarker / recon). Do not guess procs.

$script:PriorityModCodes = @(
    'DBI',
    'DELDIRECTACT', 'DELFORMCOL', 'DELFORMLINK', 'DELMENULINK',
    'DELPACKENT', 'DELPACKEXEC', 'DELPROCMSG', 'DELPROCSTEP',
    'DELREPCOL', 'DELTRIG', 'DELTRIGMSG', 'DELWORDTMPL',
    'TAKEDIRECTACT', 'TAKEENTHEADER', 'TAKEEXTMSG', 'TAKEFORMCOL',
    'TAKEFORMLINK', 'TAKEMENULINK', 'TAKEOUTPUTTITLE',
    'TAKEPACKENT', 'TAKEPACKEXEC', 'TAKEPACKTITLE',
    'TAKEPROCMSG', 'TAKEPROCSTEP', 'TAKEREPCOL',
    'TAKESINGLEENT', 'TAKETRIG', 'TAKETRIGMSG', 'TAKEWORDTMPL', 'TAKEHELP'
)

function Get-PriorityModCodeSet {
    $set = @{}
    foreach ($c in $script:PriorityModCodes) { $set[$c] = $true }
    return $set
}

function ConvertTo-ShellRevisionToken {
    param([string]$Value)
    if ([string]::IsNullOrWhiteSpace($Value)) { return $null }
    $t = $Value.Trim()
    if ($t -match '^[0-9]+$') { return $t }
    if ($t -match '^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$') { return $t }
    return $null
}

function ConvertTo-ShellEntityToken {
    param([string]$Value)
    if ([string]::IsNullOrWhiteSpace($Value)) { return $null }
    $t = $Value.Trim().Trim("'").Trim('"')
    if ($t -match '^[A-Za-z][A-Za-z0-9_]*$') { return $t }
    return $null
}

function Get-RevisionFromShellName {
    param([string]$Path)
    if ([string]::IsNullOrWhiteSpace($Path)) { return $null }
    $base = [IO.Path]::GetFileNameWithoutExtension($Path)
    if ($base -match '^(\d+)$') { return $Matches[1] }
    if ($base -match '^(\d+)-') { return $Matches[1] }
    return $null
}

function Read-PriorityShell {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [string]$DbiMarker
    )
    $failed = {
        param([string]$Text)
        return [pscustomobject]@{
            ok             = $false
            reason         = 'parse_failed'
            revision       = $null
            title          = $null
            codes          = @()
            entities       = @()
            takesingleent  = @()
            dbi            = $false
            text           = $Text
            bytes          = 0
            path           = $Path
        }
    }

    if (-not (Test-Path -LiteralPath $Path)) {
        return & $failed 'shell file not found'
    }
    $item = Get-Item -LiteralPath $Path
    if ($item.Length -lt 1) {
        return & $failed 'shell file is empty'
    }

    $bytes = [int]$item.Length
    $raw = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
    if ([string]::IsNullOrWhiteSpace($raw)) {
        return & $failed 'shell file has no text'
    }

    $codeSet = Get-PriorityModCodeSet
    $dbiToken = 'DBI'
    if (-not [string]::IsNullOrWhiteSpace($DbiMarker)) { $dbiToken = $DbiMarker.Trim() }

    $revision = $null
    $title = $null
    $hasMagic = $false
    $codes = @()
    $entities = @()
    $takes = @()
    $dbi = $false
    $pendingCode = $null

    foreach ($line in ($raw -split '\r?\n')) {
        $trim = $line.Trim()
        if ($trim.Length -eq 0) { continue }
        if ($trim.StartsWith('#')) { continue }
        if ($trim -eq 'END') { continue }

        if ($trim -match '^(?i)PRIORITY_SHELL(\s+\S+)?$') {
            $hasMagic = $true
            continue
        }
        if ($trim -match '^(?i)REVISION\s*[=:]\s*(\S+)\s*$' -or $trim -match '^(?i)REVISION\s+(\S+)\s*$') {
            $revision = ConvertTo-ShellRevisionToken $Matches[1]
            continue
        }
        if ($trim -match '^(?i)TITLE\s*[=:]\s*(.+)$' -or $trim -match '^(?i)TITLE\s+(.+)$') {
            $title = $Matches[1].Trim()
            continue
        }

        $code = $null
        $entity = $null
        if ($trim -match '^(?i)CODE\s+(\S+)(?:\s+(\S+))?\s*$') {
            $code = $Matches[1]
            if ($Matches.Count -ge 3) { $entity = $Matches[2] }
        } elseif ($trim -match '^(?i)(TAKESINGLEENT|TAKE[A-Z]+|DEL[A-Z]+|DBI)(?:\s+(\S+))?\s*$') {
            $code = $Matches[1]
            if ($Matches.Count -ge 3) { $entity = $Matches[2] }
        }

        if ($code -and $codeSet.ContainsKey($code)) {
            $pendingCode = $null
            $canon = $script:PriorityModCodes | Where-Object { $_ -eq $code } | Select-Object -First 1
            if (-not $canon) { $canon = ([string]$code).ToUpperInvariant() }
            if ($codes -notcontains $canon) { $codes += $canon }
            if (([string]$canon).ToUpperInvariant() -eq $dbiToken.ToUpperInvariant() -or $canon -eq 'DBI') {
                $dbi = $true
            }
            $entTok = ConvertTo-ShellEntityToken $entity
            if ($entTok) {
                $entities += ,[pscustomobject]@{ code = $canon; name = $entTok }
                if ($canon -eq 'TAKESINGLEENT' -and $takes -notcontains $entTok) {
                    $takes += $entTok
                }
            } elseif ($canon -eq 'TAKESINGLEENT') {
                $pendingCode = $canon
            }
            continue
        }

        if ($pendingCode) {
            $entTok = ConvertTo-ShellEntityToken $trim
            if ($entTok) {
                $entities += ,[pscustomobject]@{ code = $pendingCode; name = $entTok }
                if ($pendingCode -eq 'TAKESINGLEENT' -and $takes -notcontains $entTok) {
                    $takes += $entTok
                }
                $pendingCode = $null
                continue
            }
            $pendingCode = $null
        }
    }

    if (-not $revision) {
        $revision = Get-RevisionFromShellName -Path $Path
    }

    $ok = $hasMagic -or ($revision -and $codes.Count -gt 0)
    if (-not $ok) {
        return & $failed 'not a Priority shell (need PRIORITY_SHELL header or REVISION plus a known modification code)'
    }
    if (-not $revision) {
        return & $failed 'shell has no revision'
    }
    if ($codes.Count -lt 1) {
        return & $failed 'shell has no modification codes'
    }

    return [pscustomobject]@{
        ok            = $true
        reason        = $null
        revision      = $revision
        title         = $title
        codes         = @($codes)
        entities      = @($entities)
        takesingleent = @($takes)
        dbi           = [bool]$dbi
        text          = $null
        bytes         = $bytes
        path          = $Path
    }
}
