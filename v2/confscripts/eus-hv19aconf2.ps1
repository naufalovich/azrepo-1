#Create new virtual switch
New-VMSwitch -Name vna -SwitchType Internal

#Get ifindex (interfaceindex)
Get-NetAdapter

#Create new virtual network
New-NetIPAddress –IPAddress 192.168.100.1 -PrefixLength 24 -InterfaceIndex 18

#Create new NAT
New-NetNat -Name vnanat -InternalIPInterfaceAddressPrefix 192.168.100.0/24

#Check NAT
Get-NetNat

#Check virtual switch
Get-VMSwitch