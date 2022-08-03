
#Az login
Connect-AzAccount -UseDeviceAuthentication

#Set Subscription context when multiple for tenant
Set-AzContext -SubscriptionID "000-000-000"

#pull secrets
Get-AzKeyVaultSecret -VaultName "my-vault-kv" -Name "abcd-username-cred" -AsPlainText

