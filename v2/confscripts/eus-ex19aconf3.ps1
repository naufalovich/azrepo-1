Write-Output `n "======================================================================================" 
Write-Output `n "==========================  Pre-requisite:  Installation  ============================" `n
Write-Output    "======================================================================================" `n

Start-Process -FilePath "C:\T\netfw_4-8.exe" -verbose
$confirmation = Read-Host "Udah selesai installnya? [pencet enter kalo udah]"

Start-Process -FilePath "C:\T\UcmaSetup.exe" -verbose
$confirmation = Read-Host "Udah selesai installnya? [pencet enter kalo udah]"

Start-Process -FilePath "C:\T\rewrite21.msi" -verbose
$confirmation = Read-Host "Udah selesai installnya? [pencet enter kalo udah]"

Write-Output `n "======================================================================================" 
Write-Output    "=============================  Mount Exchange 2019 Cu12  =============================" 
Write-Output    "======================================================================================" `n

Mount-DiskImage -ImagePath 'C:\T\EX19-X64-CU12.ISO'

Write-Output `n "=========================  Exchange Inst.  Prepare Schema  =========================" `n

cd E:\
.\Setup.exe /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF /PrepareSchema

Write-Output `n "===========================  Exchange Inst. Prepare AD  ============================" `n

.\Setup.exe /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF /PrepareAD /OrganizationName: "MINILICO"

Write-Output `n "========================  Exchange Inst. Prepare Domains  ==========================" `n

.\Setup.exe /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF /PrepareAllDomains

Write-Output `n "=============================  Exchange Version List  ==============================" `n

# Exchange Schema Version
$sc = (Get-ADRootDSE).SchemaNamingContext
$ob = "CN=ms-Exch-Schema-Version-Pt," + $sc
Write-Output "RangeUpper: $((Get-ADObject $ob -pr rangeUpper).rangeUpper)"
 
# Exchange Object Version (domain)
$dc = (Get-ADRootDSE).DefaultNamingContext
$ob = "CN=Microsoft Exchange System Objects," + $dc
Write-Output "ObjectVersion (Default): $((Get-ADObject $ob -pr objectVersion).objectVersion)"
 
# Exchange Object Version (forest)
$cc = (Get-ADRootDSE).ConfigurationNamingContext
$fl = "(objectClass=msExchOrganizationContainer)"
Write-Output "ObjectVersion (Configuration): $((Get-ADObject -LDAPFilter $fl -SearchBase $cc -pr objectVersion).objectVersion)"

Write-Output `n "===============================  Run Installation  ================================" `n

cd E:\
.\Setup.exe 

Write-Output `n "=================================  Add License  ===================================" `n

Set-ExchangeServer "EX01-2016" -ProductKey XXXXX-XXXXX-XXXXX-XXXXX

Write-Output `n "===============================  Restart Service  =================================" `n

net stop "Microsoft Exchange Information Store"
net start "Microsoft Exchange Information Store"

Write-Output `n "===============================  EXCHANGE  MODULE  =================================" `n
Write-Output `n "=================================  Check License  ==================================" `n


Get-ExchangeServer | ft Name,Edition,ProductID,IsExchangeTrialEdition -Auto

Get-MailboxDatabase
Set-MailboxDatabase "Mailbox Database 0082421626" -Name "DB01"
New-SendConnector -Name "Internet email PS" -Usage "Internet" -SourceTransportServers "VMEX19A" -DNSRoutingEnabled $True -AddressSpaces ("SMTP:*;5") -IsScopedConnector $False -UseExternalDNSServersEnabled $false
Get-SendConnector | Format-Table Identity, AddressSpaces, SourceTransportServers, MaxMessageSize, Enabled

Write-Output `n "===============================  EXCHANGE  MODULE  =================================" `n
Write-Output `n "==========================  Configure Internal External  ===========================" `n

Get-ClientAccessServer -Identity VMEX19A | Set-ClientAccessServer –AutoDiscoverServiceInternalUri https://autodiscover.minilico.xyz/Autodiscover/Autodiscover.xml
Get-ClientAccessService -Identity VMEX19A | Format-List Identity, AutoDiscoverServiceInternalUri

Get-EcpVirtualDirectory -Server VMEX19A | Set-EcpVirtualDirectory -ExternalUrl https://mail.minilico.xyz/ecp -InternalUrl https://mail.minilico.xyz/ecp
Get-EcpVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-WebServicesVirtualDirectory -Server VMEX19A | Set-WebServicesVirtualDirectory -ExternalUrl https://mail.minilico.xyz/EWS/Exchange.asmx -InternalUrl https://mail.minilico.xyz/EWS/Exchange.asmx
Get-WebServicesVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-MapiVirtualDirectory -Server VMEX19A | Set-MapiVirtualDirectory -ExternalUrl https://mail.minilico.xyz/mapi -InternalUrl https://mail.minilico.xyz/mapi
Get-MapiVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-ActiveSyncVirtualDirectory -Server VMEX19A | Set-ActiveSyncVirtualDirectory -ExternalUrl https://mail.minilico.xyz/Microsoft-Server-ActiveSync -InternalUrl https://mail.minilico.xyz/Microsoft-Server-ActiveSync
Get-ActiveSyncVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-OabVirtualDirectory -Server VMEX19A | Set-OabVirtualDirectory -ExternalUrl https://mail.minilico.xyz/OAB -InternalUrl https://mail.minilico.xyz/OAB
Get-OabVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-OwaVirtualDirectory -Server VMEX19A | Set-OwaVirtualDirectory -ExternalUrl https://mail.minilico.xyz/owa -InternalUrl https://mail.minilico.xyz/owa
Get-OwaVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-PowerShellVirtualDirectory -Server VMEX19A | Set-PowerShellVirtualDirectory -ExternalUrl https://mail.minilico.xyz/powershell -InternalUrl https://mail.minilico.xyz/powershell
Get-PowerShellVirtualDirectory -Server VMEX19A | Format-List InternalUrl, ExternalUrl

Get-OutlookAnywhere -Server VMEX19A | Set-OutlookAnywhere -ExternalHostname mail.minilico.xyz -InternalHostname mail.minilico.xyz -ExternalClientsRequireSsl $true -InternalClientsRequireSsl $true -DefaultAuthenticationMethod NTLM
Get-OutlookAnywhere -Server VMEX19A | Format-List ExternalHostname, InternalHostname

Resolve-DnsName -Type MX minilico.xyz -Server 8.8.8.8 | Format-Table -AutoSize

Get-AntiPhishPolicy -Identity '*TN*' | Select-Object Name,WhenCreated,OrganizationalUnitRoot,Identity,DistinguishedName
Get-HostedContentFilterPolicy -Identity '*TN*' | Select-Object Name,WhenCreated,OrganizationalUnitRoot,Identity,DistinguishedName
Get-MalwareFilterPolicy -Identity '*TN*' | Select-Object Name,WhenCreated,OrganizationalUnitRoot,Identity,DistinguishedName