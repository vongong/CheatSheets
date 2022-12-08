$data = Import-CSV -path "data.csv"

$envs = $data | Select-Object -Property Environment -Unique
$locs = $data | Select-Object -Property Location -Unique
$insts = $data | Select-Object -Property Instance -Unique

Write-Output "envs: $($envs.Length)"
Write-Output "locs: $($locs.Length)"
Write-Output "insts: $($insts.Length)"

# $envMap = @{}
# for ($i=0; $i -lt $envs.Length; $i++) {
#     $key = $envs[$i].Environment
#     $envMap.add($key, $i)
# }

# $locMap = @{}
# for ($i=0; $i -lt $locs.Length; $i++) {
#     $key = $locs[$i].Location
#     $locMap.add($key, $i)
# }

# $instMap = @{}
# for ($i=0; $i -lt $insts.Length; $i++) {
#     $key = $insts[$i].Instance
#     $instMap.add($key, $i)
# }

# $envMap
# $locMap
# $instMap

$hashMap = @{}
for ($i=0; $i -lt $envs.Length; $i++) {
    $key = 'env:' + $envs[$i].Environment
    $hashMap.add($key, $i)
}

for ($i=0; $i -lt $locs.Length; $i++) {
    $key = 'loc:' +$locs[$i].Location
    $hashMap.add($key, $i)
}

for ($i=0; $i -lt $insts.Length; $i++) {
    $key = 'inst:' +$insts[$i].Instance
    $hashMap.add($key, $i)
}
# $hashMap


$arr = New-Object 'object[,,]' $envs.Length,$locs.Length,$insts.Length

foreach ($r in $data){
    $key = 'env:' + $r.Environment
    $e = [int]$hashMap[$key]
    $e
    
    $key = 'loc:' + $r.Location
    $l = [int]$hashMap[$key]
    $l

    $key = 'inst:' + $r.Instance
    $i = [int]$hashMap[$key]
    $i

    $arr[$e,$l,$i] = $r

}

$arr | Format-Table