## Modules
reusable code that can be used in playbooks
may by ref as plugins

### Common Modules
Builtin (https://docs.ansible.com/ansible/latest/collections/ansible/builtin/index.html)
windows (https://docs.ansible.com/ansible/latest/collections/ansible/windows/index.html)
- ansible.builtin.apt - Apt package manager
- ansible.builtin.get_url - wget
- ansible.builtin.group - create linux group
- ansible.builtin.user - create linux user
- ansible.windows.win_user - create windows user
- ansible.builtin.unarchive - untar
- ansible.builtin.command - run command. more secure
- ansible.builtin.shell - run as shell. access to pipe and redirect
- ansible.builtin.file - manges linux file and file properies
- ansible.windows.win_file - manges windows file and file properies
- ansible.builtin.debug - debugging
- ansible.builtin.blockinfile - Ins/Upd/Rem multi-line text
- ansible.builtin.lineinfile - Replace line with regex
- ansible.builtin.pause - wait for n time
- ansible.builtin.wait_for - wait something to happen
- ansible.builtin.find - find folders or file with regex
- ansible.builtin.stat - retries file or file system stats
Ex. Find nexus folder: in opt folder, starts with "nexus-", save in find_results
```yaml
- name: find nexus folder
  hosts: nexus_server
  tasks: 
    - name: Find nexus folder
      ansible.builtin.find: 
        paths: /opt
        pattern: "nexus-*"
        file_type: directory
      register: find_result
```
### Conditional
https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_conditionals.html
Conditional task only executes when condition is met.
"When" keywork is used for conditional. Apply to single task.
```yaml
- name: Download and unpack Nexus installer
  hosts: nexus_server
  tasks: 
    - name: Check nexus folder stats
      ansible.builtin.stat:
        path: /opt/nexus
      register: stat_result
    - name: Find nexus folder from above
    - debug: msg={{stat_result}}
    - name: Rename nexus folder
      ansible.builtin.shell: mv {{find_result.files[0].path}} /opt/nexus
      when: not stat_result.stat.exists        
```

### Where to get info
https://docs.ansible.com/ansible/latest/
choose correct version
look for module index or Indexes of all modules and plugins
may need to add repo before adding adding package manager

**Check if module is installed**: `ansible-galaxy collection list`

### Gather Facts Modules
- automatically called at the begining of task for every play
- gathers is server avail, status, Os, and other that can be used in playbook

### General Attributes
Some attributes are availabe to all modules.
- Async = Async command
- Poll = Polling
- noLog = doesn't log. Used for Sensitive data
- Register = creates variable and assign results to task execution
- Become = Switch user. Default is root

### Other
- Shell module same as command, but access to shell. ie Env, Pipe, and redirect
- command is more secure
- command and shell are not stateful, consider using conditional

## Playbook Examples
- Pay attention on if the modules runs on control or remote host

ex1: Apt update - alt
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

ex1: Deploy nodejs app - combine
```yaml
- name: Deploy nodejs app
  hosts: 123.123.123.12
  tasks:    
    - name: unpack tar
      unarchive:
        src: /user/von/project1/nodejs-app-1.0.0.tgz
        dest: /root/
```

ex1: Start App alt
```yaml
- name: start app
  command: 
    chdir: /root/package/app
    cmd: node server
```

## set interpreter
ansible.cfg
```ini
[default]
interpreter_python = /usr/bin/python3
```

## docker modules
Need to install python docker module
```yaml
    - name: Install docker python module
      ansible.builtin.pip:
        name: 
          - docker
          - docker-compose
```

## Check if have required module 
- `python3 -c "import openshift"` = Check if have openshift python module
- `pip3 install openshift --user` = Install openshift python module
  - pip default required root access
  - `--user` installed to home directory. no special priv

## Other notes
- yum package manager doens't support python3
- Gathering facts is run first. May need to bypass gathering facts if setting interpreter to python3 in config and setting to python2 in playbook vars. `gathering_facts: False`
- some modules can read configs from environment vars.
