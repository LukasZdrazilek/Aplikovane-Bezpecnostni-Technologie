# vytvoření
New-Alias -Name np -Value 'notepad.exe'
New-Alias -Name ct -Value 'control.exe'

# export
Get-Alias np,ct | Select-Object Name,Definition | ConvertTo-Json -Depth 3 | Out-File -FilePath "$PWD\aliases.json" -Encoding utf8

# smazání
Remove-Item Alias:\np -ErrorAction SilentlyContinue
Remove-Item Alias:\ct -ErrorAction SilentlyContinue

# obnovení
$data = Get-Content -Path "$PWD\aliases.json" -Raw | ConvertFrom-Json
if ($data -isnot [System.Array]) { $data = ,$data }
foreach ($a in $data) { Set-Alias -Name $a.Name -Value $a.Definition }

# ověření
Get-Alias np,ct
