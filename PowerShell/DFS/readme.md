
## Install
Start menu and searching for "Manage optional features", clicking "Add a feature", and installing "RSAT: File Services Tools".

or `Install-WindowsFeature FS-DFS-Namespace, RSAT-DFS-Mgmt-Con`

## cmd
```powershell

# Get Name spaces
$Domain = 'tech.io'
Get-DfsnRoot -Domain $Domain

# Get DFS Folder
Get-DfsnFolder -Path "\\$Domain\AppRoot\*"

# Get DFSR
Get-DfsReplicationGroup -GroupName "GroupName-Test"
Get-DfsrMember -GroupName "GroupName-Test"
Get-DfsrMembership -GroupName "GroupName-Test"
Get-DfsrConnection -GroupName "GroupName-Test"

########
# Create Root
New-DfsnRoot -TargetPath "\\TUS-DC1\NameSpace1$" -Type DomainV2 -Path "\\AACO.local\NameSpace1"

# Create New dfs folder
New-DfsnFolder -Path "\\AACO.local\NameSpace1\Client1" -TargetPath "\\TUS-DC1\Client1$" -EnableTargetFailback $True

# Create/Add dfs folder targer
New-DfsnFolderTarget -Path "\\AACO.local\NameSpace1\Client1" -TargetPath "\\TUS-DC2\Client1$" -ReferralPriorityClass SiteCostNormal
New-DfsnFolderTarget -Path "\\AACO.local\NameSpace1\Client1" -TargetPath "\\TUS-DC3\Client1$" -ReferralPriorityClass SiteCostNormal

# Replication

## Create replication group, replicated folder, connections and set membership properties
New-DfsReplicationGroup -GroupName "Client1" -DomainName "aaco.local"

## Add Member
Add-DfsrMember -ComputerName "TUS-DC1","TUS-DC2","TUS-DC3" -GroupName "Client1" -DomainName "aaco.local"

## Add Replicated Folder
New-DfsReplicatedFolder -FolderName "Client1" -GroupName "Client1" -DfsnPath "\\aaco.local\NameSpace1\Client1"

## Add Spokes
Add-DfsrConnection -DestinationComputerName "TUS-DC2" -GroupName "Client1" -SourceComputerName "TUS-DC1"
Add-DfsrConnection -DestinationComputerName "TUS-DC3" -GroupName "Client1" -SourceComputerName "TUS-DC1"

## Define Hub, Spokes, ReadOnly, etc
Set-DfsrMembership -ComputerName "TUS-DC1" -FolderName "Client1" -GroupName "Client1" -ContentPath "E:\NameSpace1\Client1" -StagingPath "E:\NameSpace1\Client1\DfsrPrivate\staging" -PrimaryMember $true 
Set-DfsrMembership -ComputerName "TUS-DC2" -FolderName "Client1" -GroupName "Client1" -ContentPath "E:\NameSpace1\Client1" -StagingPath "E:\NameSpace1\Client1\DfsrPrivate\staging"
Set-DfsrMembership -ComputerName "TUS-DC3" -FolderName "Client1" -GroupName "Client1" -ContentPath "E:\NameSpace1\Client1" -StagingPath "E:\NameSpace1\Client1\DfsrPrivate\staging" -ReadOnly $true

## Add new individual member
New-DfsnFolderTarget -Path "\\AACO.local\NameSpace1\Client1" -TargetPath "\\TUS-DC4\Client1$" -ReferralPriorityClass SiteCostNormal
Add-DfsrMember -ComputerName "TUS-DC4" -GroupName "Client1" -DomainName "aaco.local"
Add-DfsrConnection -DestinationComputerName "TUS-DC4" -GroupName "Client1" -SourceComputerName "TUS-DC1"
Set-DfsrMembership -ComputerName "TUS-DC4" -FolderName "Client1" -GroupName "Client1" -ContentPath "E:\NameSpace1\Client1" -StagingPath "E:\NameSpace1\Client1\DfsrPrivate\staging"

```