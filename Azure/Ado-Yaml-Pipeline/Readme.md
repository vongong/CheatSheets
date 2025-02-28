# ADO Yaml Pipeline

## Schedule
```yaml
schedules:
- cron: '0 6 * * *'
  displayName: Daily midnight build (600 UTC)
  branches:
    include:
      - main
```

## Variable
```yaml
variables:
  # Set Variable
  - name: Fruit
    value: Apple
  # From Library
  - group: DeployBase
  # From Template
  - template: vars\var_dev-north.yaml
```

vars\var_dev-north.yaml
```yaml
variables:
  - name: Environment
    value: Dev
  - name: Location
    value: North
```

## Tasks

### General
```yaml
steps:      
  - script: dir 
    displayName: What is displayed
    condition: and(succeeded(), ${{ eq(parameters.pushList, true) }})
```

### Common Language

**script**: language depends on vmImage
```yaml
steps:      
  - script: |
      dir 
```

**powershell**: Inline
```yaml
steps:      
  - powershell: |
      Write-Output 'Hello World'
```

**powershell**: Script
```yaml
steps:      
  - powershell: |
      Write-Output
```

**Azure Powershell**: Script
```yaml
steps:      
  - task: AzurePowerShell@5
    displayName: Some Display Name
    pwsh: true # pwsh v powershell
    inputs:
      azureSubscription: $(service_connection_d)
      azurePowerShellVersion: latestVersion
      scriptType: filePath
      scriptPath: 'scripts/doStuff.ps1'
```

**Azure Cli**: Script
```yaml
steps:      
  - task: AzureCLI@2
    displayName: Some Display Name
    inputs:
      azureSubscription: $(service_connection_d)
      azurePowerShellVersion: latestVersion
      scriptType: 'ps'
      scriptPath: 'scripts/doStuff.ps1'
      arguments: '-ThrottleLimit 8'
```

### Publish and Download
```yaml
jobs:
  - job: getDataD
    displayName: Get Azure Web App IPs for Dev-Test    
    steps:
      - script: echo 'hello' > lists\azure_web_apps_dev-test.txt
      - publish: lists\azure_web_apps_dev-test.txt
        artifact: webapp_d
  - job: processData
    displayName: Process Azure Web App IPs for Dev-Test    
    steps:
      - download: current
      - task: CopyFiles@2
        displayName: CopyFiles
        inputs:
          sourceFolder: $(Pipeline.Workspace)
          contents: |
            webapp_d\azure_web_apps_dev-test.txt
          targetFolder: $(Build.Repository.LocalPath)\lists
          flattenFolders: true
          overWrite: true
```

## Set Variable via Script

```Powershell
Write-Host "Setting OutputVar $SetVar to $SetVal"
Write-Host "##vso[task.setvariable variable=$SetVar;isOutput=true]$SetVal"
```
