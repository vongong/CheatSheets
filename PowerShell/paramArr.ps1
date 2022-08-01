<#
.Example

./paramArr.ps1 -Environment "Dev","Test" -Region "North","South"
#>

param (
    [string[]]
    $Environment, $Region
)

# Write-Host $Environment
# Write-Host $Region
$ValidRg = "north", "south"

foreach ($Env in $Environment) {
    if ([string]::IsNullOrWhiteSpace($Env)) {
        Write-Host "Cannot have empty Environment" -ForegroundColor "Red"
        continue
    }
    foreach ($Rg in $Region) {
        if ([string]::IsNullOrWhiteSpace($Rg)) {
            Write-Host "Cannot have empty Region" -ForegroundColor "Red"
            continue
        }
        if ($Rg.ToLower() -notin $ValidRg) {
            Write-Host "$Rg not valid Region" -ForegroundColor "Red"
            continue
        }
        Write-Host "$Env-$Rg-app"
    }
}
