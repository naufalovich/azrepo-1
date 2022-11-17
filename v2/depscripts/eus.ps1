Write-Output `n "================================ ENVIRONMENT CREATION ================================" `n

$lc = "eus" + "-"
$rg = $lc + "rg"
$loc = "eastus"

.\eus\rg.ps1

.\eus\vnet.ps1

.\eus\nsgpbl.ps1

.\eus\nsgpvt.ps1

.\eus\pipad19a.ps1

.\eus\vnicad19a.ps1

.\eus\vmad19a.ps1

.\eus\pipws10a.ps1

.\eus\vnicws10a.ps1

.\eus\vmws10a.ps1

.\eus\pipws10b.ps1

.\eus\vnicws10b.ps1

.\eus\vmws10b.ps1