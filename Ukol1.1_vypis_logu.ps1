$startDate = (Get-Date).AddDays(-10)

# Nejprve se pokusíme získat chyby
$filterError = @{
    LogName = 'System'
}

# Získáme všechny události z posledních 10 dní a filtrujeme je podle času a úrovně
$events = Get-WinEvent @filterError -ErrorAction SilentlyContinue | 
    Where-Object { $_.TimeCreated -ge $startDate -and $_.Level -eq 2 }

# Pokud nejsou žádné chyby, zkusíme upozornění
if ($events.Count -eq 0) {
    Write-Host "Žádné chyby. Zkouším hledat upozornění..."
    
    # Filtrujeme upozornění (Level 3)
    $events = Get-WinEvent @filterError -ErrorAction SilentlyContinue | 
        Where-Object { $_.TimeCreated -ge $startDate -and $_.Level -eq 3 }
}

# Pokud máme nějaké události, vypíšeme je
if ($events.Count -gt 0) {
    $events | Format-Table -Property TimeCreated, Id, LevelDisplayName, Message -AutoSize
} else {
    Write-Host "Nebyly nalezeny žádné chyby nebo upozornění v posledních 10 dnech."
}
