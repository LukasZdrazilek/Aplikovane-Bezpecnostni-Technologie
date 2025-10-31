Get-CimClass -ClassName Win32_Printer
Set-CimInstance -ClassName Win32_Fax -Property @{Location="Nové umístění"}
