
## Find alias
Get-Item -Path Alias:ls

## Create

### Absolute Path
New-Item -Path Alias:np -Value c:\windows\notepad.exe

## Change Alias
Set-Item -Path gp -Value Get-Process -Force

## Remove 
Remove-Item -Path Alias:np
