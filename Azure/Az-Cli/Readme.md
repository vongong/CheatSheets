
## install
Install MSI - https://aka.ms/installazurecliwindows
Winget - winget install -e --id Microsoft.AzureCLI

## Authicate
az login
az login --use-device-code
az login --service-principal -u $saUsername -p $saPassword --tenant $tenant

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
az config set core.output=jsonc
az config set core.output=table
az config set core.collect_telemetry=false

## query "Query String"
- `[].id` = list field - columns have no label
  - ie. `az resource list --tag purpose=cdn --query "[].id"`
  - ie. `az resource list --tag purpose=cdn --query "[].[id,name]"`
- `[].{label:field}` = list field and name them
  - ie. `az resource list --tag purpose=cdn --query "[].{label-id,id}"`
- = Filters
  - `[?isDefault].name` = check boolean
  - `[?location == ``global``].name` = logical operator.
  - Notice the extra escape characters (`) surrounding the value. JMESPath offers the standard comparison and logical operators. These include <, <=, >, >=, ==, and !=. JMESPath also supports logical and (&&), or (||), and not (!).
  - ie: `az resource list --tag purpose=cdn --query "[?location == ''global''].name"`