# Ansible
Automate IT tasks
Idempotency - Write plays for desired state

## Links
[Ansible Documentation](https://docs.ansible.com/ansible/latest/getting_started/index.html)
[Index of Modules](https://docs.ansible.com/ansible/latest/collections/all_plugins.html)
[nana git lab](https://gitlab.com/nanuchi/ansible-learn)

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

## Inventory
- manage server with files called hosts. ip or hostname
- hosts file attrib
  - ansible_ssh_private_key_file = file loc of private keys
  - ansible_user = users to login as

## Playbook
- Create Project - folder
- Create Host file - use from above
- Create config file - optional. See above
- Playbooks are yaml, ran in order list
- Run playbook for one server - use --limit parameter
```sh
ansible-playbook PLAYBOOK.yaml --limit HOSTNAME
```

## Collection
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
  - ie. `ansible-galaxy collection install [collection]`
- create your own collection 
  - predefined structure - required galaxy.yml
- Fully Qualified Collection Name (FQCN) - starting 2.10
  - naming convention: [Namespace].[Collection].[Modules]
  - ie. community.docker.docker_image
  - ansible.builtin - default collection
  - Use FQCN is best practice.
  - modules can have same name in different collections 
  - `-vv` parameter in `ansible_playbook` to see how it resolves if not fqcn
## Variables
- Avoid using reserve names as Variable Name
- Valid: Letters, Numbers, and Underscore.
  - don't use: user-name, user name, user.name
  - good: user_name
- Registering Variables - General Parameter - Register
  - Variable is different based on the play
- Reference Variable with `{{ VariableName }}`
- Reference Variable may need quote if folloing comma. `src: "{{ VariableName }}"`
  - colen and curly bracket look like yaml dictionary 

## Project
Keep Project separate directory. 
- ansible.cfg: Ansible Config
- deploy-something.yaml: Playbook
- hosts: inventory file aka hosts file
- project-vars: Variable file

## Dynamic Inventory




---
left off lesson240

CyberArk Module
Ansible Vault

```yaml
```

