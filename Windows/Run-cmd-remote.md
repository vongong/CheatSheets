
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