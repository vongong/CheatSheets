
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