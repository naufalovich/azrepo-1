$var = $lc + "vnicws10a"

Write-Output `n "======================================================================================" 
Write-Output    "Creating  $var <======================================================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzNetworkInterface -Name $var -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/vnic-ip4.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$var.json"
	  
}

else{

    Write-Host "$var already exist"

}

Write-Output `n "Completed $var <======================================================================" `n