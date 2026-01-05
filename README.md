\# PowerShell-Workstation-Audit-Script 

\# A PowerShell script which can be copied/pasted into a PowerShell console window and retrieve auditable workstation configuration settings. This script only runs a series a queries (it does not make any modifications) and then creates a folder on the currently logged in user's desktop named after the computer name which can then be zipped and uploaded as supporting documentation.

\# PLEASE NOTE:

\# This script needs to be run as an admin on each workstation being audited seperately.

\# Search for: c:\windows\system32\windowspowershell\v1.0\powershell.exe, right click the application result and select "run as administrator".

\# Next, simply copy the entire blob of text below and paste into the PowerShell window.

```
$path = "C:\\temp\\$env:computername WS Audit"
New-Item -ItemType directory -Path $path

Net LocalGroup Administrators | Out-File "$path\1.Local_Admins.txt" ;

systeminfo | Out-File "$path\2.SysteminfoandUpdates.txt" ;

Get-HotFix | Format-table -property Caption, HotFixID, InstalledOn | Out-File "$path\2.SysteminfoandUpdates.txt" -append ;

gpresult -h "$path\3.WorkstationFollowedGPOs.html" ; 

Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Out-File "$path\4.Antivirus.txt" ;

manage-bde -status | Out-File "$path\5.Bitlocker.txt" ;

vaultcmd /listschema | Out-File "$path\6.CredentialManager.txt" ;

vaultcmd /list | Out-File "$path\6.CredentialManager.txt" -append ;

Get-CimInstance -ClassName Win32_Product | Select-Object Name, Version | Out-File "$path\7.InstalledSoftware.txt" ;

net share | Out-File "$path\8.Shares.txt" ;

dir C:\Users | Out-File "$path\9.UsersOnHost.txt" ;

netsh advfirewall show allprofiles | Out-File "$path\10.WindowsFirewall.txt" ;

powercfg /A | Out-File "$path\11.SleepMode.txt" ;

ipconfig /all | Out-File "$path\12.BridgedAdapters.txt"

Get-WinEvent -FilterHashtable @{logname = ‘setup’} | Export-CSV "$path\13.Patches.csv"

$zipPath = "$path.zip"
Compress-Archive -Path $path -DestinationPath $zipPath
```
