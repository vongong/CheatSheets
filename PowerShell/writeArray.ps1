function Write-Array {
    param (
        [string[]] $messages
    )
    
    foreach ($message in $messages){
        Write-Host $message
    }
}

$data = "one", "two", "apple", "orange"

Write-Host $data
Write-Array $data