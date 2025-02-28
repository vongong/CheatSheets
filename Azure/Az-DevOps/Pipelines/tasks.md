
# AzureResourceManagerTemplateDeployment@3
MS Link (https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/azure-resource-manager-template-deployment-v3?view=azure-pipelines)

## overrideParameters
If the parameter value has multiple words, enclose the words in quotes, even if you're passing the value by using variables. **For example**, `-name "parameter value" -name2 "$(var)"`.  

To override object type parameters, use stringified JSON objects. **For example**, `-options ["option1"] -map {"key1": "value1" }`.

**String & Int work as expected**

**Bool**: Can work is passed in as lowercase. When accessing parameter, must call lower() before passing overrideParameters.

Given
```yaml
parameters:
  - name: isEnabled
    displayName: isEnabled
    type: boolean
    default: false
```    

Fails
```yaml
steps:
  - task: AzureResourceManagerTemplateDeployment@3
    inputs:
      overrideParameters: >
        -isEnabled ${{ parameters.isEnabled }}
```

Working
```yaml
steps:
  - task: AzureResourceManagerTemplateDeployment@3
    inputs:
      overrideParameters: >
        -isEnabled ${{ lower(parameters.isEnabled) }}
```

# Publish 
```yaml
steps:
  - task: CopyFiles@2
    displayName: CopyFiles
    inputs:
    sourceFolder: $(Build.Repository.LocalPath)\lists
    contents: |
      stores.txt
      stores.json
    targetFolder: $(Build.ArtifactStagingDirectory)
- publish: $(Build.ArtifactStagingDirectory)
  artifact: storedns
```   

# Download
```yaml
steps:
  - download: current
  - task: CopyFiles@2
    displayName: CopyFiles
    inputs:
    sourceFolder: $(Build.Repository.LocalPath)\lists
    contents: |
      stores.txt
      stores.json
    targetFolder: $(Build.ArtifactStagingDirectory)

```  

# Debug Info
```yaml
steps:
  - task: PowerShell@2
    displayName: Display Parameters
    condition:  eq('${{ parameters.debugInfo }}', true)
    inputs:
      targetType: inline
      script: |
        write-host Parameters
        write-host ==========================
        write-host aspname=${{ parameters.aspname }}
        write-host location=${{ parameters.asplocation }}
        write-host envTag=${{ parameters.envTag }}
```        