# AzureAD to Graph

## Links
- [Overview](https://learn.microsoft.com/en-us/powershell/microsoftgraph/overview?view=graph-powershell-1.0)
- [cmdlet map](https://learn.microsoft.com/en-us/powershell/microsoftgraph/azuread-msoline-cmdlet-map?view=graph-powershell-1.0)
- [msgraph explorer](https://developer.microsoft.com/en-us/graph/graph-explorer)

## General
- Support 5.1 and 7

## Install
**Install**
Install-Module Microsoft.Graph -Scope CurrentUser
Install-Module Microsoft.Graph -Scope AllUsers
- **Authentication** Module is Requied; its used to connect. `Microsoft.Graph.Authentication`
- There are many Graph Module (40+), recommend installing only ones needed.
- modules to install:
  - Microsoft.Graph.Authentication
  - Microsoft.Graph.Users
  - Microsoft.Graph.Groups
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Install-Module Microsoft.Graph.Authentication -Scope AllUsers
Install-Module Microsoft.Graph.Users -Scope AllUsers
Install-Module Microsoft.Graph.Groups -Scope AllUsers
Install-Module Microsoft.Graph.Applications -Scope AllUsers

**Verify Installation**
Get-InstalledModule Microsoft.Graph
Get-InstalledModule

**Update**
Update-Module Microsoft.Graph

**Uninstall**
Uninstall-Module Microsoft.Graph

**Uninstall Dependancies**
```powershell
Get-InstalledModule Microsoft.Graph.* | %{ if($_.Name -ne "Microsoft.Graph.Authentication"){ Uninstall-Module $_.Name } }
Uninstall-Module Microsoft.Graph.Authentication
```
Note: % => For-Each

## Change API version
By default it uses `v1.0`. 
Change to beta with command: `Select-MgProfile -Name "beta"`
Change to v1.0 with command: `Select-MgProfile -Name "v1.0"`
See Profile: `Get-MgProfile`

## Sign-in
`Connect-MgGraph` command to sign in and needs scope.
```powershell
Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All"
Connect-MgGraph -Scopes "User.Read.All","Group.Read.All"
```

## Find 
Find Module by command: `Find-Module -command "Get-MGUserMessage"`
Find Module by url: `Find-MgGraphCommand -Uri "/security/alerts"`
Find permission: `Find-MgGraphCommand -Command "Get-MGDirectorySetting" | select Permission`

## Call rest endpoint
Invoke-MgGraphRequest -Method GET -Uri $uri -OutputPathFile $path

## Additional Properties
```Powershell
Get-MgGroupMember -GroupId $GroupId
# Output just shows ID

Get-MgGroupMember -GroupId $GroupId | Select-Object -ExpandProperty AdditionalProperties
# Output just shows Key Value of each
```