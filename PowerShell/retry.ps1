
$Maximum = 5
$Delay = 100
$cnt = 0
$StopLoop = $false

do {
    $cnt++
    Write-Host "try: $cnt"
    try {        
        Write-Host "processing"
        # simulate error
        throw "Error"

        # leave loop
        #return
    } catch {                
        $msg = "error caught"        
        Write-Host $msg
        if ($cnt -ge $Maximum){
            $StopLoop = $true
        }
        Start-Sleep -Milliseconds $Delay
    }
} while (-not $StopLoop)
