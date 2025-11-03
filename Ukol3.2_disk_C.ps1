$disk = Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object {$_.DeviceID -eq "C:"}
$disk | Set-CimInstance -Property @{VolumeName="Systém"}
