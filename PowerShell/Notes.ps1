
 Get-Alias
 
#Select-Object
Get-Process | Select-Object -Property ProcessName, Id, WS
Get-Process Explorer | Select-Object -Property ProcessName -ExpandProperty Modules | Format-List
Get-Process | Sort-Object -Property WS | Select-Object -Last 5
"a","b","c","a","a","a" | Select-Object -Unique

