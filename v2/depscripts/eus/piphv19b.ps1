$var = $lc + "piphv19b"

Write-Output `n "======================================================================================" 
Write-Output    "Creating  $var <======================================================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzPublicIpAddress -Name $var -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/pipBsc.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$var.json"
	  
}

else{

    Write-Host " $var already exist"

}


Write-Output `n "Completed $var <======================================================================" `n