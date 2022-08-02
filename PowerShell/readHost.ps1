
$displayChoice = $true
while ($displayChoice){

    Write-Host "[0] Connect to Dev/Test (Default)"
    Write-Host "[1] Connect to Stage/Prod"
    $Choice = Read-Host -Prompt "> "
    if (($Choice -eq "0") -or ([string]::IsNullOrWhiteSpace($Choice))) {
        Write-Host "you choose to Dev/Test"        
    } elseif ($Choice -eq "1") {
        Write-Host "you choose to stage/Prod"        
    } else {
        Write-Host "Choose Again."
        continue
    }
    $displayChoice = $false
}

