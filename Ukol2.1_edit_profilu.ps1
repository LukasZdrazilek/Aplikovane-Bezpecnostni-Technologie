# Nejprve vytvoříme profil, např. commandem - notepad $PROFILE
# Pak vložíme commandy níže:

$executionPolicy = Get-ExecutionPolicy
Write-Host "Execution Policy: $executionPolicy" -ForegroundColor Yellow
Write-Host "Profil Path: $PROFILE" -ForegroundColor Green
