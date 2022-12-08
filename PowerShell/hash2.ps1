$foods = @{
    'Corn' = 'Yellow'
    'Beef' = 'Brown'
    'Green Beans' = 'Green'
    'Carrots' = 'Orange'
    'Brussel Sprouts' = 'Green'
}

# Write-Host "all"
# $foods | ForEach-Object { $_ }

Write-Host "keys"
$foods.Keys

Write-Host ""
Write-Host "loop:"
ForEach ($key in $foods.Keys) {
Write-Host "$key = $($foods[$key])"
}