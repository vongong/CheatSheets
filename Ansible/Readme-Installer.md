## Install basic
- control node - Machine running Ansible that manages target servers
- windows not supported as control node
- written in python. 
  - **needs python to run**
  - v3 is **required** some functionality
- python to do custom functionality
- locally or remote
- mac: brew install ansible
- linux: 
```sh
apt-get install software-properties-common -y
apt-add-repository ppa:ansible/ansible
apt-get install ansible -y
```
- python: pip install ansible
- check version: ansible --version

### Install on Windows via wsl
wsl install
```bash
sudo apt install python3-pip -y
sudo pip3 install ansible
```

### Install package to connect to Windows Server
Connects to windows server via winRM
Windows Server 2008 and newer
Required:
- powershell >= 3.0
- .Net Framework >= 4.0

**wsl command**
```bash
sudo pip3 install pywinrm 
sudo pip3 install pywinrm[credssp]
```

**user setup**
- can be active directory or without

**WinRM setup**
- https - port 5986
- Auth - CredSSP
```powershell
winrm enumerate winrm/config/listener
winrm get winrm/config/Service

wget https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1 -OutFile ConfigureRemotingForAnsible.ps1

ConfigureRemotingForAnsible.ps1 -EnableCredSSP -DisableBasicAuth -Verbose

Get-ChildItem -path WSMan:\localhost\Listener | Where-Object { $_.Keys -eq "Transport=HTTP"} | Remove-Item -Recurse -Force

Restart-Service WinRM

# Add Ansible Service User to Admins
```