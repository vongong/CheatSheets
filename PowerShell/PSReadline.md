
# Get Options
```powershell
Get-PSReadlineOption

Get-PSReadlineOption | select HistoryNoDuplicates, MaximumHistoryCount, HistorySearchCursorMovesToEnd, HistorySearchCaseSensitive, HistorySavePath, HistorySaveStyle
```

# Get Options
```powershell
Set-PSReadlineOption -MaximumHistoryCount 200
Set-PSReadlineOption -HistorySaveStyle SaveAtExit
Set-PSReadLineOption -PredictionViewStyle ListView 
```

# History
```powershell
Clear-History -count 1 -newest
```

# Filepath
```powershell
dir $env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt

code $env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
```