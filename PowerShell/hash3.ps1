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

$foods = @{
    'Corn' = $True
    'Beef' = $false
    'GreenBeans' = $false
    'Carrots' = $True
    'BrusselSprouts' = $false
}

Write-Hash $foods

Write-Hash @{'Corn' = $True;'Beef' = $false;'GreenBeans' = $false;'Carrots' = $false;'BrusselSprouts' = $true;}