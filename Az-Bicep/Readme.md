
## Description
Built on top of ARM. Designed for Type safety, modular, code reuse, readability.

Bicep registry - Azure Container Registry Instance - call templates

## install error
Error with Azure CLI 2.46.0 and Bicep if no bicep configuration exists
```sh
az config set bicep.use_binary_from_path=False
az bicep install
```

## Link
[github](https://github.com/Azure/bicep)
[ms-doc](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
[examples](https://github.com/Azure/azure-docs-bicep-samples)
[Bicep Advance Deployment yt p1](https://www.youtube.com/watch?v=wevlRsVxsUw)
[Bicep Advance Deployment yt p2](https://www.youtube.com/watch?v=6QLkSRc7tgM)
[Bicep Advance Deployment github](https://github.com/kevball2/bicepadvanceddeployments)

## Install
**VSCode Bicep Extension**
Bypass need to install Bicep engine

**Azure CLI**
You must have Azure CLI version 2.20.0 or later installed. [az bicp doc](https://learn.microsoft.com/en-us/cli/azure/bicep?view=azure-cli-latest)

- **Check Az Cli**
  - `Get-InstalledModule -Name Az -AllVersion` = version of Az cli
  - `Find-Module -name Az` = find latest version
- **az bicep**
  - `az bicep install` = Install bicep engine
  - `az bicep version` = Get Bicep Version
  - `az bicep upgrade` = Upgrade Bicep Version
  - `az bicep build {bicep_file}` = build arm template - json file
  - `az bicep decompile --file {json_template_file}` = decompile ARM to a Bicep file
**Windows Install**
- `winget install -e --id Microsoft.Bicep` = Winget
- `choco install bicep` = Chocolatey

## Deploy What if
preview changes before deploying a Bicep file

Powershell
- rg: `New-AzResourceGroupDeployment -Whatif`
- subscription: `New-AzSubscriptionDeployment -Whatif` and `New-AzDeployment -Whatif`

Az Cli
- `az deployment group what-if` for resource group deployments
- `az deployment sub what-if` for subscription level deployments

You can use the `--confirm-with-what-if` switch (or its short form -c) to preview the changes and get prompted to continue with the deployment. Add this switch to:
- `az deployment group create`
- `az deployment sub create`


## Deploy
**Azure CLI**
```sh
az deployment group create \
  --name ExampleDeployment \
  --resource-group ExampleGroup \
  --template-file <path-to-bicep> \
  --parameters @myparameters.json 
```

**Powershell Rg**
```powershell
New-AzResourceGroupDeployment `
  -Name ExampleDeployment `
  -ResourceGroupName ExampleGroup `
  -TemplateFile <path-to-bicep> `
  -TemplateParameterFile <path-to-params>
```

## Best Practice - tips and tricks
- Set target scope
- use variable for naming standards
- vscode: ctrl-left click, jump into ref filed.
- param 
  - add @description
  - use camelCase

## parameters
- strong typed
- Set default value as function: `parm location string = resourceGroup().location`
- Set min, max, default values: `@minValue()`, `@maxValue()`, `@allow([])`
- pass in json parameter file like arm: `--parameters @storeage-parms.json`

## variables
- not strong typed
- don't use concat. use xxx: `var rg_name = '$toLower(name)-rg'`
- var to pull in simple json file
  - file: { "name": "sampleName", }
  - load: `var dnss = json(loadTextContent('./sample.json'))`
  - access: `dsnss.Name`

## Object
example 1
```cs
param vNetSetting object = {
  addressPrefix: '10.0.0.0/22'
  subnets: [
    {
      name: 'first'
      addressPrefix: '10.0.0.0/22'
    }
    {
      name: 'second'
      addressPrefix: '10.0.1.0/22'
    }
  ]
}

resource vnet1 'Microsoft.Network/virtualNetwork@2019-11-01' = {
  name: vnetname
  location: location
  properties: {
    addressSpace: {
      addressPrefix: [vNetSetting.addressPrefix]
    }
  subnets: [
    {
      name: vNetSetting.subnets[0].name
      properties: {
        addressPrefix:vNetSetting.subnets[0].addressPrefix
      }
    }
    {
      name: vNetSetting.subnets[1].name
      properties: {
        addressPrefix:vNetSetting.subnets[1].addressPrefix
      }
    }
  ]
  }
}
```

```cs
@allowd([
  'test'
  'prod'
])
param tierType string

var deploymentSettings = {
  test: {
    askname: 'AKS-Test'
    vmSize: 'Standard_D2_v4'
    nodes: 1
  }
  prod: {
    askname: 'AKS-Prod'
    vmSize: 'Standard_D8_v4'
    nodes: 3
  }
}

resource aks 'Microsoft.ContainerService/managedCluster@2021-03-01' = {
  name: deploymentSettings[tierType].aksname
}
```

Consider having resource property in parameter file. Have param as object
```json
{
  "parameters": {
    "keyvaultParameters": {
      "value": {
        "sku": "Standard",
        "enableForDeployment": false,
        "enableForDiskEncryption": false
        ...
      }
    }
  }
}
```

```cs
param kvProperties Object

module keyvault 'modules/keyvault.bicep' = {
  name: 'kv-${environmentName}-dp'
  scope: resourceGroup
  params: {
    keyVault: keyVaultProperties
    location: location
    locationShortName: locationShortName
    env: env
    keyVaultName: keyVaultName
    roleAssignments: roleAssignments
    tenantId: tenantId
    virtualNetworkId: virtualNetwork.outputs.virtualNetworkId
    workspaceId: appInsights.outputs.workspaceId
  }
  
}

```
## conditional
- **Parent - Child** - Property called `parent`. This property in the the child can reference the parent name


```cs
param nsg_name string
param allow_rdp bool = false

resource nsg 'Microsoft.Network/networkSecurtyGroups' = {
  name: nsg_name
  location: location
}

resource nsg 'Microsoft.Network/networkSecurtyGroups/securityRules' = if (allow_rdp) {
  name: 'RDP'
  parent: nsg
  properties {
    ...
  }
}
```

## Reference another bicep file
```cs
module nsg './nsg.bicep' = {
  scope: 'bicepRG'
  name: 'nsg'
  params: {
    nsg_name: 'nsg001'
    allow_rdp: true
  }
}
```

## Loop
Iterate over arrays, array elements, ranges
- Can loop over powershell for loop.
- @batchSize = show many can run at the same time
- for example
```cs
param vnet_count int
param vnet_prefix string

@batchSize(2)
resource vnet 'Microsoft.Network/virtualNetworks' = [for i in range(1, vnet_found): {
  name: '${vnet_prefix}${i}'
  location: resourceGroup().location
  properties {
    ...
  }]
}
```
- array example
```cs
var vnets = [
  'arrVnet1'
  'arrVnet2'
]

@batchSize(2)
resource vnet 'Microsoft.Network/virtualNetworks' = [for vnet in vnets: {
  name: '${vnet}'
  location: resourceGroup().location
  properties {
    ...
  }]
}
```

use integer index
```cs
param rgLocation string = resourceGroup().location
param storageCount int = 2

resource createStorages 'Microsoft.Storage/storageAccounts@2021-06-01' = [for i in range(0, storageCount): {
  name: '${i}storage${uniqueString(resourceGroup().id)}'
  location: rgLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}]

output names array = [for i in range(0,storageCount) : {
  name: createStorages[i].name
} ]
```

## Key Vault - get secret from vault

sql.bicep
```cs
param sqlServerName string

@secure()
param adminPassword string

resource sqlServer 'Microsoft.Sql/servers' = {
  name: sqlServerName
  location: resourceGroup().location
  properties {
    administratorLogin: 'sqladmin'
    administratorLoginPassword: adminPassword
    version: '12.0'
  }
}
```

Add password to KeyVault. Secret Name adminpassword


sql_kv.bicep
```cs
param sqlServerName string
param kvName string
resource kv 'Microsoft.KeyVault/vault' existing = {
  name: kvName
  scope: resourceGroup()
}

module sql '.\sql.bicep' = {
  name: 'deploySQL'
  params: {
    sqlServerName: sqlServerName
    adminPassword: kv.getSecret('adminpassword')
  }
}
```

## array
<!-- ? Need to investigate -->
```cs
param dnsServers array

var dnsServer_var = {
  dnsServers: array(dnsServers)
}
```

## Get Secret
**getSecret function**
```bicep
param sqlServerName string
param adminLogin string

param subscriptionId string
param kvResourceGroup string
param kvName string

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: kvName
  scope: resourceGroup(subscriptionId, kvResourceGroup )
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

**Parameter File**
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
```bicep
param adminLogin string

@secure()
param adminPassword string

param sqlServerName string

resource sqlServer 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: sqlServerName
  location: resourceGroup().location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
    version: '12.0'
  }
}
```



## Other
- Check if has value, then use it else replace with blank
  - ie: `delegation: contains(subnet, 'delegation') ? subnet.delegation : []`
  - ie: `dhcpOptions: !empty(dnsServers) ? dnsServers_var : null`
- output value
  - ie. `output vnetId string = virtualNetwork.id`
- Can't nest for loops
- vscode bicep extension has visualizer

## ??
- [ ] How to deploy bicep in pipeline? az deployment group? jobs.task?
- [ ] Organize? module folder? 