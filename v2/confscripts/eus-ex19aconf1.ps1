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

New-Item -ItemType Directory -Force -Path "C:\T\"

Write-Output `n "======================================================================================" 
Write-Output    "==============================  Install Google Chrome  ===============================" 
Write-Output    "======================================================================================" `n

$LocalTempDir = $env:TEMP; $ChromeInstaller = "ChromeInstaller.exe"; (new-object    System.Net.WebClient).DownloadFile('http://dl.google.com/chrome/install/375.126/chrome_installer.exe', "$LocalTempDir\$ChromeInstaller"); & "$LocalTempDir\$ChromeInstaller" /silent /install; $Process2Monitor =  "ChromeInstaller"; Do { $ProcessesFound = Get-Process | ?{$Process2Monitor -contains $_.Name} | Select-Object -ExpandProperty Name; If ($ProcessesFound) { "Still running: $($ProcessesFound -join ', ')" | Write-Host; Start-Sleep -Seconds 2 } else { rm "$LocalTempDir\$ChromeInstaller" -ErrorAction SilentlyContinue -Verbose } } Until (!$ProcessesFound)

Write-Output `n "======================================================================================" 
Write-Output    "================================  Preparing Exchange  ================================" 
Write-Output    "======================================================================================" `n

Write-Output `n "===========================  Windows Feature Installation  ===========================" `n

Install-WindowsFeature Server-Media-Foundation
Install-WindowsFeature NET-Framework-45-Features
Install-WindowsFeature RPC-over-HTTP-proxy
Install-WindowsFeature RSAT-Clustering
Install-WindowsFeature RSAT-Clustering-CmdInterface
Install-WindowsFeature RSAT-Clustering-Mgmt
Install-WindowsFeature RSAT-Clustering-PowerShell
Install-WindowsFeature WAS-Process-Model
Install-WindowsFeature Web-Asp-Net45
Install-WindowsFeature Web-Basic-Auth
Install-WindowsFeature Web-Client-Auth
Install-WindowsFeature Web-Digest-Auth
Install-WindowsFeature Web-Dir-Browsing
Install-WindowsFeature Web-Dyn-Compression
Install-WindowsFeature Web-Http-Errors
Install-WindowsFeature Web-Http-Logging
Install-WindowsFeature Web-Http-Redirect
Install-WindowsFeature Web-Http-Tracing
Install-WindowsFeature Web-ISAPI-Ext
Install-WindowsFeature Web-ISAPI-Filter
Install-WindowsFeature Web-Lgcy-Mgmt-Console
Install-WindowsFeature Web-Metabase
Install-WindowsFeature Web-Mgmt-Console
Install-WindowsFeature Web-Mgmt-Service
Install-WindowsFeature Web-Net-Ext45
Install-WindowsFeature Web-Request-Monitor
Install-WindowsFeature Web-Server
Install-WindowsFeature Web-Stat-Compression
Install-WindowsFeature Web-Static-Content
Install-WindowsFeature Web-Windows-Auth
Install-WindowsFeature Web-WMI
Install-WindowsFeature Windows-Identity-Foundation
Install-WindowsFeature RSAT-ADDS

Write-Output `n "======================================================================================" 
Write-Output    "===========================  Download Exchange 2019 Cu12   ===========================" 
Write-Output    "======================================================================================" `n

$URL = 'https://download.microsoft.com/download/b/c/7/bc766694-8398-4258-8e1e-ce4ddb9b3f7d/ExchangeServer2019-x64-CU12.ISO'
$Path= "C:\T\EX19-x64-CU12.iso"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)

Write-Output `n "=========================  Download Net 4.8 Installation  ============================" `n

$URL = "https://download.visualstudio.microsoft.com/download/pr/2d6bb6b2-226a-4baa-bdec-798822606ff1/8494001c276a4b96804cde7829c04d7f/ndp48-x86-x64-allos-enu.exe"
$Path= "C:\T\netfw_4-8.exe"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)

Write-Output `n "=============================  Download VCRedist 2012  ===============================" `n

$URL = "https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe"
$Path= "C:\T\vcredist2012_x64.exe"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)

Write-Output `n "=============================  Download VCRedist 2013  ===============================" `n

$URL = "https://download.microsoft.com/download/2/E/6/2E61CFA4-993B-4DD4-91DA-3737CD5CD6E3/vcredist_x64.exe"
$Path= "C:\T\vcredist2013_x64.exe"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)

Write-Output `n "==================  Download Unified Communication Installation  =====================" `n

$URL = "https://download.microsoft.com/download/2/C/4/2C47A5C1-A1F3-4843-B9FE-84C0032C61EC/UcmaRuntimeSetup.exe"
$Path= "C:\T\UcmaSetup.exe"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)

Write-Output `n "===================  Download Unified Communication Installation  ====================" `n

$URL = "https://webpihandler.azurewebsites.net/web/handlers/webpi.ashx/getinstaller/urlrewrite2.appids"
$Path= "C:\T\urlrewrite.exe"
(New-Object System.Net.WebClient).DownloadFile($URL, $Path)

Write-Output `n "==========================  Pre-requisite:  Installation  ============================" `n

Start-Process -FilePath "C:\T\vcredist2012_x64.exe" /silent -verbose
Start-Process -FilePath "C:\T\vcredist2013_x64.exe" /silent -verbose