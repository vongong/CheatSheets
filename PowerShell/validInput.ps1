<#
.Example

./validInput.ps1 -Region "North","South","East",""
#>

param (
    [string[]]
    $Regions
)

$ValidRg = "north", "south"

$Regions | ForEach-Object {
    if ([string]::IsNullOrWhiteSpace($_)) {
        Write-Host "Empty Region not accepted" -ForegroundColor "Red"
    }
    if ($_.ToLower() -notin $ValidRg) {
        Write-Host "$_ not valid Region" -ForegroundColor "Red"
    }
}