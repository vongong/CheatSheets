
## install
Install MSI - https://aka.ms/installazurecliwindows
Winget - winget install -e --id Microsoft.AzureCLI

## Common
az config get core
az account list
az account set --subscription <name or id>

## Output formatting
--Output [json | jsonc | yaml | yamlc | table| tsv]
 
## Config
az config set core.output=yamlc
az config set core.output=table
az config set core.collect_telemetry=false
