## Inventory
- manage server with files called hosts. ip or hostname
- format: INI or Json
- Inventory can be at directory; not just file
  - Ansible will automaticallly combine them all together
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
  - `ansible 10.20.0.7 -i hosts -m ping`

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

## default host file
ansible.cfg
```ini
[default]
inventory = hosts
```

## host can be in multiple groups
**ex: hosts**
```ini
[databases]
db-prod.example.com
db-test.example.com

[webserver]
web-prod.example.com
web-test.example.com

[test]
db-test.example.com
web-test.example.com

[prod]
db-prod.example.com
web-prod.example.com
```

## groups can have child group
```ini
[atlanta]
host1
host2

[raleigh]
host2
host3

[southeast:children]
atlanta
raleigh

[southeast:vars]
some_server=foo.southeast.example.com
halon_system_timeout=30
self_destruct_countdown=60
escape_pods=2

[usa:children]
southeast
northeast
southwest
northwest
```