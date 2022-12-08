Write-Output `n "======================================================================================" 
Write-Output    "==================================  Promote VMAD01  ==================================" 
Write-Output    "======================================================================================" `n
 
Write-Output    "=================================== Skip this first =================================="

#Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
#Install-Module ADDSDeployment

Write-Output    "========================= If these failed, include above ============================="

Import-Module ADDSDeployment
$passAd = ConvertTo-SecureString "Jakarta@2022" -AsPlainText -Force
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\AD\DBNTDS" `
-DomainMode "WinThreshold" `
-DomainName "minilico.xyz" `
-DomainNetbiosName "AD" `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\AD\LOGNTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\AD\SYSVOL" `
-Force:$true `
-SafeModeAdministratorPassword $passAd

