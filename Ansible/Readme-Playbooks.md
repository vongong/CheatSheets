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

## convert sh to play
```bash
sudo curl -L https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

```yaml
    - name: Install Docker-compose
      ansible.builtin.get_url: 
        url: https://github.com/docker/compose/releases/download/1.27.4/docker-compose-Linux-{{lookup('pipe', 'uname -m')}}
        dest: /usr/local/bin/docker-compose
        mode: +x
```

Lookup is jinga template. built in function