
## install architure x86
winget upgrade --all --architecture x86
winget upgrade --all --architecture x64

## Backup/Load list
winget export -o D:\applist.json --accept-source-agreements
winget import -i D:\applist.json --accept-source-agreements --accept-package-agreements

## failed to update sources
winget source update
winget source reset --force

## manual update sources
```powershell
# run under powershell.exe !!!
$smpath = "$env:TEMP\source.msix"
Invoke-WebRequest -Uri https://cdn.winget.microsoft.com/cache/source.msix -OutFile $smpath
Add-AppxPackage -Path $smpath 
```