function Get-WinrunCredential {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][string]$Target
    )

    if (-not ([System.Management.Automation.PSTypeName]'NativeCredRead').Type) {
        $sig = @"
using System;
using System.Runtime.InteropServices;
public static class NativeCredRead {
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
  public static extern bool CredRead(string target, uint type, uint flags, out IntPtr cred);
  [DllImport("advapi32.dll", SetLastError=true)]
  public static extern void CredFree(IntPtr cred);
}
"@
        Add-Type -TypeDefinition $sig -ErrorAction Stop
    }

    $ptr = [IntPtr]::Zero
    if (-not [NativeCredRead]::CredRead($Target, 1, 0, [ref]$ptr)) {
        return $null
    }
    try {
        $cred = [System.Runtime.InteropServices.Marshal]::PtrToStructure($ptr, [type][NativeCredRead+CREDENTIAL])
        $pass = $null
        if ($cred.CredentialBlob -ne [IntPtr]::Zero -and $cred.CredentialBlobSize -gt 0) {
            $pass = [System.Runtime.InteropServices.Marshal]::PtrToStringUni($cred.CredentialBlob, [int]($cred.CredentialBlobSize / 2))
        }
        return [pscustomobject]@{
            UserName = $cred.UserName
            Password = $pass
        }
    } finally {
        [NativeCredRead]::CredFree($ptr)
    }
}
