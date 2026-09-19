function Get-InstancesFile {
    param([string]$Path)
    if ($Path) { return $Path }
    if ($env:PRIORITY_FORMPREP_INSTANCES) { return $env:PRIORITY_FORMPREP_INSTANCES }
    return Join-Path $env:USERPROFILE '.priority-formprep\instances.json'
}

function Read-Allowlist {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        return @{ ok = $false; reason = 'no_instances_file'; path = $Path }
    }
    $raw = Get-Content -LiteralPath $Path -Raw -Encoding UTF8 | ConvertFrom-Json
    $list = @($raw.instances)
    if ($list.Count -lt 1) {
        return @{ ok = $false; reason = 'no_instances'; path = $Path }
    }
    return @{ ok = $true; path = $Path; instances = $list }
}

function Test-LiveRefused {
    param($Instance)
    if ($Instance.allowLive -eq $true) { return $false }
    $bits = @($Instance.id, $Instance.title, $Instance.company) | ForEach-Object { [string]$_ }
    $blob = ($bits -join ' ')
    if ($blob -match '(?i)\blive\b') { return $true }
    if ([string]$Instance.id -match '(?i)(^|-)pri$' -or [string]$Instance.company -match '(?i)^pri$') { return $true }
    return $false
}

function Select-AllowlistedInstance {
    param($Allow, [string]$InstanceId)
    if (-not $Allow.ok) {
        return @{ ok = $false; reason = $Allow.reason; path = $Allow.path }
    }
    if ($InstanceId) {
        $pick = @($Allow.instances | Where-Object { $_.id -eq $InstanceId } | Select-Object -First 1)
        if (-not $pick) {
            return @{ ok = $false; reason = 'instance_unknown'; instanceId = $InstanceId }
        }
        return @{ ok = $true; instance = $pick }
    }
    if ($Allow.instances.Count -eq 1) {
        return @{ ok = $true; instance = $Allow.instances[0] }
    }
    return @{
        ok          = $false
        reason      = 'instance_required'
        instanceIds = @($Allow.instances | ForEach-Object { $_.id })
    }
}
