## Install

To install Az from the PowerShell Gallery, run the following command:

```powershell
Install-Module -Name Az -Repository PSGallery -Force
```

## Update
To update from an older version of Az, run the following command:

```powershell
Update-Module -Name Az
```

## Uninstall

Get Module
```powershell
Get-InstalledModule -Name Az -AllVersions -OutVariable AzVersions
```

Find & Remove Dependencies
```powershell
($AzVersions |
  ForEach-Object {
      Import-Clixml -Path (Join-Path -Path $_.InstalledLocation -ChildPath PSGetModuleInfo.xml)
  }).Dependencies.Name | Sort-Object -Descending -Unique -OutVariable AzModules
```

Remove Az Modules
```powershell
$AzModules |
  ForEach-Object {
    Remove-Module -Name $_ -ErrorAction SilentlyContinue
    Write-Output "Attempting to uninstall module: $_"
    Uninstall-Module -Name $_ -AllVersions
  }
```


