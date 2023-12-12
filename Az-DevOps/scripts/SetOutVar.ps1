param (
    [string] $keyStr
    , [string] $valStr
    , [string] $SetVar
)

$keys = $keyStr -Split ","
$vals = $valStr -Split ","

if ($keys.Length -ne $vals.Length) {
    Write-Warning "Keys: $keyStr"
    Write-Warning "Values: $valStr"
    Write-Warning "SetVar: $SetVar"
    throw "Keys and Values length not match"
}

$arr = @()
for ($i = 0; $i -lt $keys.Length; $i++) {
    if ($vals[$i].ToLower() -eq 'true') {
        $arr += $keys[$i]
    }
}
$SetVal = $arr -join ","
Write-Host "Setting OutputVar $SetVar to $SetVal"
Write-Host "##vso[task.setvariable variable=$SetVar;isOutput=true]$SetVal"