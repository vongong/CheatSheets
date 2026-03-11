# Powershell

See [PwshExamples](https://github.com/vongong/PwshExamples)

## Profile
```powershell
# Config PSReadLine
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadlineOption -HistorySaveStyle SaveAtExit
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineOption -MaximumHistoryCount 1000

# Setup Windows Alias
Function Get-ChildItemForce($item) {Get-ChildItem -Force $item}
Set-Alias -Name ll -Value Get-ChildItemForce
# Set-Alias -Name wget -Value Invoke-WebRequest
Set-Alias -Name touch -Value New-Item

# Setup $HomeDir
$homeDir = "C:\dev"
Write-Host "Set `$homedir $homedir"

# Setup oh-my-posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\negligible.omp.json" | Invoke-Expression
```