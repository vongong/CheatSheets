
## Run Command on remote server
```powershell
# Reboot Immediately 
shutdown /r /t 0

# Shutdown Immediately
shutdown /s /t 0
```

## Change Time Zone

### cmd
```powershell
# Get Current Time Zone 
tzutil /g

# Get List Current Time Zone 
tzutil /l

# Set Current Time Zone 
tzutil /s "Central Standard Time"
```

### PowerShell
```powershell
# Get Current Time Zone 
Get-TimeZone

# Get List Current Time Zone 
Get-TimeZone -ListAvailable

# Set Current Time Zone 
Set-TimeZone -Name "Central Standard Time"
```

## hash
certutil -hashfile "filename.exe" SHA1
certutil -hashfile "filename.exe" SHA256
certutil -hashfile "filename.exe" SHA512
certutil -hashfile "filename.exe" MD5

## copy to clipboard
cat .\filename | clip

## Host file location
c:\Windows\System32\Drivers\etc\hosts

## Create Shortcut
```powershell
# Info
$targetFile = "C:\path\to\your\target.exe"
$shortcutFile = "$env:Public\Desktop\YourShortcut.lnk"

# Create COM object
$WScriptShell = New-Object -ComObject WScript.Shell

# Create Shortcut
$shortcut = $WScriptShell.CreateShortcut($shortcutFile)

# Set shortcut properties.
$shortcut.TargetPath = $targetFile
$shortcut.WorkingDirectory = "C:\path\to\working\directory" # Optional
$shortcut.Arguments = "" # Optional arguments
$shortcut.Description = "Description of the shortcut" # Optional
$shortcut.IconLocation = "C:\path\to\icon.ico,0" # Optional icon path and index

# Save the shortcut
$shortcut.Save()
```

## Run Command on remote server
```powershell
# Open shell as User
runas /netonly /user:Domain\user powershell.exe

# Test Connection 
Test-WsMan COMPUTER

# Invoke single command
Invoke-Command -ComputerName COMPUTER -ScriptBlock { COMMAND } -credential USERNAME

# Start Remote Session
Enter-PSSession -ComputerName COMPUTER -Credential USER
```
