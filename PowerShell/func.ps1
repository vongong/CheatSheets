param (
	[string]
	$AppName
)
function Write-Apple {
    param (
        [string] $Name
        ,[int] $x
    )
    
    Write-Host "name = $appname x=$x"
}

Write-Apple -Name $AppName -x 50