Write-Output `n "======================================================================================" 
Write-Output    "==================================  Promote VMAD01  ==================================" 
Write-Output    "======================================================================================" `n
 
Write-Output    "=================================== Skip this first =================================="

#Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
#Install-Module ADDSDeployment

Write-Output    "========================= If these failed, include above ============================="

Import-Module ADDSDeployment
$passAd = ConvertTo-SecureString "Jakarta@2022" -AsPlainText -Force
Install-ADDSDomain `
-NoGlobalCatalog:$false `
-CreateDnsDelegation:$true `
-DatabasePath "C:\AD\DBNTDS" `
-DomainMode "WinThreshold" `
-DomainType "ChildDomain" `
-InstallDns:$true `
-LogPath "C:\AD\LOGNTDS" `
-NewDomainName "id" `
-NewDomainNetbiosName "ID" `
-ParentDomainName "minilico.xyz" `
-NoRebootOnCompletion:$false `
-SiteName "Default-First-Site-Name" `
-SysvolPath "C:\AD\SYSVOL" `
-Force:$true `
-SafeModeAdministratorPassword $passAd