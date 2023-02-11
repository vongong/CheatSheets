
## Link
https://nimbletext.com/Help/Keywords

## Commands

`$0 $1` - Column index
`$h0 $h1` - Index Header Row
`$row` - Display Entire row
`$rowNum` - Display row number 0 based
`$rowNumOne` - Display row number 1 based
`$dollar` - Dollar Sign

## once each Example
```
$ONCE
Here's a summary of the weather for the next few days.
$EACH
Day $rowNumOne will be $0
$ONCE
And that's it from the weather desk!
```

## Replace example
All work and no play makes jack a dull boy
```
<% 
$row = $row.replace('a dull boy','an axe-wielding maniac'); 
$row = $row.replace('an axe','a teddy bear');
$row 
%>
```
All work and no play makes jack an axe-wielding maniac

## Replace regex
https://learn.microsoft.com/en-us/powershell/module/az.resources/add-azadgroupmember?view=azps-9.4.0
```
<%  $row.replace(/\?.*/ig,'') %>
```
https://learn.microsoft.com/en-us/powershell/module/az.resources/add-azadgroupmember