$msg = 'CREATE SNAPSHOT'
Write-Output `n "==================================================================" 
Write-Output    "Started: $msg" 
Write-Output    "==================================================================" `n

$loc = 'eastus'
$lc = 'eus-'
$rg = $lc + 'rg'
$post = 'a'
$os = 'ad19'
$snp = $lc + 'snp' + $os + $post
$vm = $lc + 'vm' + $os + $post

$vm = Get-AzVm -Name $vm -ResourceGroupName $rg
#$vm.StorageProfile.OsDisk.ManagedDisk.Id

$snpcfg =  New-AzSnapshotConfig -SourceUri $vm.StorageProfile.OsDisk.ManagedDisk.Id -Location $loc -CreateOption copy

#Take the snapshot
New-AzSnapshot -Snapshot $snpcfg -SnapshotName $snp -ResourceGroupName $rg