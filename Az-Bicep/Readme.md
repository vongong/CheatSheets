
## Description
Built on top of ARM. Designed for Type safety, modular, code reuse, readability.

## Link
[github](https://github.com/Azure/bicep)
[ms-doc](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)

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

## Deploy
**Azure CLI**
```sh
az deployment group create \
  --name ExampleDeployment \
  --resource-group ExampleGroup \
  --template-file <path-to-bicep>
```

**Powershell**
```powershell
New-AzResourceGroupDeployment `
  -Name ExampleDeployment `
  -ResourceGroupName ExampleGroup `
  -TemplateFile <path-to-bicep>
```

## config map

## loops


## Best Practice - tips and tricks
- Set target scope
- use variable for naming standards
- vscode: ctrl-left click, jump into ref filed.
- param 
  - add @description
  - use camelCase
