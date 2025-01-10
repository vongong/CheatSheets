<#
A distributed network name (DNN) listener replaces the traditional virtual network name (VNN) availability group listener when used with Always On availability groups on SQL Server VMs. This negates the need for an Azure Load Balancer to route traffic, simplifying deployment, maintenance, and improving failover.

## Example
add_dnn_listener.ps1 -Ag "PIM_Dev_AG" -Dns "PIMD01AG" -Port 1999

#>

param (
   [Parameter(Mandatory=$true)][string]$Ag,
   [Parameter(Mandatory=$true)][string]$Dnn,
   [Parameter(Mandatory=$true)][string]$Port
)

Write-Host "Add a DNN listener for availability group $Ag with DNS name $Dnn and port $Port"

$ErrorActionPreference = "Stop"

# create the DNN resource with the port as the resource name
Add-ClusterResource -Name $Port -ResourceType "Distributed Network Name" -Group $Ag

# set the DNS name of the DNN resource
Get-ClusterResource -Name $Port | Set-ClusterParameter -Name DnsName -Value $Dnn

# start the DNN resource
Start-ClusterResource -Name $Port

$Dep = Get-ClusterResourceDependency -Resource $Ag
if ( $Dep.DependencyExpression -match '\s*\((.*)\)\s*' ) {
    $DepStr = "$($Matches.1) or [$Port]"
} else {
    $DepStr = "[$Port]"
}

Write-Host "$DepStr"

# add the Dependency from availability group resource to the DNN resource
Set-ClusterResourceDependency -Resource $Ag -Dependency "$DepStr"

#bounce the AG resource
Stop-ClusterResource -Name $Ag
Start-ClusterResource -Name $Ag