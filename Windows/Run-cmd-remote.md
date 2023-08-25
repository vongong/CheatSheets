
## Run Command on remote server

```powershell
# Test Connection 
Test-WsMan COMPUTER

# Invoke single command
Invoke-Command -ComputerName COMPUTER -ScriptBlock { COMMAND } -credential USERNAME

# Open shell as User
runas /netonly /user:Domain\user powershell.exe
```