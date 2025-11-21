$apiUrl = "https://api.open-meteo.com/v1/forecast?latitude=49.19&longitude=16.61&current=temperature_2m&temperature_unit=celsius"

try {
    $response = Invoke-RestMethod -Uri $apiUrl -Method Get
    $teplota = $response.current.temperature_2m
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $outputfile = "$timestamp - $teplota°C"
    $outputscript = "$timestamp - stav v Brne: $teplota °C"

    $desktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
    $filePath = Join-Path -Path $desktopPath -ChildPath "teploty.txt"

    Add-Content -Path $filePath -Value $outputfile
    Write-Output $outputscript
}
catch {
    $errorMessage = "$($_.Exception.Message)"
    Write-Output $errorMessage
    
    $desktopPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
    $filePath = Join-Path -Path $desktopPath -ChildPath "teploty.txt"
    Add-Content -Path $filePath -Value "$timestamp - $errorMessage"
}


# Plánovač potom třeba takto:

schtasks.exe /CREATE /SC HOURLY /MO 1 /TN "Mereni teploty" /TR "powershell.exe -ExecutionPolicy Bypass -File C:\Users\spravce\PS\teploty.ps1" /ST 00:00 /RU SYSTEM
