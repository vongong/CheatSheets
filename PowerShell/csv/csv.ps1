$AppList = Import-CSV -path "applist.csv"

Foreach ($app in $AppList) {
    Write-Host "App=$($app.App) RG=$($app.RG)"
}