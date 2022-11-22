Write-Output `n "================================ ENVIRONMENT CREATION ================================" `n

$lc = "eus" + "-"
$rg = $lc + "rg"
$loc = "eastus"

#.\eus\dd19a-1.ps1
#.\eus\dd19a-2.ps1
#.\eus\dd19a-3.ps1
#.\eus\dd19a-4.ps1

$dataDiskName = "eus-ddad19a-1"
$dataDisk1 = Get-AzDisk -Name $dataDiskName -ResourceGroupName $rg
$vm = Add-AzVMDataDisk -VM eus-vmad19a -Name $dataDiskName -CreateOption Attach -ManagedDiskId $dataDisk1.Id -Lun 1

Update-AzVM -VM $vm -ResourceGroupName $rg