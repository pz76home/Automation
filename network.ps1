$DHCP=Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {($_.DHCPEnabled -match "True")}  | Select -ExpandProperty Index
$wmi=Get-WMIObject Win32_networkadapter | Where-Object {($_.netconnectionstatus -match "2")} | Where-Object {($_.netconnectionid -ne "EthernetNew")} | Where-Object {($_.Index -match $DHCP)} | Select -Last 1
$wmi.NetconnectionID = 'EthernetNew'
$wmi.Put()
