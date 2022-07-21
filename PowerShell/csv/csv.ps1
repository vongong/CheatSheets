$AppList = Import-CSV -path "appslist.csv"
Foreach ($app in $AppList) {
    Write-Host "AppListRow=$app"
	$a = $app.App
    Write-Host "App=$a"
}