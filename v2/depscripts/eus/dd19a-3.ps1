$var = $lc + "ddad19a" + "-3"

Write-Output `n "======================================================================================" 
Write-Output    "Creating  $var <======================================================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzDisk -Name $var -ErrorAction SilentlyContinue

if($check -eq $null){

	New-AzResourceGroupDeployment `
	  -Name remoteTemplateDeployment `
	  -ResourceGroupName $rg `
	  -TemplateUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/templates/datadisk.json" `
	  -TemplateParameterUri "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/parameters/$var.json"
	  
}

else{

    Write-Host "$var already exist"

}


Write-Output `n "Completed $var <======================================================================" `n