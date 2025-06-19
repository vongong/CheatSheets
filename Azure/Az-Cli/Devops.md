# Devop Module

## Sample
```Powershell
# Show Project
$Org = "https://dev.azure.com/mycompany/"
$Project = "MyTeamProject"
az devops project show --org $ORG -p $Project

# Get JWT
az account get-access-token --resource 499b84ac-1321-427f-aa17-267ca6975798 --query "accessToken" --output tsv
```
