#requires -Version 5.1
<#
.SYNOPSIS
    Store the Si WINRUN password in Windows Credential Manager (target CE/Priority/Si).
    Password is prompted; it is never written to git, JSON, or this repo.

    This file is unsigned. Run:
      powershell -NoProfile -ExecutionPolicy Bypass -File tools\Set-WinrunCredential.ps1
#>
[CmdletBinding()]
param(
    [string]$Target = 'CE/Priority/Si',
    [string]$UserName = 'Si'
)

$ErrorActionPreference = 'Stop'
$sec = Read-Host -AsSecureString "Password for $UserName (WINRUN, not SQL)"
$bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec)
try {
    $plain = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
} finally {
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
}

if (-not ([System.Management.Automation.PSTypeName]'NativeCredWrite').Type) {
    Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class NativeCredWrite {
  [StructLayout(LayoutKind.Sequential, CharSet=CharSet.Unicode)]
  public struct CREDENTIAL {
    public uint Flags;
    public uint Type;
    public string TargetName;
    public string Comment;
    public System.Runtime.InteropServices.ComTypes.FILETIME LastWritten;
    public uint CredentialBlobSize;
    public IntPtr CredentialBlob;
    public uint Persist;
    public uint AttributeCount;
    public IntPtr Attributes;
    public string TargetAlias;
    public string UserName;
  }
  [DllImport("advapi32.dll", CharSet=CharSet.Unicode, SetLastError=true)]
  public static extern bool CredWrite(ref CREDENTIAL userCredential, uint flags);
}
"@
}

$bytes = [System.Text.Encoding]::Unicode.GetBytes($plain)
$gch = [System.Runtime.InteropServices.GCHandle]::Alloc($bytes, 'Pinned')
try {
    $cred = New-Object NativeCredWrite+CREDENTIAL
    $cred.Type = 1
    $cred.TargetName = $Target
    $cred.UserName = $UserName
    $cred.CredentialBlobSize = [uint32]$bytes.Length
    $cred.CredentialBlob = $gch.AddrOfPinnedObject()
    $cred.Persist = 2 # LOCAL_MACHINE
    $ok = [NativeCredWrite]::CredWrite([ref]$cred, 0)
    if (-not $ok) { throw "CredWrite failed Win32=$([Runtime.InteropServices.Marshal]::GetLastWin32Error())" }
} finally {
    $gch.Free()
    $plain = $null
    $bytes = $null
}
Write-Host "Stored generic credential target '$Target' user '$UserName'."
