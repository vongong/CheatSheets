function test-arr{
    param(
        [object[]] $testArr
    )

    Foreach ($app in $testArr) {
        Write-Host "from func App=$($app.App) RG=$($app.RG)"
    }
}

$AppList = Import-CSV -path "applist.csv"

Foreach ($app in $AppList) {
    Write-Host "inline App=$($app.App) RG=$($app.RG)"
}

test-arr($AppList)