Get-CimClass -ClassName Win32_Printer

$printer = Get-CimInstance -ClassName Win32_Printer -Filter "Name='Fax'"
Set-CimInstance -InputObject $printer -Property @{ Location = "Nové umístění" }
