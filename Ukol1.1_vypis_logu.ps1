$startDate = (Get-Date).AddDays(-10)

# Nejprve se pokusíme získat chyby
$events = Get-WinEvent -LogName System -FilterXPath "*[System[Level=2] and TimeCreated[@SystemTime >= '$($startDate.ToString("yyyy-MM-ddTHH:mm:ss"))']]" -ErrorAction SilentlyContinue

# Pokud nejsou žádné chyby, zkusíme upozornění
if ($events.Count -eq 0) {
    Write-Host "Žádné chyby. Zkouším hledat upozornění..."
    $events = Get-WinEvent -LogName System -FilterXPath "*[System[Level=3] and TimeCreated[@SystemTime >= '$($startDate.ToString("yyyy-MM-ddTHH:mm:ss"))']]" -ErrorAction SilentlyContinue
}

# Pokud máme nějaké události, vypíšeme je
if ($events.Count -gt 0) {
    $events | Format-Table -Property TimeCreated, Id, LevelDisplayName, Message -AutoSize
} else {
    Write-Host "Nebyly nalezeny žádné chyby nebo upozornění v posledních 10 dnech."
}
