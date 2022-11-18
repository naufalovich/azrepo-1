$var = NSG

Write-Output `n "======================================================================================" 
Write-Output    "Creating  $var <======================================================================" 
Write-Output    "======================================================================================" `n

$script = Invoke-WebRequest "https://raw.githubusercontent.com/sayfuladrian/azrepo/main/v2/confscripts/eus-nsg-conf.ps1"
Invoke-Expression $($script.Content)

Write-Output `n "Completed $var <======================================================================" `n