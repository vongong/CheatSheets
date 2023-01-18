<#
.DESCRIPTION
Failover and Data Movement Script for HADR servers.

.PARAMETER $ConnectionString
Required. Connection String to Database Server

.PARAMETER $Cmd
Required. Command to run database server. List of valid commands:
  - suspend-datamovement: stop data movement on all database on server
  - resume-datamovement: start data movement on all database on server
  - invoke-failover: failover over hadr. Server must be secondary.
  - get-data: get hadr general data
  - get-detaileddata: get hadr detailed data
  - confirm-aghealthy: query server until availablity group is healthy
  - confirm-primary: query server until availablity group is primary

.PARAMETER $DryRun
Optional. Will not execute any ALTER commands. It will display them

.PARAMETER $Silent
Optional. Disable Verbose Information

.EXAMPLE
.\HADR.ps1 -ConnectionString $ConnStr -cmd 'suspend-datamovement'
.\HADR.ps1 -ConnectionString $ConnStr -cmd 'resume-datamovement'

.\HADR.ps1 -ConnectionString $ConnStr -cmd 'invoke-failover' -DryRun

.\HADR.ps1 -ConnectionString $ConnStr -cmd 'get-data'
.\HADR.ps1 -ConnectionString $ConnStr -cmd 'get-detaileddata'

.\HADR.ps1 -ConnectionString $ConnStr -cmd 'confirm-aghealthy'
.\HADR.ps1 -ConnectionString $ConnStr -cmd 'confirm-primary'

.NOTES
Change History
User				Date			Ver			Comment
-----------------------------------------------------------------------------
Von Gong			2022-11-29		1.0			Initial Entry
#>

param (
	[string] $ConnectionString
    ,[string] $Cmd
    ,[switch] $DryRun
    ,[switch] $Silent
)

$RetryDurationDefault=3
$RetryTimesDefault=3
$QueryTimeout=15
$ValidCmd = 'get-data',
    'get-detaileddata',
    'suspend-datamovement',
    'resume-datamovement',
    'invoke-failover',
    'confirm-primary',
    'confirm-aghealthy'

$IsLive = $false
$ServerQry = "select @@SERVERNAME ServerName"
$HADRBasicQry = "SELECT ags.primary_replica PrimaryReplica
,ag.name AGName
,ags.synchronization_health_desc AGHealth
FROM sys.dm_hadr_availability_group_states ags
JOIN sys.availability_groups ag ON ags.group_id = ag.group_id"
$HADRDetailQry = "SELECT ag.name AS AGName
,ags.synchronization_health_desc as AGHealth
,ags.primary_replica as PrimaryReplica
,cs.replica_server_name AS Replica
,rs.role_desc AS RepRole
,rs.synchronization_health_desc as RepHealth
,drcs.database_name as DBName
,drs.synchronization_state_desc as SyncState
FROM sys.availability_groups ag
JOIN sys.dm_hadr_availability_group_states ags
ON ag.group_id = ags.group_id
JOIN sys.dm_hadr_availability_replica_cluster_states cs
ON ags.group_id = cs.group_id
JOIN sys.dm_hadr_availability_replica_states rs
ON rs.group_id = ag.group_id and rs.replica_id = cs.replica_id
join sys.dm_hadr_database_replica_states drs
on drs.group_id = ag.group_id and drs.replica_id = rs.replica_id
join sys.dm_hadr_database_replica_cluster_states drcs
on drcs.replica_id = rs.replica_id"
$ServerName = ""

### Module Validation ###
$ModuleValidation=$false

if ((Get-Module -ListAvailable -Name "SqlServer")) {
    Import-Module -Name SqlServer
    $ModuleValidation=$true
}

if(!$ModuleValidation -and (Get-Module -ListAvailable -Name "SQLPS")) {
    Import-Module -Name SQLPS
    $ModuleValidation=$true
}

if(!$ModuleValidation) {
    throw "SQL Module Validation Failed"
}

$VerbosePreference = 'Continue'
if ($Silent){
    $VerbosePreference = 'SilentlyContinue'
}

### Functions ###
<#
.DESCRIPTION
Calls Invoke-Sqlcmd on query passed in with script's connection string
#>
function Invoke-Query{
    param (
        [string]$Query
        ,[int]$QryTimeout=$QueryTimeout
    )
    $fnName = 'Invoke Query'
    try {
        Invoke-Sqlcmd -Query $Query -ConnectionString $ConnectionString -ErrorAction Stop -QueryTimeout $QryTimeout
    }
    catch {
        $message = $_
        Write-Warning "$fnName error: $message"
        Write-Warning "$fnName query: $Query"
        Throw "$fnName encountered error"
    }
}

<#
.DESCRIPTION
Used to display commands to run
#>
function Write-DryRun{
    param (
        [string]$Message
    )
    Write-Host -ForegroundColor DarkGray -NoNewline "Run Qry: "
    Write-Host $Message
}

