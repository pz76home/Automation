FOR /F "tokens=*" %%i IN ('Powershell -command "Get-WMIObject Win32_networkadapter | Where-Object {($_.netconnectionstatus -match "2")} | Where-Object {($_.netconnectionid -ne 'EthernetNew' )} | Select -ExpandProperty netconnectionid -Last 1"') do (SET ADAPTER=%%i)

netsh interface set interface name="%adapter%" disable
