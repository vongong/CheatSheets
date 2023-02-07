
## install
Install MSI - https://aka.ms/installazurecliwindows
Winget - winget install -e --id Microsoft.AzureCLI

## Common
az account list
az config get core

## Output formatting
--Output [json | jsonc | yaml | yamlc | table| tsv]
 
## Config
az config set core.output=yamlc
az config set core.output=table
az config set core.collect_telemetry=false
