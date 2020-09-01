\# PowerShell-Workstation-Audit-Script 

\# A PowerShell script which can be copied/pasted into a PowerShell console window and retrieve auditable workstation configuration settings. This script only runs a series a queries (it does not make any modifications) and then creates a folder on the currently logged in user's desktop named after the computer name which can then be zipped and uploaded as supporting documentation.

\# PLEASE NOTE:

\# This script needs to be run as an admin on each workstation being audited seperately.

\# Search for: c:\windows\system32\windowspowershell\v1.0\powershell.exe, right click the application result and select "run as administrator".

\# Next, simply copy the entire blob of text below and paste into the PowerShell window.

New-Item -ItemType directory -Path "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit" ; Net LocalGroup Administrators | Out-File "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\1.Local_Admins.txt" ; systeminfo | Out-File "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\2.SysteminfoandUpdates.txt" ; wmic qfe list | Out-File "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\2.SysteminfoandUpdates.txt" -append ; gpresult -h "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\3.WorkstationFollowedGPOs.html" ; Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Out-File "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\4.Antivirus.txt" ; manage-bde -status | Out-File "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\5.Bitlocker.txt" ; vaultcmd /listschema | Out-File "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\6.CredentialManager.txt" ; vaultcmd /list | Out-File "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\6.CredentialManager.txt" -append ; wmic product get name,version | Out-File "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\7.InstalledSoftware.txt" ; net share | Out-File "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\8.Shares.txt" ; dir C:\Users | Out-File "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\9.UsersOnHost.txt" ; netsh advfirewall show allprofiles | Out-File "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\10.WindowsFirewall.txt" ; powercfg /A | Out-File "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\11.SleepMode.txt" ; ipconfig /all | Out-File "$($env:USERPROFILE)\Desktop\\$env:computername WS Audit\12.BridgedAdapters.txt"
