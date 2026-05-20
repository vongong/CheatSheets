# Azure DevOps Self Hosted Agent

- [Self-Hosted Windows Agent](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/windows-agent?view=azure-devops&tabs=IP-V4)
- [Self-Hosted Agent Auth](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/agent-authentication-options?view=azure-devops)
- [Run Agent in Docker](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops)
- [Git Auth ADO](https://learn.microsoft.com/en-us/azure/devops/repos/git/auth-overview?view=azure-devops&tabs=Windows)

## Review Documentation
- Self-Hosted Windows Agent
  - Download Zip from ADO for Agent Pool
  - Extract Zip
  - Install Agent (.\config.cmd)
  - Get Server Url: https://dev.azure.com/{your-organization}
  - Run Agent (.\run.cmd)
- Self-Hosted Linux Agent
  - Authentication type: PAT, SP, Device
  - Unattended config doesn't have SP
- Self-Hosted Agent Auth  
  - Azure DevOps Services: PAT, SP, Device
  - Personal access token
    - `--token <token>` - specifies your personal access token
  - Service principal
    - `--clientID <clientID>` - specifies the Client ID of the Service Principal with access to register agents
    - `--tenantId <tenantID>` - specifies the Tenant ID which the Service Principal is registered in
    - `--clientSecret <clientSecret>` - specifies the Client Secret of the Service Principal
    - Grant the Service Principal access to the agent pool [link](https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/service-principal-agent-registration?view=azure-devops)
- Run Agent in Docker
  - Script designed only for PAT
  - see start.ps1
  - Win
    - Assume env var
      - AZP_URL=https://dev.azure.com/{your-organization}
      - AZP_POOL=DHD-PROD-WIN-PWRSHL7
    - Use AZP_TOKEN to Download Agent Zip
      - url: https://dev.azure.com/{your-organization}/_apis/distributedtask/packages/agent?platform=win-x64&$top=1
      - header: Authorization="Basic $base64AuthInfo"
    - run: `.\config.cmd --unattended --auth PAT`
    - **!!!** no instructions to use Service Principal
  - Linux
    - Download Agent Zip Change platform
      - Alpine: linux-musl-x64
      - Ubuntu: linux-x64
    - start.sh
      - Use az cli to get access token with SP creds
      - **!!!** call to config.sh w `--auth "PAT"` with jwt

--- 

# Run Agent in Docker with Service Principal

## Info w SP
- Get JWT for SP  
  - POST https://login.microsoftonline.com/*{{TenantId}}*/oauth2/token
  - Body: "grant_type=client_credentials&resource=*{{resourceID}}*&client_id=*{{ClientId}}*&client_secret=*{{KeyId}}*"
  - Header: Content-Type="application/x-www-form-urlencoded"
  - SP Info: TenantId, ClientId, KeyId
  - resourceID: 499b84ac-1321-427f-aa17-267ca6975798 (DevOps)
- header: Authorization="Bearer $jwt"
```powershell
# Mods to Start.ps1
if (-not (Test-Path Env:AZP_TENANTID)) {
    Write-Error "error: missing AZP_TENANTID environment variable"
    exit 1
}
if (-not (Test-Path Env:AZP_CLIENTID)) {
    Write-Error "error: missing AZP_CLIENTID environment variable"
    exit 1
}
if (-not (Test-Path Env:AZP_CLIENTSECRET)) {
    Write-Error "error: missing AZP_CLIENTSECRET environment variable"
    exit 1
}

Write-Host "1. Determining matching Azure Pipelines agent..." -ForegroundColor Cyan
$resourceID = "499b84ac-1321-427f-aa17-267ca6975798"
$response = Invoke-RestMethod "https://login.microsoftonline.com/$(${Env:AZP_TENANTID})/oauth2/token" -Method 'POST' -Headers -Headers @{"Content-Type"="application/x-www-form-urlencoded"} -Body "grant_type=client_credentials&resource=$resourceID&client_id=$(${Env:AZP_CLIENTID})&client_secret=$(${Env:AZP_CLIENTSECRET})"
$accessToken = $response.access_token
$package = Invoke-RestMethod -Headers @{Authorization=("Bearer $accessToken")} "$(${Env:AZP_URL})/_apis/distributedtask/packages/agent?platform=win-x64&`$top=1"
$packageUrl = $package.value[0].downloadUrl

Write-Host "3. Configuring Azure Pipelines agent..." -ForegroundColor Cyan
.\config.cmd --unattended `
    --agent "$(if (Test-Path Env:AZP_AGENT_NAME) { ${Env:AZP_AGENT_NAME} } else { hostname })" `
    --url "$(${Env:AZP_URL})" `
    --auth SP `
    --tenantId "$(${Env:AZP_TENANTID})" `
    --clientId "$(${Env:AZP_CLIENTID})" `
    --clientSecret "$(${Env:AZP_CLIENTSECRET})" `
    --pool "$(if (Test-Path Env:AZP_POOL) { ${Env:AZP_POOL} } else { 'Default' })" `
    --work "$(if (Test-Path Env:AZP_WORK) { ${Env:AZP_WORK} } else { '_work' })" `
    --replace
```

## New Image
```dockerfile
# https://github.com/PowerShell/PowerShell-Docker/blob/master/release/7-5/windowsservercore2022/docker/Dockerfile
FROM mcr.microsoft.com/powershell:7.5-windowsservercore-ltsc2022

# Download and install the Azure CLI MSI
RUN Invoke-WebRequest -Uri https://aka.ms -OutFile AzureCLI.msi; \
    Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet /norestart'; \
    Remove-Item AzureCLI.msi

# Add the Azure CLI path to the system PATH (default installation path)
RUN $env:PATH += ';C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin'; \
    [Environment]::SetEnvironmentVariable('Path', $env:PATH, [EnvironmentVariableTarget]::Machine)

# Verify the installation
RUN az --version

WORKDIR /azp
COPY start.ps1 .
CMD powershell -ep Bypass .\start.ps1
```

