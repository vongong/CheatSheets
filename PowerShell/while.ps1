$RefDate = (Get-Date).AddSeconds(10)
$currDt = get-date

while ($currDt -lt $RefDate){
    $CurrDTstr = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-host "$CurrDTstr still here"
    Start-Sleep -Seconds 1
    $currDt = get-date
}