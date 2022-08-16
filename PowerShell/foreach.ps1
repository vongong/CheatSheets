
$urls = "dev.site.com", 
    "test.site.com", 
    "prod.site.com"

$urls | Foreach-Object -ThrottleLimit 5 -Parallel {
    Write-Host "process url: $_"
}