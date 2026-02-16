# Copy to Storage Account

## Az Copy
```sh
# Upload a Single File:
azcopy copy "C:\myFolder\file.txt" "https://mystorageaccount.blob.core.windows.net/mycontainer/file.txt?SAS-TOKEN"

# Upload a Directory
azcopy copy "C:\myFolder" "https://mystorageaccount.blob.core.windows.net/mycontainer/file.txt?SAS-TOKEN"
```

## Az Powershell Module
```powershell
# Upload a single file (-Force for overwrite)
Set-AzStorageBlobContent -File "C:\localpath\file.txt" -Container "mycontainer" -Blob "myblobname" -Context $ctx

# Upload File (-Force for overwrite)
Get-ChildItem -File -Recurse | Set-AzStorageBlobContent -Container "mycontainer" -Context $ctx
```

## Get Context
```powershell
## Get-AzStorageAccount
$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
$ctx = $storageAccount.Context

## Connection String OAuth
$ctx = New-AzStorageContext -StorageAccountName "myaccount" -UseConnectedAccount

## Name and Key
$ctx = New-AzStorageContext -StorageAccountName "myaccount" -StorageAccountKey "key"

## Connection String
$ctx = New-AzStorageContext -ConnectionString "DefaultEndpointsProtocol=https;AccountName=..."
```
