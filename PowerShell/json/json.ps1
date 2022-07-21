$parameters = "parameter.json"
$json = Get-Content $parameters | Out-String | ConvertFrom-Json

write-host  $json.Parameters.app_resource_group.value