<#
.DESCRIPTION
Returns Servername of connection string
#>
function Get-ServerName{
    try {
        Invoke-Query -Query $ServerQry
    }
    catch {
        $message = $_
        Write-Warning "Get-ServerName encountered error: $message"
    }
}

<#
.DESCRIPTION
Returns All HADR Data
#>
function Get-HADRDataAll{
    $Query = $HADRDetailQry
    $Query += " order by ag.name, cs.replica_server_name"
    
    try {
        Invoke-Query -Query $Query
    }
    catch {
        $message = $_
        Write-Warning "Get-HADRDataAll encountered error: $message"
    }
}

<#
.DESCRIPTION
Get HADR detail data where the replica matches server's name
#>
function Get-HADRData{
    $Query = $HADRDetailQry
    $Query += " where cs.replica_server_name = @@SERVERNAME"
    $Query += " order by ag.name"

    try {
        Invoke-Query -Query $Query
    }
    catch {
        $message = $_
        Write-Warning "Get-HADRData encountered error: $message"
    }
}

<#
.DESCRIPTION
Get HADR basic data and Availability group matches passed in parameter
#>
function Get-HADRDataAG{
    param (
        [string]$AGName
    )
    $Query = $HADRBasicQry
    $Query += " where ag.name = '$($AGName)'"

    try {
        Invoke-Query -Query $Query
    }
    catch {
        $message = $_
        Write-Warning "Get-HADRDataAG encountered error: $message"
    }
}

<#
.DESCRIPTION
Logic to start or stop data movement
#>
function Invoke-DataMovement{
    param (
        [string]$Status
    )
    if ($DryRun) {
        Write-Verbose "Dry-Run Enabled"
    }
    $fnName = 'Invoke DataMovement'
    $ValidStatus = 'SUSPEND','RESUME'
    if ($Status.ToUpper() -notin $ValidStatus) {
        Write-Warning "$fnName `$Status=$Status value is invalid."
        Return
    }

    $dbList = Get-HADRData | Select-object -Property DBName -Unique
    if ($dbList.Length -eq 0) {
        Write-Warning "$fnName`' No Items found"
        Return
    }

    $err = $false
    foreach ($db in $dbList) {
        $Query = "ALTER DATABASE $($db.DBName) SET HADR $($Status);"
        if ($DryRun){
            Write-DryRun($Query)
            Continue
        }
        Write-Verbose "$fnName Set $($db.DBName) to $($Status)"
        if ($IsLive) {
            try {
                # Invoke-Query($Query) #! Double Check before going live
            }
            catch {
                $err = $true
                Write-Warning "Error Encountered While $fnName Set $($db.DBName) to $($Status)"
            }
        }
    }

    if ($err) {
        Write-Warning "$fnName`' Error Encountered During Process"
        throw "$fnName`' Error Encountered During Process"
    }

}
<#
.DESCRIPTION
Calls stop data movement
#>
function Suspend-DataMovement{
    Write-Verbose "Invoke Suspend Data Movement"
    Invoke-DataMovement -Status 'SUSPEND'
}

<#
.DESCRIPTION
Calls start data movement
#>
function Resume-DataMovement{
    Write-Verbose "Invoke Resume Data Movement"
    Invoke-DataMovement -Status 'RESUME'
}


function Test-AGCheck{
    param (
        [string]$AGName
        ,[string]$AGType
        ,[int]$RetryDuration=$RetryDurationDefault
        ,[int]$RetryTimes=$RetryTimesDefault
    )
    $fnName = 'Test AGCheck'

    $ValidAGType = 'primaryreplica','aghealthy'
    if ($AGType.ToLower() -notin $ValidAGType.ToLower()) {
        Write-Warning "ValidAGType $Cmd value is invalid."
        return
    }
    Write-Verbose "$fnName`: Name=$AGName Type=$AGType"

    $RetryCount = 0
    while ($RetryCount -le $RetryTimes) {
        $AGGet = Get-HADRDataAG($AGName)

        Switch ($AGType.ToLower() ) {
            'primaryreplica' {
                $AGGetValue = $AGGet.PrimaryReplica.ToUpper()
                $AGExpectValue = $ServerName.ToUpper()                
                break
            }
            'aghealthy' {
                $AGGetValue = $AGGet.AGHealth.ToUpper()
                $AGExpectValue = 'HEALTHY'                
                break
            }
        }
        if ($AGGetValue -eq $AGExpectValue) {
            Write-Verbose "$fnName Success"
            break
        }
        Write-Verbose "$fnName Not Successful"
        Write-Verbose "$fnName Value: $($AGGetValue) Expected: $($AGExpectValue) "
        if ($RetryCount -ge $RetryTimes) {            
            Write-Warning "Test-AGCheck Not Sucessful: Name=$AGName Type=$AGType"
            break
        }
        $RetryCount += 1
        Write-Verbose "$fnName Retry #$RetryCount in $RetryDuration sec."
        start-sleep -seconds $RetryDuration
    }
}

