param (
	[string]
	$AppName
)
$var1="Var1"
function Write-Apple {
    param (
        [string] $Name
        ,[int] $x
        )
        
     Write-Host "fn name = $appname x=$x"
     Write-Host "fn var1 = $var1 var2=$var2"
 }
    
$var2="Var2"
Write-Apple -Name $AppName -x 50
Write-Host "var1 = $var1 var2=$var2"
