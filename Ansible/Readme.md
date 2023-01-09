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
- python: pip install ansible
- check version: ansible --version

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

Gather Facts Modules
- automatically called at the begining of task for every play
- gathers is server avail, status, Os, and other that can be used in playbook


## Modules
---
@lesson228 start


