$timeout = new-timespan -Minutes 1
$sw = [diagnostics.stopwatch]::StartNew()
$AgState = "UnHealthy"
while ($sw.elapsed -lt $timeout) {
    $AgState = "Healthy"
    break
}
write-host "AgState = $AgState"