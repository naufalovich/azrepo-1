Write-Output `n "======================================================================================" 
Write-Output    "================================   Allow RDP to Pbl   ================================" 
Write-Output    "======================================================================================" `n

$nsg = 'eus-nsgpbl'
$dsc = 'allow RDP from public'
$acc = 'allow'
$ptc = 'TCP'
$drc = 'Inbound'
$pty = 100
$sap = (Invoke-WebRequest -uri "https://ipinfo.io/ip").Content
$spr = '*'
$dap = '*'
$dpr = 3389
$nsg = Get-AzNetworkSecurityGroup -Name $nsg

$ruleexists = (Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg).Name.Contains($dsc);

if($ruleexists)
{
	# Update the existing rule with the new IP address
	Set-AzNetworkSecurityRuleConfig `
		-Name $dsc `
		-Description $dsc `
		-Access $acc `
		-Protocol $ptc `
		-Direction $drc `
		-Priority $pty `
		-SourceAddressPrefix $sap `
		-SourcePortRange $spr `
		-DestinationAddressPrefix $dap `
		-DestinationPortRange $dpr `
		-NetworkSecurityGroup $nsg
}
else
{
	# Create a new rule
	$nsg | Add-AzNetworkSecurityRuleConfig `
		-Name $dsc `
		-Description $dsc `
		-Access $acc `
		-Protocol $ptc `
		-Direction $drc `
		-Priority $pty `
		-SourceAddressPrefix $sap `
		-SourcePortRange $spr `
		-DestinationAddressPrefix $dap `
		-DestinationPortRange $dpr
}

# Save changes to the NSG
$nsg | Set-AzNetworkSecurityGroup

Write-Output `n "======================================================================================" 
Write-Output    "================================   Allow RDP to Pvt   ================================" 
Write-Output    "======================================================================================" `n

$nsg = 'eus-nsgpvt'
$dsc = 'allow RDP from nsgpbl'
$acc = 'allow'
$ptc = 'TCP'
$drc = 'Inbound'
$pty = 100
$sap = (Invoke-WebRequest -uri "https://ipinfo.io/ip").Content
$spr = '*'
$dap = '*'
$dpr = 3389
$nsg = Get-AzNetworkSecurityGroup -Name $nsg

$ruleexists = (Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg).Name.Contains($dsc);

if($ruleexists)
{
	# Update the existing rule with the new IP address
	Set-AzNetworkSecurityRuleConfig `
		-Name $dsc `
		-Description $dsc `
		-Access $acc `
		-Protocol $ptc `
		-Direction $drc `
		-Priority $pty `
		-SourceAddressPrefix $sap `
		-SourcePortRange $spr `
		-DestinationAddressPrefix $dap `
		-DestinationPortRange $dpr `
		-NetworkSecurityGroup $nsg
}
else
{
	# Create a new rule
	$nsg | Add-AzNetworkSecurityRuleConfig `
		-Name $dsc `
		-Description $dsc `
		-Access $acc `
		-Protocol $ptc `
		-Direction $drc `
		-Priority $pty `
		-SourceAddressPrefix $sap `
		-SourcePortRange $spr `
		-DestinationAddressPrefix $dap `
		-DestinationPortRange $dpr
}

# Save changes to the NSG
$nsg | Set-AzNetworkSecurityGroup

Write-Output `n "======================================================================================" 
Write-Output    "===============================   Allow RDP from SEA   ===============================" 
Write-Output    "======================================================================================" `n

$nsg = 'eus-nsgpvt'
$dsc = 'allow RDP from SEA'
$acc = 'allow'
$ptc = 'TCP'
$drc = 'Inbound'
$pty = 101
$sap = '11.0.0.0/16'
$spr = '*'
$dap = '*'
$dpr = 3389
$nsg = Get-AzNetworkSecurityGroup -Name $nsg

$ruleexists = (Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg).Name.Contains($dsc);

if($ruleexists)
{
	# Update the existing rule with the new IP address
	Set-AzNetworkSecurityRuleConfig `
		-Name $dsc `
		-Description $dsc `
		-Access $acc `
		-Protocol $ptc `
		-Direction $drc `
		-Priority $pty `
		-SourceAddressPrefix $sap `
		-SourcePortRange $spr `
		-DestinationAddressPrefix $dap `
		-DestinationPortRange $dpr `
		-NetworkSecurityGroup $nsg
}
else
{
	# Create a new rule
	$nsg | Add-AzNetworkSecurityRuleConfig `
		-Name $dsc `
		-Description $dsc `
		-Access $acc `
		-Protocol $ptc `
		-Direction $drc `
		-Priority $pty `
		-SourceAddressPrefix $sap `
		-SourcePortRange $spr `
		-DestinationAddressPrefix $dap `
		-DestinationPortRange $dpr
}

# Save changes to the NSG
$nsg | Set-AzNetworkSecurityGroup

Write-Output `n "======================================================================================" 
Write-Output    "==============================   Allow ICMP from SEA   ===============================" 
Write-Output    "======================================================================================" `n

$nsg = 'eus-nsgpvt'
$dsc = 'allow ICMP from SEA'
$acc = 'allow'
$ptc = 'ICMP'
$drc = 'Inbound'
$pty = 102
$sap = '11.0.0.0/16'
$spr = '*'
$dap = '*'
$dpr = '*'
$nsg = Get-AzNetworkSecurityGroup -Name $nsg

$ruleexists = (Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $nsg).Name.Contains($dsc);

if($ruleexists)
{
	# Update the existing rule with the new IP address
	Set-AzNetworkSecurityRuleConfig `
		-Name $dsc `
		-Description $dsc `
		-Access $acc `
		-Protocol $ptc `
		-Direction $drc `
		-Priority $pty `
		-SourceAddressPrefix $sap `
		-SourcePortRange $spr `
		-DestinationAddressPrefix $dap `
		-DestinationPortRange $dpr `
		-NetworkSecurityGroup $nsg
}
else
{
	# Create a new rule
	$nsg | Add-AzNetworkSecurityRuleConfig `
		-Name $dsc `
		-Description $dsc `
		-Access $acc `
		-Protocol $ptc `
		-Direction $drc `
		-Priority $pty `
		-SourceAddressPrefix $sap `
		-SourcePortRange $spr `
		-DestinationAddressPrefix $dap `
		-DestinationPortRange $dpr
}

# Save changes to the NSG
$nsg | Set-AzNetworkSecurityGroup