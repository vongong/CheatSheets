
## troubleshoot install modules

### Install
```powershell
Install-Module -Name $moduleName -AllowClobber -Scope CurrentUser -Force -debug
```

### verify run as tls 1.2
```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
```

### check module exists
```powershell
Get-Module -ListAvailable
```

### check PSRepository
```powershell
Get-PSRepository
Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
```

### Package Provider
```powershell
# check
Get-PackageProvider -ListAvailable

# install PowerShellGet and Nuget
Install-PackageProvider -Name PowerShellGet -Force
Install-PackageProvider -Name NuGet -Force
```


