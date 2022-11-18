$hadrMap = @{}

$AppObj = New-Object -TypeName PSObject
$AppObj | Add-Member -Name 'North' -MemberType NoteProperty -Value 'NValue1'
$AppObj | Add-Member -Name 'South' -MemberType NoteProperty -Value 'SValue1'
$hadrMap['d07'] = $AppObj

$AppObj = New-Object -TypeName PSObject
$AppObj | Add-Member -Name 'North' -MemberType NoteProperty -Value 'NValue2'
$AppObj | Add-Member -Name 'South' -MemberType NoteProperty -Value 'SValue2'
$hadrMap['t07'] = $AppObj

$hadrMap

Write-Host 'hadrMap[d07].North='$hadrMap['d07'].North
Write-Host 'hadrMap[d07].South='$hadrMap['d07'].South

Write-Host 'hadrMap[t07].North='$hadrMap['t07'].North
Write-Host 'hadrMap[t07].South='$hadrMap['t07'].South