function Write-Array {
    param (
        [string] $keyStr
        , [string] $valStr
    )

    $keys = $keyStr -Split ","
    $vals = $valStr -Split ","

    if ($keys.Length -ne $vals.Length) {
        throw "Keys and Values length not match"
    }

    $arr = @()
    for ($i = 0; $i -lt $keys.Length; $i++) {
        if ($vals[$i].ToLower() -eq 'true') {
            $arr += $keys[$i]
        }
    }
    $arr -join ","
}

# $keyStr = "one,two,apple,orange,frut"

$keyStr = "one,two,apple,orange"
$valStr = "true,false,false,true"

Write-Array -keyStr $keyStr -valStr $valStr

