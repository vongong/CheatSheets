
## Loop via parameter
Easily done. The yaml processing for az pipeline can handle this
```yaml
parameters:
  - name: Environments
    displayName: Environments
    type: object
    default:
      - Dev
      - Test

pool:
  vmImage: 'windows-2019'      

steps:
  - ${{ each value in parameters.Environments }}:
    - script: echo ${{ value }}
```

## Loop via variable
Built in yaml processing can't looping over variables since variable can't be object type. However, the function split can change a comma separted list to an array object
```yaml
pool:
  vmImage: 'windows-2019'

variables:
  - name: Environments
    value: 'Dev,Test,Prod'

steps:
  - ${{ each var in split(variables.Environments, ',') }}:
    - script: |
        echo ${{ var }}
```

## Loop Conditional
```yaml
trigger: none

parameters:
- name: envDev
  displayName: Environment Dev
  type: boolean
  default: true
- name: envTest
  displayName: Environment Test
  type: boolean
  default: false
- name: envProd
  displayName: Environment Prod
  type: boolean
  default: false

pool:
  vmImage: 'windows-2019'

variables:
- name: Environments
  value: 'Dev,Test,Prod'

stages:
  - stage: Init
    variables:
      - name: EnvSelected
        value: ''
    jobs:
      - job: InitVars
        steps:
          - powershell: |
               $msgHash = @{
                  'Dev'  = $${{ parameters.envDev }}
                  'Test' = $${{ parameters.envTest }}
                  'Prod' = $${{ parameters.envProd }}
                }
                $MsgArr = @()
                ForEach ($key in $msgHash.Keys) {
                  if ($msgHash[$key]) { $MsgArr += $key }
                }
                $myValue = $MsgArr -join ","
                Write-Host "Setting value to $myValue"
                Write-Host "##vso[task.setvariable variable=EnvSelected;isOutput=true]$myValue"
            name: InitEnv
  - ${{ each env in split(variables.Environments, ',') }}:
    - stage: ${{ env }}
      dependsOn: Init
      condition: and( eq(dependencies.Init.result, 'Succeeded'), contains(dependencies.Init.outputs['InitVars.InitEnv.EnvSelected'],'${{ env }}') )
      jobs:
        - job: NewJob
          steps:
            - script: |
                echo ${{ env }}
```