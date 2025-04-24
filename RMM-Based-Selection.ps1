$path = "C:\\temp\\$env:computername WS Audit"
New-Item -ItemType directory -Path $path


Net LocalGroup Administrators | Out-File "$path\1.Local_Admins.txt" ;

systeminfo | Out-File "$path\2.SysteminfoandUpdates.txt" ;

wmic qfe list | Out-File "$path\2.SysteminfoandUpdates.txt" -append ;

gpresult -h "$path\3.WorkstationFollowedGPOs.html" ; 

Get-CimInstance -Namespace root/SecurityCenter2 -ClassName AntivirusProduct | Out-File "$path\4.Antivirus.txt" ;

manage-bde -status | Out-File "$path\5.Bitlocker.txt" ;

vaultcmd /listschema | Out-File "$path\6.CredentialManager.txt" ;

vaultcmd /list | Out-File "$path\6.CredentialManager.txt" -append ;

wmic product get name,version | Out-File "$path\7.InstalledSoftware.txt" ;

net share | Out-File "$path\8.Shares.txt" ;

dir C:\Users | Out-File "$path\9.UsersOnHost.txt" ;

netsh advfirewall show allprofiles | Out-File "$path\10.WindowsFirewall.txt" ;

powercfg /A | Out-File "$path\11.SleepMode.txt" ;

ipconfig /all | Out-File "$path\12.BridgedAdapters.txt"

Get-WinEvent -FilterHashtable @{logname = ‘setup’} | Export-CSV "$path\13.Patches.csv"

$zipPath = "$path.zip"
Compress-Archive -Path $path -DestinationPath $zipPath