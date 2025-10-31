# Nikdy nepřihlášené účty
Get-CimInstance -ClassName Win32_UserAccount | Where-Object { -not $_.LastLogon } | Select-Object Name, Disabled, Lockout, LastLogon

# Uzamčené účty
Get-CimInstance -ClassName Win32_UserAccount | Where-Object { $_.Lockout -eq $true } | Select-Object Name, Disabled, Lockout
