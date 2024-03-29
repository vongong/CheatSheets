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

###

$foods = @{}
$foods.Add('Corn', 'Yellow')
$foods.ContainsKey('Corn')
$foods.ContainsKey('Beef')

$foods.Add('Corn', 'Purple') # Error
$foods.Set_Item('Corn', 'Purple') 
$foods.'Corn'

$foods.Set_Item('Beef', 'Brown') 
$foods.'Brown'
$foods['Brown']