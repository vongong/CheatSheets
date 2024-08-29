
# Tips and Tricks

## links
- [bicep functions](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions)
- [bicep loops](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/loops)

## Concat
Concat can be used on strings, arrays, and objects. For strings, use bicep string interpolation
```bicep
param asp_name string = 'example_name'

output out_interpolation string = 'AutoScale ${asp_name}'
output out_concat string = concat('AutoScale ',asp_name) 
output out_format string = format('{0} {1}','AutoScale',asp_name) 
output out_format string = format('AutoScale {0}',asp_name) 
```

## Use resourceId instead of concat
Use resourceId instead of concat for getting id of resource.
```bicep
param asp_name string

output out_concat string = concat('/subscriptions/', subscription().subscriptionId, '/resourceGroups/', resourceGroup().name,'/providers/Microsoft.Web/serverFarms/',asp_name)
output out_func string = resourceId('Microsoft.Web/serverfarms', asp_name)
```


## Conditional as string
```bicep
var isCritical = false
var alertgroup = (isCritical ? 'CriticalAlertGroup' : 'WarningAlertGroup')

output outvar1 string = resourceId('ActionGroups-rg','Microsoft.Example/actionGroups', '${(isCritical ? 'CriticalAlertGroup' : 'WarningAlertGroup')}')
output outvar1 string = resourceId('ActionGroups-rg','Microsoft.Example/actionGroups', alertgroup)
```

## Understand Child Resource
Keyword is `Parent` that uses parent-child naming pattern `{parent-resource-name}/{child-level1-resource-name}/{child-level2-resource-name}`

### With naming pattern
```bicep
resource storage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'examplestorage'
}

resource service 'Microsoft.Storage/storageAccounts/fileServices@2021-02-01' = {
  name: 'default'
  parent: storage
}

resource share 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-02-01' = {
  name: 'exampleshare'
  parent: service
}
```

### Without naming pattern
```bicep
resource storage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'examplestorage'
}

resource service 'Microsoft.Storage/storageAccounts/fileServices@2021-02-01' = {
  name: 'examplestorage/default'
  dependsOn: [
    storage
  ]
}

resource share 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-02-01' = {
  name: 'examplestorage/default/exampleshare'
  dependsOn: [
    service
  ]
}
```
