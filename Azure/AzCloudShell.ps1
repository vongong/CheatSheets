
Connect-AzAccount -UseDeviceAuthentication

#test pull Secret
Get-AzKeyVaultSecret -VaultName "bpb-infra-dev-kv" -Name "vsts-ADSpecific-username-cred" -AsPlainText

