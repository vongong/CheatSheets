$sku = "SkuV3.json"
$tags = "tag-dev.json"
$newJson = "SkuV3-dev.json"

$skujson = Get-Content $sku -Raw| ConvertFrom-Json
$tagjson = Get-Content $tags -Raw | ConvertFrom-Json


"" | Out-File -FilePath $newJson

#$skujson.parameters.asp_name.value = "hello"
$skujson.parameters | Add-Member -name "tags" -value $tagjson.parameters.tags -MemberType NoteProperty

$skujson | ConvertTo-Json -Depth 5 | Out-File -FilePath $newJson