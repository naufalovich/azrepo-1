$var = $lc + "nsgpbl"

Write-Output `n "======================================================================================" 
Write-Output    "Creating  $var <=====================================================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzNetworkSecurityGroup -Name $var -ErrorAction SilentlyContinue

if($check -eq $null){

New-AzResourceGroupDeployment `
  -Name remoteTemplateDeployment `
  -ResourceGroupName $rg `
  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/nsg.json" `
  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$var.json"
  
}

else{

    Write-Host "NSG: $var already exist"

}

Write-Output `n "Completed: $var <===================================================================" `n