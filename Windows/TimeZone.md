# Change Time Zone

## Via Command Line

### Get Current Time Zone 
```cmd
tzutil /g
```

### Get List Current Time Zone 
```cmd
tzutil /l
```

### Set Current Time Zone 
```cmd
tzutil /s "Central Standard Time"
```


## Via Powershell

### Get Current Time Zone 
```Powershell
Get-TimeZone
```

### Get List Current Time Zone 
```Powershell
Get-TimeZone -ListAvailable
```

### Set Current Time Zone 
```Powershell
Set-TimeZone -Name "Central Standard Time"
```
