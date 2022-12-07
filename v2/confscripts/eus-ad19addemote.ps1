#
# Windows PowerShell script for AD DS Deployment
#

Import-Module ADDSDeployment
Uninstall-ADDSDomainController `
-DemoteOperationMasterRole:$true `
-IgnoreLastDnsServerForZone:$true `
-LastDomainControllerInDomain:$true `
-RemoveDnsDelegation:$true `
-RemoveApplicationPartitions:$true `
-Force:$true