# AzureAD to Graph

## Links
- [Overview](https://learn.microsoft.com/en-us/powershell/microsoftgraph/overview?view=graph-powershell-1.0)
- [cmdlet map](https://learn.microsoft.com/en-us/powershell/microsoftgraph/azuread-msoline-cmdlet-map?view=graph-powershell-1.0)

## General
- There are many Graph Module (40+), recommend installing only ones needed.
- Support 5.1 and 7
- **Authentication** Module is Requied; its used to connect. `Microsoft.Graph.Authentication`
- Find modules: `Find-Module Microsoft.Graph*`

## Install
**Install**
Install-Module Microsoft.Graph -Scope CurrentUser
Install-Module Microsoft.Graph -Scope AllUsers

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
By default it uses `v1.0`. Can change to beta with command: `Select-MgProfile -Name "beta"`
See Profile: `Get-MgProfile`

## Sign-in
`Connect-MgGraph` command to sign in and needs scope.
```powershell
Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All"
```

## Find 
Find Module by command: `Find-Module -command "Get-MGUserMessage"`
Find Module by url: `Find-MgGraphCommand -Uri "/security/alerts"`
Find permission: `Find-MgGraphCommand -Command "Get-MGDirectorySetting" | select Permission`

## Call rest endpoint
Invoke-MgGraphRequest -Method GET -Uri $uri -OutputPathFile $path