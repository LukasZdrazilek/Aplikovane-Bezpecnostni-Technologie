# Hexadecimální řetězec
$s = "506f7765727368656c6c20697320617765736f6d6521"

# Funkce pro konverzi hexadecimálního řetězce na ASCII
$ascii = -join ($s -split '(.{2})' | Where-Object {$_ -ne ''} | ForEach-Object { [char]([Convert]::ToInt32($_, 16)) })

# Výpis výsledného ASCII textu
Write-Host $ascii
