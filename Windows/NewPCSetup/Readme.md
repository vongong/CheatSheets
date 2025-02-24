# Setup New PC

## See Win11-FixAnnoyance

## Install WSL

### vscode config
- Minimap Max Column: 50

### vscode extension
```Powershell
# export 
code --list-extensions # alefragnani.project-manager

# import
code --install-extension alefragnani.project-manager
```

## Setup GIT

## Setup oh-my-posh
- Install New Font
- Install oh-my-posh
- Add to $Profile

## Setup $Profile for Powershell
```Powershell
# Config PSReadLine
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadlineOption -HistorySaveStyle SaveAtExit
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineOption -MaximumHistoryCount 1000

# Setup Windows Alias
Function Get-ChildItemForce($item) {Get-ChildItem -Force $item}
Set-Alias -Name ll -Value Get-ChildItemForce
Set-Alias -Name wget -Value Invoke-WebRequest
Set-Alias -Name touch -Value New-Item

# Setup oh-my-posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\negligible.omp.json" | Invoke-Expression

# manual upgrade
oh-my-posh upgrade

# auto upgrade
oh-my-posh enable upgrade
```

## Winget
- See AppList in winget folder
```Powershell
# Get List of apps
winget export -o .\apps.json 

# Import Apps (Run as Admin)
winget import -i .\apps.json
```
