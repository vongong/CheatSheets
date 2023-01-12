
# Get PDQ to failover HADR

## Links
- Patching SQL AG (https://www.eelcodrost.com/2019/10/16/patching-sql-server-ag-using-sccm-and-powershell/)

- MS Planned Failover (https://learn.microsoft.com/en-us/sql/database-engine/availability-groups/windows/perform-a-planned-manual-failover-of-an-availability-group-sql-server?view=sql-server-ver15)

- SQL Server Powershell (https://learn.microsoft.com/en-us/sql/powershell/sql-server-powershell?view=sql-server-ver16)

- SQLServer Module (https://learn.microsoft.com/en-us/powershell/module/sqlserver/?view=sqlserver-ps)

- (https://www.sqlshack.com/make-the-most-of-secondary-replicas-in-sql-server-always-on-availability-groups/)

- (https://www.mssqltips.com/sqlservertip/3437/manual-sql-server-availability-group-failover/)


## Install powershell modules

### SQLPS cmdlets
The SqlServer module is the current PowerShell module to use.
The SQLPS module is included with the SQL Server installation (for backward compatibility) but is no longer updated.
The SqlServer module contains updated versions of the cmdlets in SQLPS and includes new cmdlets to support the latest SQL features.


### SqlServer cmdlets
PowerShell Gallery support version require PowerShell version 5.1 or greater.

#### Install SqlServer Modules
```powershell
Install-Module -Name SqlServer
```

#### Check SqlServer Modules
```powershell
Get-Module -ListAvailable
Get-Module SqlServer -ListAvailable
Get-Module SQLPS -ListAvailable
```

#### Import
```powershell
Import-Module -Name SqlServer
Import-Module -Name SQLPS
```

## cmdlets Commands
### may need to run as different user

Working
- Pin powershell to task bar
- shift right click, run as different user

working start-process
note: must start process as user w/db permission and admin(-verb runas)
```powershell
Start-Process Powershell.exe -Credential '' -ArgumentList '-noprofile -command &{Start-Process Powershell -verb runas}'
```


### Suspend-SqlAvailabilityDatabase
Suspends data movement on an availability database (https://learn.microsoft.com/en-us/sql/database-engine/availability-groups/windows/suspend-an-availability-database-sql-server?view=sql-server-ver16)
```powershell
# Single Database
Suspend-SqlAvailabilityDatabase -Path "SQLSERVER:\Sql\{Server}\{Instance}\AvailabilityGroups\{MainAG}\AvailabilityDatabases\{Database16}"

# All Database
Get-ChildItem "SQLSERVER:\Sql\{Server}\{Instance}\AvailabilityGroups\{MainAG}\AvailabilityDatabases" | Suspend-SqlAvailabilityDatabase
```

### Resume-SqlAvailabilityDatabase
Resumes data movement on an availability database
```powershell
# single database
Resume-SqlAvailabilityDatabase -Path "SQLSERVER:\Sql\{Server}\{Instance}\AvailabilityGroups\{MainAG}\AvailabilityDatabases\Database16"

# all database
Get-ChildItem "SQLSERVER:\Sql\{Server}\{Instance}\AvailabilityGroups\{MainAG}\AvailabilityDatabases" | Resume-SqlAvailabilityDatabase
```


### Test-SqlAvailabilityGroup
Evaluates the health of an availability group.
```powershell
# Single AG
Test-SqlAvailabilityGroup -Path "SQLSERVER:\Sql\{Server}\{Instance}\AvailabilityGroups\{MainAG}"

Get-ChildItem "SQLSERVER:\Sql\MAZV-UNC-SQLD07\DEFAULT\AvailabilityGroups" | Test-SqlAvailabilityGroup
```


### Test-SqlAvailabilityReplica
Evaluates the health of availability replicas.

Get Health of AG
```powershell
Test-SqlAvailabilityReplica -Path "SQLSERVER:\Sql\{Server}\{Instance}\AvailabilityGroups\{MainAG}\AvailabilityReplicas\{MainReplica}"
```

Get Health of AGs of server
```powershell
Get-ChildItem "SQLSERVER:\Sql\MAZV-UNC-SQLD07\DEFAULT\AvailabilityGroups\CustomerSource_Dev_AG\AvailabilityReplicas" | Test-SqlAvailabilityReplica
```

### Test-SqlDatabaseReplicaState
Evaluates the health of an availability database.
```powershell
Test-SqlDatabaseReplicaState -Path "SQLSERVER:\Sql\{Server}\{Instance}\AvailabilityGroups\{MainAG}\DatabaseReplicaStates\{MainReplica}.{MainDatabase}"
```


## Planned Failover AG (AvailabilityGroup)

### Powershell: Switch-SqlAvailabilityGroup
Starts a failover of an availability group to a secondary replica
```powershell
Switch-SqlAvailabilityGroup -Path "SQLSERVER:\Sql\{Server}\{Instance}\AvailabilityGroups\{MainAG}"
```

### TSQL Failover
1. Connect to the server instance that hosts the target secondary replica.
1. Use the ALTER AVAILABILITY GROUP statement

```sql
ALTER AVAILABILITY GROUP MyAg FAILOVER;
```

Force Failover - 
```sql
ALTER AVAILABILITY GROUP MyAg FORCE_FAILOVER_ALLOW_DATA_LOSS;
```

### TSQL Data Movement
```sql
-- Stop/Suspend
ALTER DATABASE [Notification] SET HADR SUSPEND;

--Start/Resume
ALTER DATABASE [Notification] SET HADR RESUME;
```

## Failover meeting w Brian
**AG**: ItemSource, WOM - POC; No Database in those AGs

**Default Config**: North is primary

**Patch Secondary**
- When failover dev - notify Slack - Dev channel. Ping Christian for good time.
- connect server, run ssms
- Always on Folder
- right click - show dashboard
- suspend data movement
- apply patch secondary (South)

**Patch Primary**
- stop datamovement
- Right click failover, accept data loss
- Need to do for all AGs
- connect to secondary (South)

**Failback**
- right click failover to North
- start data movement on north
- start data movement on south


## query for all data
```sql
SELECT    
    ag.name AS 'AGName'
    ,ags.primary_replica 'PrimaryReplica'
    ,cs.replica_server_name AS 'Replica'
    ,rs.role_desc AS 'RepRole'	
    ,drcs.database_name as 'DatabaseName'
    ,ags.synchronization_health_desc as 'AGHealth'
    ,rs.synchronization_health_desc as 'RepHealth'
    ,drs.synchronization_state_desc as 'SyncState'        
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
    on drcs.replica_id = rs.replica_id
order by ag.name, rs.role    
```

**AGName:** Availability Group Name
**PrimaryReplica:** Primary Replica
**Replica:** Replica Name
**RepRole:** Replica Role
**DatabaseName:** Database Name
**AGHealth:**  Availability Group Health
**RepHealth:** Replica Health
**SyncState:** Synchronization State

### failback
#### restore datamovement

## Design

### GetData General
```sql
select ag.name Name
  ,ags.primary_replica PrimaryReplica
  ,ar.replica_server_name SecondaryReplica
  ,ags.synchronization_health_desc HealthStatus
from sys.availability_groups ag
join sys.availability_replicas ar on ag.group_id = ar.group_id
join sys.dm_hadr_availability_group_states ags on ar.group_id = ags.group_id
where ags.primary_replica != ar.replica_server_name
```


### GetData Detailed
```sql
SELECT
	ag.name AS 'AGName'
    ,ags.synchronization_health_desc as 'AGHealth'
    ,ags.primary_replica 'PrimaryReplica'
	,cs.replica_server_name AS 'Replica'
	,rs.role_desc AS 'RepRole'
	,rs.synchronization_health_desc as 'RepHealth'
	,drcs.database_name as 'DatabaseName'
	,drs.synchronization_state_desc as 'SyncState'
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
    on drcs.replica_id = rs.replica_id
```


### Data Movement
**Parameter**
- Server Name
- Suspend or Resume

**Logic**
1. Get DB on Server
1. Alter Database for HADR
```sql
ALTER DATABASE [DBName] SET HADR [SUSPEND|RESUME];
```
1. Or Run Powershell command
```powershell
$instance = (Get-ChildItem "SQLSERVER:\Sql\$serverName").InstanceName
if ($instance -eq '') {
    $instance = 'DEFAULT'
}

foreach ($db in $qry) {
    Suspend-SqlAvailabilityDatabase -Path "SQLSERVER:\Sql\$serverName\$instance\AvailabilityGroups\$($db.AGName)\AvailabilityDatabases\$($db.DatabaseName)"
}
```

### Failover
**Parameter**
- ServerName

**Logic**
1. Get Info
1. Check if PrimaryReplica = ServerName
1. sql script
1. Or Powershell
```Powershell
$instance = (Get-ChildItem "SQLSERVER:\Sql\$serverName").InstanceName
if ($instance -eq '') {
    $instance = 'DEFAULT'
}

$qry = $agData | where-object Role -eq 'SECONDARY' | where-object Replica -eq $serverName

foreach ($ag in $qry) {
    Switch-SqlAvailabilityGroup -Path "SQLSERVER:\Sql\$serverName\$instance\AvailabilityGroups\$($ag.AGName)"
}
```

