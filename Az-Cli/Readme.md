
## install
Install MSI - https://aka.ms/installazurecliwindows
Winget - winget install -e --id Microsoft.AzureCLI

## Authicate
az login
az login --use-device-code

## Common
*note*: az cli account = pwsh context
az config get core
az account list
az account show
az account set --subscription <name or id>

token
az account get-access-token --resource <site>
az rest --method get --url <site>

## Output formatting
--Output [json | jsonc | yaml | yamlc | table| tsv]
 
## Config
az config set core.output=yamlc
az config set core.output=table
az config set core.collect_telemetry=false
