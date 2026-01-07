param (
    [string]$Url,
    [int]$Delka
)

if ([string]::IsNullOrWhiteSpace($Url) -or $Delka -le 0) {
    Write-Output "Použití: $PSCommandPath -Url <URL> -Delka <Číslo>"
    exit
}

$content = (Invoke-WebRequest -Uri $Url).Content -replace '<[^>]+>', ' '
[regex]::Matches($content, "\b\w{$Delka}\b").Value | Select-Object -Unique

#Spuštění - např. 
# .\scraper.ps1 -Url "https://cs.wikipedia.org" -Delka 8
# Zobrazení nápovědy
# .\scraper.ps1 
