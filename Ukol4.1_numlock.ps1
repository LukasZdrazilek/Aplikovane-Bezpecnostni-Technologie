# Zjištění aktuální hodnoty
$currentValue = Get-ItemProperty -Path 'Registry::HKEY_USERS\.DEFAULT\Control Panel\Keyboard' -Name InitialKeyboardIndicators

# Pokud NumLock není zapnutý, nastavíme hodnotu na 2
if ($currentValue.InitialKeyboardIndicators -ne '2') {
    Set-ItemProperty -Path 'Registry::HKEY_USERS\.DEFAULT\Control Panel\Keyboard' -Name InitialKeyboardIndicators -Value '2'
}
