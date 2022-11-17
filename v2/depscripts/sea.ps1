Write-Output `n "================================ ENVIRONMENT CREATION ================================" `n

$lc = "sea" + "-"
$rg = $lc + "rg"
$loc = "southeastasia"

.\sea\rg.ps1

.\sea\vnet.ps1

.\sea\nsgpbl.ps1

.\sea\nsgpvt.ps1

.\sea\pipad19a.ps1

.\sea\vnicad19a.ps1

.\sea\vmad19a.ps1

.\sea\pipws10a.ps1

.\sea\vnicws10a.ps1

.\sea\vmws10a.ps1

.\sea\pipws10b.ps1

.\sea\vnicws10b.ps1

.\sea\vmws10b.ps1