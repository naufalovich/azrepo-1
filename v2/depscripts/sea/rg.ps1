Write-Output `n "======================================================================================" 
Write-Output    "Creating  $rg <=======================================================================" 
Write-Output    "======================================================================================" `n

$check = Get-AzResourceGroup -Name $rg -ErrorAction SilentlyContinue

if($check -eq $null){

    New-AzResourceGroup -Name $rg -Location $loc
	
}
else{

    Write-Host "RESOURCEGROUP: $rg already exist"
	
}

Write-Output `n "Completed: $rg <======================================================================" `n