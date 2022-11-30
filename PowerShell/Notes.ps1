
Get-Alias
 
#Select-Object
Get-Process | Select-Object -Property ProcessName, Id, WS
Get-Process Explorer | Select-Object -Property ProcessName -ExpandProperty Modules | Format-List
Get-Process | Sort-Object -Property WS | Select-Object -Last 5
"a","b","c","a","a","a" | Select-Object -Unique

#get-member: see all members of type output
Get-Service | Get-Member
Get-Service | Select-Object name, status, machinename

#get commands that has computername as parameter
Get-Command -CommandType Cmdlet -ParameterName ComputerName

#when parameter can take list
"srv1","srv2","srv3" | Where-Object { Test-Connection -Quiet -ComputerName $_ -Count 1}

#when parameter can take one item
"srv1","srv2","srv3" | ForEach-Object { Test-NetConnection -ComputerName $_ }

#diff views
Get-Process | Format-List
Get-Process | Out-GridView

# $username = 'user'
# $password = 'password'
# $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
# $credential = New-Object System.Management.Automation.PSCredential $username, $securePassword
# Start-Process Notepad.exe -Credential $credential

$cred = Get-Credential -UserName 'domain\user' -Message ' '

Start-Process Powershell.exe -Credential $cred -ArgumentList '-noprofile -command &{Start-Process Powershell -verb runas}'