<#
.DESCRIPTION
Logic to failover to server (connection string)
#>
function Invoke-Failover{
    $fnName = 'Invoke Failover'
    Write-Verbose $fnName
    if ($DryRun) {
        Write-Verbose "Dry-Run Enabled"
    }
    $agList = Get-HADRData | Where-Object RepRole -eq 'SECONDARY' | Select-object -Property AGName -Unique
    if ($agList.Length -eq 0) {
        Write-Warning "fnName`: No Items to Failover"
        Return
    }

    $err = $false
    foreach ($ag in $agList) {
        $Query = "ALTER AVAILABILITY GROUP $($ag.AgName) FAILOVER;"
        if ($DryRun){
            Write-DryRun($Query)
            continue
        }

        Write-Verbose "Failing over: $($ag.AgName)"
        if ($IsLive) {
            try {
                # Invoke-Query($Query) #! Double Check before going live
            }
            catch {
                $err = $true
                Write-Warning "Error Encountered While Failing over $($ag.AgName)"
            }
        }
    }

    if ($err) {
        Write-Warning "fnName`: Error Encountered During Process"
        throw "fnName`: Error Encountered During Process"
    }
}

function Confirm-HADRInfo{
    param (
        [string]$AGType
    )
    $fnName = 'Confirm HADRInfo'
    Write-Verbose $fnName
    $ValidAGType = 'primaryreplica','aghealthy'
    if ($AGType.ToLower() -notin $ValidAGType.ToLower()) {
        Write-Warning "ValidAGType $Cmd value is invalid."
        return
    }
    Write-Verbose "$fnName Type: $AGType"

    $agList = Get-HADRData

    if ($agList.Length -eq 0) {
        Write-Warning "$fnName`: No AG found"
        Return
    }

    foreach ($ag in $agList) {
        Write-Verbose "$fnName`: Checking $($ag.AgName)"

        Switch ($AGType.ToLower() ) {
            'primaryreplica' {
                $AGGetValue = $ag.RepRole.ToUpper()
                $AGExpectValue = 'PRIMARY'              
                break
            }
            'aghealthy' {
                $AGGetValue = $ag.AGHealth.ToUpper()
                $AGExpectValue = 'HEALTHY'                
                break
            }
        }

        if ($AGGetValue -ne $AGExpectValue){
            Write-Verbose "$fnName Value: $($AGGetValue) Expected: $($AGExpectValue) "
            Test-AGCheck -AGName $ag.AgName -AGType $AGType
        }
    }
}

### Parameter Validation ###
$isValid = $true
if ([string]::IsNullOrWhiteSpace($ConnectionString)) {
	Write-Warning "`$ConnectionString parameter is missing."
	$isValid = $false
}
if ([string]::IsNullOrWhiteSpace($Cmd)) {
	Write-Warning "`$Cmd parameter is missing."
    $isValid = $false
}
if ($Cmd.ToLower() -notin $ValidCmd) {
    Write-Warning "`$Cmd=$Cmd value is invalid."
    $isValid = $false
}
if (!$isValid) {
    Exit 10
}

### Connection Validation ###
Write-Verbose "Testing Connection"
$ServerName = (Get-ServerName).ServerName
if ([string]::IsNullOrWhiteSpace($ServerName)) {
	Write-Warning "Unable to connect to server."
	Exit 11
}
Write-Verbose "Testing Connection Successful"

Write-Verbose "Testing Connection Access"
$getdata = Invoke-Query($HADRBasicQry)
if ($getdata.Length -eq 0) {
    Write-Warning "No HADR Data or HADR Access"
	Exit 11
}
Write-Verbose "Testing Connection Successful Successful"

### Program Start ###
Write-Verbose "Server: $ServerName"
Write-Verbose "Command: $Cmd"

switch ($Cmd.ToLower())
{
    'suspend-datamovement' {
        Suspend-DataMovement
        break
    }
    'resume-datamovement' {
        Resume-DataMovement
        break
    }
    'invoke-failover' {
        Invoke-Failover
        break
    }
    'confirm-primary' {
        Confirm-HADRInfo -AGType 'primaryreplica'
        break
    }
    'confirm-aghealthy' {
        Confirm-HADRInfo -AGType 'aghealthy'
        break
    }
    'get-data' {
        $getdata | Format-Table
        break
    }
    'get-detaileddata' {
        Get-HADRDataAll | Format-Table
        break
    }
    Default {
        Write-Warning "`$Cmd=$Cmd value is invalid."
        break
    }
}
Write-Verbose "Script End"