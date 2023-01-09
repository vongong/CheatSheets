# Ansible
Automate IT tasks
Idempotency - Write plays for desired state

## Links
[Ansible Documentation](https://docs.ansible.com/ansible/latest/getting_started/index.html)

## Core Concepts
- Agentless. Only install on control machine.
- Uses Yaml
- Modules - Small programs to do the work. Does one specific task. Grandular and Specific
- Playbook - groups of modules, completed in specific order, 
- Can use Variables
```yaml
- name: rename table
  hosts: databases
  remote_users: root
  vars: 
    tablename: foo
  tasks:
    - name: Rename table {{ tablename }} to bar
      postgresql_table:
        table: {{ tablename }}
        rename: bar
```
- play is host, remote_users, tasks
- playbook can 1 or more plays
- good practice to name the plays with name attrib
- inventory list: hosts attrib
  - can refer multiple server with attrib like databases
  - ip or hostname
```ini
10.20.0.100
[webservers]
10.20.0.1
10.20.0.2
[databases]
10.20.0.7
10.20.0.8
```
- like dockerfile for docker, but for multiple environments.
  - docker uses dockerfile to reproduce docker container
  - ansible uses playbook to reproduce on cloud, container, bare metal, etc
- Ansible tower - ui dashboard from Red Hat
  - Centrally store automated Tasks
  - config Permissions
  - manage inventory
  - get health tools
- puppet & chef - similiar to ansible
  - use ruby - more difficult to learn
  - need to install agent & manage updates

## Install
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
Connects to windows server via winRM
Windows Server 2008 and newer
Required:
- powershell >= 3.0
- .Net Framework >= 4.0

wsl install
```
sudo apt install python3-pip -y
sudo pip3 install ansible
sudo pip3 install pywinrm 
sudo pip3 install pywinrm[credssp]
```

user setup
- can be active directory or without

WinRM setup
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


## Inventory
- manage server with files called hosts. ip or hostname
- hosts file attrib
  - ansible_ssh_private_key_file = file loc of private keys
  - ansible_user = users to login as
*hosts file ssh example*
```ini
10.20.0.7 ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_user=root
10.20.0.8 ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_user=root
```
- ad-hoc command
  - syntax: ansible [pattern] -m [module] -a "module options"
  - [patter] = tarting hosts and groups
  - `ansible all -i hosts -m ping`

*hosts example +groups*
```ini
[droplet]
10.20.0.7 ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_user=root
10.20.0.8 ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_user=root
[database]
[web]
```
- ad-hoc command target droplet group
  - `ansible droplet -i hosts -m ping`
- ad-hoc command target server
  - `ansible 10.20.0.7  -i hosts -m ping`

cleaner host file *hosts example +groups +vars*
```ini
[droplet]
10.20.0.7
10.20.0.8 

[droplet:vars]
ansible_ssh_private_key_file=~/.ssh/id_rsa
ansible_user=root

[ec2]
ec2-11-111-123.eu-west-3.compute.amazonaws.com
ec2-22-222-456.eu-west-3.compute.amazonaws.com

[ec2:vars]
ansible_ssh_private_key_file=~/Dowloads/ansible.pem
ansible_user=ec2-user
ansible_python_interpreter=/usr/bin/python3
```

test ssh connection
```bash
ssh -i ~/Dowloads/ansible.pem ec2-user@ec2-11-111-123.eu-west-3.compute.amazonaws.com
```

If private key is too open.
```bash
~/Dowloads/ansible.pem
chmod 400 ~/Dowloads/ansible.pem
```

### windows
```ini
[web]
webserver01

[web:vars]
ansible_user="svc-ansible@localgroup.local"
ansible_password=P@ssword1
ansible_connection=winrm
ansible_winrm_transport=credssp
ansible_winrm_server_cert_validation=ignore
```
adhoc command: `ansible web -m win_ping`

## Host Key Check

### Long Term
Known Host File = ~/.ssh/known_hosts
`ssh-keyscan -H 10.10.10.123 ~/.ssh/known_hosts`

Connecting machine needs control ssh public key = ~/.ssh/id_rsa.pub
Remote folder = /root/.ssh/authorized_keys

Command to copy public key to remote server
`ssh-copy-id root@10.10.10.222`

### Short Term - temporary / ephemeral
Disable Key Check - less secure
- default Config dir may not be created
- default Config 
  - /etc/ansible.ansible.cfg
  - ~/. ansible.cfg
- can create config file in project folder. called ansible.cfg
```ini
[default]
host_key_checking = False
```

## Playbook
Create Project - folder
Create Host file - use from above
Create config file - optional. See above
Playbooks are yaml, ran in order list

### Create Playbook
```yaml
---   # used to separate plays
- name: config nginx web server
  hosts: webserver # Group or IP defined in hosts file
  tasks:
  - name: install nginx server
    apt: 
      name: nginx
      state: latest      
  - name: start nginx server
    service:
      name: nginx
      state: started
```

Install specific version of nginx
```yaml
  - name: install nginx server
    apt: 
      name: nginx=1.18.0-0ubuntu1.4     # used https://launchpad.net/ to find version
      state: present
```

Install specific version of nginx w/ regex
```yaml
  - name: install nginx server
    apt: 
      name: nginx=1.18*
      state: present
```

Install specific version of nginx
```yaml
  - name: install nginx server
    apt: 
      name: nginx=1.18.0-0ubuntu1.4     # used https://launchpad.net/ to find version
      state: present
```

Stop and uninstall
```yaml
---   # used to separate plays
- name: config nginx web server
  hosts: webserver # Group or IP defined in hosts file
  tasks:
  - name: uninstall nginx server
    apt: 
      name: nginx
      state: absent      
  - name: stop nginx server
    service:
      name: nginx
      state: stopped
```


### execute playbook
syntax: ansible-playbook -i [hosts-file] [playbook-file.yaml]
```bash
ansible-playbook -i hosts my-playbook.yaml
```

## Modules
reusable code that can be used in playbooks
may by ref as plugins

### Where to get info
https://docs.ansible.com/ansible/latest/
choose correct version
look for module index or Indexes of all modules and plugins
may need to add repo before adding adding package manager

**Check if module is installed**: `ansible-galaxy collection list`

### Gather Facts Modules
- automatically called at the begining of task for every play
- gathers is server avail, status, Os, and other that can be used in playbook

### Collection
- Ansible 2.9 and earlier. 
  - All modules were included. 
  - single repo
  - all packed into install
- Ansible 2.9 and later. 
  - when modules reached into 1000, 
  - code base separe code from modules
  - Modules and Plugin moved into "collection"
  - ansible-base-package = ansible code
  - ansible package = ansible modules and plugins
- what is collection
  - collection is a packaging format and distribution
  - collection can be playbooks, modules, plugins
  - all modules are part of collection
- what is plugin
  - code that add functionality to ansible or modules
  - ie. module may terminate vm, plugin may filter list to terminate vm
- Collections lives in galaxy
  - https://galaxy.ansible.com/
  - ansible-galaxy is cli tool install and update collections. same command
  - `ansible-galaxy collection install [collection]`
- create your own collection 
  - predefined structure - required galaxy.yml

## Playbook Examples
- Pay attention on if the modules runs on control or remote host

Install node and npm
```yaml
---
- name: Install node and npm
  hosts: 123.123.123.12
  tasks:
    - name: Update Apt
      apt: update_cache=yes force_apt_get=yes cache_valid_time=3600
    - name: Install nodejs and npm
      apt:
        pkg:
          - nodejs
          - npm

- name: Deploy nodejs app
  hosts: 123.123.123.12
  tasks:
    - name: copy nodejs folder to svr
      copy: 
        src: /user/von/project1/nodejs-app-1.0.0.tgz
        dest: /root/app-1.0.0.tar
    - name: unpack tar
      unarchive:
        src: /root/app-1.0.0.tar
        dest: /root/
        remote_src: yes
    - name: install dependancies  
      npm: 
        path: /root/package
    - name: start app
      command: node /root/package/app/server
      async: 1000     # general attrib
      poll: 0         # general attrib
    - name: check app is running
      shell: ps aux | grep node
      register: app_status
    - name: Print results
      debug: msg={{app_status.stdout_lines}}
```

note:
- Async and Poll are general attrib
- Shell module same as command, but access to shell. ie Env, Pipe, and redirect
- command is more secure
- command and shell are not stateful, consider using conditional
- register creates variable and assign results to task execution

Apt update - alt
```yaml
- name: Install node and npm
  hosts: 123.123.123.12
  tasks:
    - name: Update Apt
      apt: 
        update_cache: yes
        force_apt_get: yes
        cache_valid_time: 3600
```

Deploy nodejs app - combine
```yaml
- name: Deploy nodejs app
  hosts: 123.123.123.12
  tasks:    
    - name: unpack tar
      unarchive:
        src: /user/von/project1/nodejs-app-1.0.0.tgz
        dest: /root/
```
Start App alt
```yaml
- name: start app
  command: 
    chdir: /root/package/app
    cmd: node server
```

Install node and npm - non-root
```yaml
---
- name: Install node and npm
  hosts: 123.123.123.12
  tasks:
    - name: Update Apt
      apt: update_cache=yes force_apt_get=yes cache_valid_time=3600
    - name: Install nodejs and npm
      apt:
        pkg:
          - nodejs
          - npm

- name: Create new user for app
  hosts: 123.123.123.12
  tasks:
    - name: create user
      user: 
        name: nodeuser
        comment: description
        group: admin

- name: Deploy nodejs app
  hosts: 123.123.123.12
  become: True
  become_user: nodeuser
  tasks:
    - name: copy nodejs folder to svr
      copy: 
        src: /user/von/project1/nodejs-app-1.0.0.tgz
        dest: /home/nodeuser/app-1.0.0.tar
    - name: unpack tar
      unarchive:
        src: /home/nodeuser/app-1.0.0.tar
        dest: /home/nodeuser
        remote_src: yes
    - name: install dependancies  
      npm: 
        path: /home/nodeuser/package
    - name: start app
      command: node /home/nodeuser/package/app/server
      async: 1000     # general attrib
      poll: 0         # general attrib
    - name: check app is running
      shell: ps aux | grep node
      register: app_status
    - name: Print results
      debug: msg={{app_status.stdout_lines}}
```
---
left off @lesson233

```yaml
```

