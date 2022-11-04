# $username = 'user'
# $password = 'password'
# $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
# $credential = New-Object System.Management.Automation.PSCredential $username, $securePassword
# Start-Process Notepad.exe -Credential $credential

$cred = Get-Credential -UserName 'domain\user' -Message ' '

Start-Process Powershell.exe -Credential $cred -ArgumentList '-noprofile -command &{Start-Process Powershell -verb runas}'