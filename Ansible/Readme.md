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

**2 ways to connect external inventory system:**
- Inventory Plugins
  - Ansible recommends: can use builtin features
  - written in yaml
  - `ansible-doc -t inventory -l ` = list of inventory plugin
- Inventory Scripts
  - written in python

### ex: aws_ec2 plugin**
Connect to aws and get info

**ansible.cfg add plugin**
```ini
[defaults]
enable_plugins = aws_ec2
```

**inventory_aws_ec2.yml** = file needs have aws_ec2 in name so plugin can find it.
```yaml
---
plugin: aws_ec2
regions: 
  - eu-west-3
```

**inventory command**
- `ansible-inventory -i inventory_aws_ec2.yml --list` = Display data in json format
- `ansible-inventory -i inventory_aws_ec2.yml --graph` = Display data in tree format
- only shows private dns name
  - change so vpc has public dns name

**Playbook**
- set host to `All` or aws name (`awe_ec2`)
- need ssh key, can be set in ansible.cfg

**ansible.cfg add ssh**
```ini
[defaults]
enable_plugins = aws_ec2
remote_user = ec2-user
private_key_file = ~/.ssh/id_rsa
```

**playbook command**
`ansible-playbook -i inventory_aws_ec2.yaml deploy-docker-new-user.yaml`

**add invintory file to ansible.cfg**
```ini
[defaults]
enable_plugins = aws_ec2
remote_user = ec2-user
private_key_file = ~/.ssh/id_rsa
inventory = inventory_aws_ec2.yaml
```

command: `ansible-playbook deploy-docker-new-user.yaml`

**target some servers**
`inventory_aws_ec2.yml` = add filters
```yaml
---
plugin: aws_ec2
regions: 
  - eu-west-3
filter:
  tag:Name: dev*
  instance-state-name: running
```
`ansible-inventory -i inventory_aws_ec2.yml --graph` = check

**separate groups**
`inventory_aws_ec2.yml`
```yaml
---
plugin: aws_ec2
regions: 
  - eu-west-3
keyed_groups:
  - key: tags
    prefix: tag
  - key: instance_type
    prefix: instance_type
```

`ansible-inventory -i inventory_aws_ec2.yml --graph` = check

This will change the host group for the playbook

## Roles
If used for many different tasks, have complex and hard to maintain all the playbooks. Structure playbooks in a more managable way. Like a package for your tasks. If multiple plays use same plays, can extact to a role. 
- Dev and test Roles separately
- Existing Roles from community
  - Ansible Galaxy
  - Git Repo
- Write Role as playbook and refactor as role.
- Parameterize Role
- if playbook has tasks and roles, roles will run first
- Predefined structure
  - create skeleton structure `ansible-galaxy init rolename`
  - roles folder
    - role_name
      - task folder: main.yaml (Required)
      - vars folder: main.yaml - vars not intended to be changed
      - files folder: static files
      - defaults folder: main.yaml - if not defined, use these variables. Lowers on precedence
      - meta folder - for documentation
Note: There is a variable precedence least to greater.


ex. Runs role twice. First with defaults. Sec override value
```yaml
- name: runs ftps
  hosts: ftpservers
  roles: 
    - vsftpd_server
    - role: vsftpd_server
      vars:
        ftp_config_src: someothervalue.conf.js.
```

ex. same as above, but allows to mix tasks between roles
```yaml
- name: runs ftps
  hosts: ftpservers
  tasks: 
    - name: Exec Role
      include_role:
        name: vsftpd_server
    - name: override paraa
      include_role: 
        name: vsftpd_server
      vars:
        ftp_config_src: someothervalue.conf.js.
```

## Handlers
- Run tasks when another task runs. 
  - ie reboot server or restart task
  - If made multiple config changes, may only want to reboot once. Ansible will keep track if a trigger is needed
- Ansible verify status before running task.
- Triggered at the end of the block of task in a playbook
- Needs task to notify handler. If multiple tasks notify handler, handler only runs once.
- notify must match handler name - *case sensitive*
- Normally defined at the playbook
- run in order defined in handlers, not notify
- run handler when all tasks are complete
- if 2 handlers have same name, runs the first one defined. *don't do that.*
- notify only if task is **changed** status.

```yaml
tasks: 
  - name: copy config
    template: 
      src: /var/lib/templates/demo.example.config/template
      dest: /etc/httpd/conf.d/demo.example.config
    notify:
      - restart apache
      - restart mysql

handlers:
  - name: restart mysql
    service:
      name: testdb
      state: restarted
  - name: restart apache
    service:
      name: httpd
      state: restarted
```

