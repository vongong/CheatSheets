


## Cron

- The time zone for cron schedules is UTC.
- the pre-defined `Build.CronSchedule.DisplayName` variable contains the `displayName`
mm HH DD MM DW
 \  \  \  \  \__ Days of week
  \  \  \  \____ Months
   \  \  \______ Days
    \  \________ Hours
     \__________ Minutes

| Field	| Accepted values | 
| -- | -- |
| Minutes	| 0 through 59 | 
| Hours	| 0 through 23 | 
| Days	| 1 through 31 | 
| Months	| 1 through 12, full English names, first three letters of English names | 
| Days of week	| 0 through 6 (starting with Sunday), full English names, first three letters of English names | 

- Examples:
  - `Daily midnight build`: '0 0 * * *'
```yaml
schedules:
- cron: '0 6 1 * *'
  displayName: Monthly midnight build (600 UTC)
  branches:
    include:
    - main
```