
$urls = "dev.site.com", 
    "test.site.com", 
    "prod.site.com"

$urls | Foreach-Object -ThrottleLimit 5 -Parallel {
    Write-Host "process url: $_"
}

$s = '111','222','aaa','bbb','ccc'

# error
# 0..4 | ForEach-Object -Parallel { $s[$_] }

0..4 | ForEach-Object -Parallel {
    $($using:s)[$_] 
}
