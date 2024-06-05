
## Az Powershell 12.0.0
New login Experience. Interactive select azure subscription. [Update-AzConfig doc](https://learn.microsoft.com/en-us/powershell/module/az.accounts/update-azconfig?view=azps-12.0.0)
```powershell
# Disable New Login Experience
Update-AzConfig -LoginExperienceV2 Off
```

## Az Cli Sign in interactively
Azure CLI version 2.61.0, if you have access to multiple subscriptions, you're prompted to select an Azure subscription at time of login. [az login doc](https://learn.microsoft.com/en-us/cli/azure/authenticate-azure-cli-interactively)
```sh
# Disable New Login Experience
az account clear # may not need
az config set core.login_experience_v2=off
az login
```
