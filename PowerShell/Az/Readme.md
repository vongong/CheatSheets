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

Get All Az Modules
```powershell
Get-InstalledModule -Name Az -AllVersions -OutVariable AzVersions
```

Get All Previous Az Modules??
```powershell
$latestVer = (Get-InstalledModule -Name Az).Version
$AzVersions = Get-InstalledModule -Name Az -AllVersions | Where-Object {$_.Version -ne $latestVer}
```

Find Dependencies
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

## Login
```powershell
Connect-AzAccount

Get-AzContext -List

Set-AzContext -Subscription "xxxx-xxxx-xxxx-xxxx"
```

## Get ftp data from webapp
```powershell
Get-AzWebAppPublishingProfile -Name <app_name> -ResourceGroupName <rg_name>

$xml = [xml](Get-AzWebAppPublishingProfile -Name <app_name> -ResourceGroupName <rg_name> -OutputFile null)
$xml.SelectNodes("//publishProfile[@publishMethod=`"FTP`"]/@publishUrl").value
```