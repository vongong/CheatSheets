$cred = Get-Credential -UserName 'corp\adm.user' -Message ' '
Start-Process Powershell.exe -Credential $cred -ArgumentList '-noprofile -command &{Start-Process Powershell -verb runas}'