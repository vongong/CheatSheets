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

## Variable Prompt
ie passwords
```yaml
- name: Start docker containers
  hosts: all
  vars_prompt:
    - name: docker_password
      prompt: Enter password for docker login
  vars_files:
    - project-vars
  tasks:
    - name: Docker login
      community.docker.docker_login: 
        registry_url: https://index.docker.io/v1/
        username: "{{docker_user}}"
        password: "{{docker_password}}"

```

Lookup is jinga template. built in function

## loop over task
keyword **loop**; loop variable **item** hold values

Simple Example
```yaml
- name: create users
  hosts: all
  vars:
    myusers:
      - user1
      - user2
      - user3
      - user4
  tasks:
    - name: create users
      user:
        name: "{{ item }}"
        state: present
      loop: "{{ myusers }}"
```

Example with dict (dictionary)
```yaml
- name: create Groups and assign users
  hosts: all
  tasks:
    - name: create groups
      group:
        name: "{{ item }}"
        state: present
      loop:
        - group1
        - group2
    - name: Set users to group
      user:
        name: "{{ item.name }}"
        group: "{{ item.groups }}"
      with_dict:
        - { name: 'user1', groups: 'group1' }
        - { name: 'user2', groups: 'group1' }
        - { name: 'user3', groups: 'group2' }
        - { name: 'user4', groups: 'group2' }
```

## Conditional
- Task Keyword: **when**
- Task will run **when** condition is met

```yaml
- name: demo
  hosts: all
  vars:
    my_service: httpd
  tasks:
    - name: install {{ my_service }} package
      yum:
        name: "{{ my_service }}"
      when: my_service is defined
```

- Conditons: ==, <, >, <=, >=, !=, is defined, is not defined, not, in 
- example conditions:
  - ansible_machine == "x86_65"
  - min_memory >= 256

When multiple condition, treated as "And"
```yaml
- name: demo in condition
  hosts: all
  gather_facts: yes
  vars:
    my_service: httpd
    supported_os:
      - RedHad
      - Fedora
  tasks:
    - name: install {{ my_service }} package
      yum:
        name: "{{ my_service }}"
      when: 
        - ansible_facts['distribution'] in supported_os
        - ansible_kernal == '3.10'
```

When multiple condition, treated as "or"
```yaml
when: >
    ( ansible_distribution == "RedHat" and
      ansible_distribution_major_version == "7")
    or
    ( ansible_distribution == "Fedora" and
      ansible_distribution_major_version == "28")  
```

**ansible_mount** fact is a list of distionaries, each one representing facts about one mounted file system.
```yaml
- name: install maria-db if enough space on root
  yum:
    name: mariadb-server
    state: latest
  loop: "{{ ansible_mount }}"
  when: item.mount == "/" and item.size_available > 300000000
```
