
## Get by name
```powershell
Get-AzTag -name 'Team' | Select-Object -ExpandProperty Values
```

## Get by name and value
note: Powershell doen't treat value as case sensitive.
```powershell
az resource list --tag "Team=Infrastructure"
```

## Script to get resourceid of tag name and value
```powershell
$tagName = 'Team'
$tagValue = 'Infrastructure'
$tList = $(az resource list --tag "$tagName=$tagValue" --query [].id -otsv)
$tList | ForEach-Object { write-host "resid=$_" }
```

## Update Tag
```powershell
az tag update --resource-id $resid --operation merge --tags "$tagName=$($tagValue.ToLower())"
```