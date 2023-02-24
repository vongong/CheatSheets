param (
    [string] $path 
)

$fileNames = @(
    'ParametersDevNorth.json'
    'ParametersDevSouth.json'
    'ParametersTestNorth.json'
    'ParametersTestSouth.json'
    'ParametersProdNorth.json'
    'ParametersProdSouth.json'
)

$FG_Good = 'Green'
$FG_Err = 'Red'
$FG_Bold = 'White'
function Test-Value {
    param (
        [string] $matchValue 
        , [string] $actualValue 
    )
    if ($actualValue -match $matchValue) {
        Write-Host $actualValue -ForegroundColor $FG_Good
    }
    else {
        Write-Host "Actual: $actualValue Expected Match: $matchValue " -ForegroundColor $FG_Err
    }
}

function Test-Params {
    param (
        [string] $filePath
    )
    $json = Get-Content $filePath | Out-String | ConvertFrom-Json
    $appName = $json.parameters.sites_Endpoint_name.value

    # $enviro = ($appName -split '-')[1]
    # $region = ($appName -split '-')[2]

    Write-Host "Checking Values for: " -NoNewline
    Write-Host $appName -ForegroundColor $FG_Bold

    # Checking
    Write-Host "  contentVersion: " -NoNewline
    Test-Value -matchValue "1.4.3.0" -actualValue $json.contentVersion

    Write-Host "  asp_name: " -NoNewline
    Test-Value -matchValue "gen\d{2}-$enviro-$region-asp" -actualValue $json.parameters.asp_name.value
}

if ( (Get-Item $path) -is [System.IO.Fileinfo]) {
    Test-Params -filePath $path
}

if ( (Get-Item $path) -is [System.IO.DirectoryInfo]) {
    foreach ($fileName in $fileNames) {
        $newPath = Join-Path -Path $path -ChildPath $fileName
        if ( (Get-Item $newPath) -is [System.IO.Fileinfo]) {
            Write-Host '---' -ForegroundColor $FG_Bold
            Test-Params -filePath $newPath
        }
    }
}
