$foods = @{
    'Corn' = $True
    'Beef' = $false
    'GreenBeans' = $false
    'Carrots' = $True
    'BrusselSprouts' = $false
}

function Write-Hash {
    param(
        [hashtable] $MsgMap
    )

    $MsgArr = @()
    ForEach ($key in $MsgMap.Keys) {
        if ($MsgMap[$key]) {
            $MsgArr += $key
        }
    }
    $MsgArr -join ","
}

Write-Hash $foods