
$s = '111','222','aaa','bbb','ccc'

$sList = @()
$s | ForEach-Object {
    $sObj = New-Object -TypeName PSObject
    $sObj | Add-Member -Name 'App' -MemberType NoteProperty -Value $_
    $sObj | Add-Member -Name 'Value' -MemberType NoteProperty -Value 'Test'
    $sList += $sObj
}

$sList 