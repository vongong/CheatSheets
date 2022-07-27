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

foreach ($Env in $Environment) {
    if ([string]::IsNullOrWhiteSpace($Env)) {
        Write-Host "Cannot have empty Environment"
        continue
    }
    foreach ($Rg in $Region) {
        if ([string]::IsNullOrWhiteSpace($Rg)) {
            Write-Host "Cannot have empty Region"
            continue
        }
        Write-Host "$Env-$Rg-app"
    }
}
