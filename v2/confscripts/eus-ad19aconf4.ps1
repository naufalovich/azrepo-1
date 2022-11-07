Write-Output `n "======================================================================================" 
Write-Output    "==========================  Change DNS from loop to itself  ==========================" 
Write-Output    "======================================================================================" `n

$Dns = @('10.0.0.11','8.8.8.8')
$adapter = Get-NetAdapter -Name "ethernet"
$adapter | Set-DnsClientServerAddress -ServerAddresses $Dns

Write-Output `n "======================================================================================" 
Write-Output    "=========================  Add Reverse Lookup Zone on DNS  ===========================" 
Write-Output    "======================================================================================" `n

Get-DnsServerZone
Add-DnsServerPrimaryZone -NetworkID "10.0.0.0/24" -ReplicationScope "Domain"
Get-DnsServerZone