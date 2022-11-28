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

# save the current preferences to restore later
$CurrentVerbosePreference = $VerbosePreference
$CurrentDebugPreference = $DebugPreference
if ($Verbose){
    $VerbosePreference = 'Continue'
}
if ($Debug){
    $DebugPreference = 'Continue'
}

Write-Verbose 'This is verbose'
Write-Debug 'This is debug'
Write-Warning 'This is a warning'
Write-Error 'This is an error'

$VerbosePreference = $CurrentVerbosePreference
$DebugPreference = $CurrentDebugPreference