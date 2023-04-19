
## getSecret
```bicep
param sqlServerName string
param adminLogin string

param kvName string
param kvResourceGroup string

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
    name: kvName
  scope: resourceGroup(kvResourceGroup)
}

module sql './sql.bicep' = {
    name: 'deploySQL'
  params: {
      sqlServerName: sqlServerName
    adminLogin: adminLogin
    adminPassword: kv.getSecret('vmAdminPassword')
  }
}
```

## Parameter file
```json
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "adminLogin": {
      "value": "exampleadmin"
    },
    "adminPassword": {
      "reference": {
        "keyVault": {
          "id": "/subscriptions/<subscription-id>/resourceGroups/<rg-name>/providers/Microsoft.KeyVault/vaults/<vault-name>"
        },
        "secretName": "ExamplePassword"
      }
    },
    "sqlServerName": {
      "value": "<your-server-name>"
    }
  }
}
```