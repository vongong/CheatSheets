<#
.\write-test.ps1
.\write-test.ps1 -verbose
.\write-test.ps1 -debug
.\write-test.ps1 -verbose -debug
#>
param (
    [switch]$Verbose,
    [switch]$Debug
)

Write-Host 'This is Write Host'

function Write-DebugFmt{
    param (
        [string]$Message
    )
    $CurrDate = Get-Date -Format "yyyy-MM-dd HH:mm:"
    Write-Output "$CurrDate $Message"
}

if ($Verbose){
    $VerbosePreference = 'Continue'
}
if ($Debug){
    $DebugPreference = 'Continue'
}

Write-Verbose 'This is verbose' 
Write-Debug 'This is debug'
Write-DebugFmt 'This is debugFmt' 
Write-Warning 'This is a warning'
Write-Error 'This is an error' -Category NotSpecified
Throw 'This is a throw'


Write-Host 'Write Host End'