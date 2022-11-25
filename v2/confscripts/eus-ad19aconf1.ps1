Write-Output `n "======================================================================================" 
Write-Output    "=============================== Enable Ping Echo IPv4 ================================" 
Write-Output    "======================================================================================" `n

netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol="icmpv4:8,any" dir=in action=allow

Write-Output `n "======================================================================================" 
Write-Output    "===============================  Disable  IPv6 VMAD01 ================================" 
Write-Output    "======================================================================================" `n

# Disable IPv6 on Ethernet Adapter
Get-NetAdapterBinding -ComponentID ms_tcpip6
Disable-NetAdapterBinding -Name "Ethernet" -ComponentID ms_tcpip6

Write-Output `n "======================================================================================" 
Write-Output    "==============================  Create DB&LOG NTDS AD  ===============================" 
Write-Output    "======================================================================================" `n

New-Item -ItemType Directory -Force -Path C:\AD\DBNTDS\
New-Item -ItemType Directory -Force -Path C:\AD\LOGNTDS\
New-Item -ItemType Directory -Force -Path C:\AD\SYSVOL\

Write-Output `n "======================================================================================" 
Write-Output    "==============================  Install Google Chrome  ===============================" 
Write-Output    "======================================================================================" `n

$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)

Write-Output `n "======================================================================================" 
Write-Output    "================================  Configure AD & DNS  ================================" 
Write-Output    "======================================================================================" `n


Invoke-WebRequest -Uri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/confscripts/eus-ad19aconf.xml" -OutFile 'C:\Users\rian\Downloads\addns.xml'
Install-WindowsFeature -ConfigurationFilePath 'C:\Users\rian\Downloads\addns.xml'

Write-Output `n "======================================================================================" 
Write-Output    "================================  Install Powershell  ================================" 
Write-Output    "======================================================================================" `n

Install-PackageProvider -Name NuGet -Force

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine
Register-PSRepository -Default

$URL = "https://github.com/PowerShell/PowerShell/releases/download/v7.3.0/PowerShell-7.3.0-win-x64.msi"
$Path= "C:\Users\rian\Downloads\ps7.3.msi"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)
cd "C:\Users\rian\Downloads\"
msiexec.exe /package ps7.3.msi /quiet /l* logps7.3.txt ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 USE_MU=1 ENABLE_MU=1 ADD_PATH=1

$URL = "https://download.microsoft.com/download/1/8/D/18DC8184-E7E2-45EF-823F-F8A36B9FF240/StorageSyncAgent_WS2019.msi"
$Path= "C:\Users\rian\Downloads\fs2019.msi"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/confscripts/eus-ad19aconf2.ps1" -OutFile 'C:\Users\rian\Downloads\eus-ad19aconf2.ps1'
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/confscripts/eus-ad19aconf3.ps1" -OutFile 'C:\Users\rian\Downloads\eus-ad19aconf3.ps1'
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/confscripts/eus-ad19aconf4.ps1" -OutFile 'C:\Users\rian\Downloads\eus-ad19aconf4.ps1'