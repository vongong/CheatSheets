# Ansible
Automate IT tasks

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
- written in python. **needs python to run**
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
```
