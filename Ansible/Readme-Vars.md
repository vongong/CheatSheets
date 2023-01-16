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

inline variable 
```yaml
- name: Deploy nodejs app
  hosts: 123.123.123.12
  vars:
    - verion: 1.0.0
  tasks:
    - name: unpack tar
      unarchive:
        src: /user/von/project1/nodejs-app-{{version}}.tgz
        dest: /root/
        remote_src: no
```

parameter variable  
```yaml
- name: Deploy nodejs app
  hosts: 123.123.123.12
  vars:
    - location: /user/von/project1/nodejs-app-1.0.0.tgz
  tasks:
    - name: unpack tar
      unarchive:
        src: "{{location}}"
        dest: /root/
        remote_src: no
```

### Configure from outside of playbook
deploy-node.yaml
```yaml
- name: Deploy nodejs app
  hosts: 123.123.123.12  
  tasks:
    - name: unpack tar
      unarchive:
        src: /user/von/project1/nodejs-app-{{app-version}}.tgz
        dest: /root/
        remote_src: no
```

pass variable from command
```bash
ansible-playbook -i hosts deploy-node.yaml -e "app-version=1.0.0"
```

### variable from external file
project-vars
```yaml
app-version: 1.0.0
user_name: nodeuser
user_home_dir: /home/{{user_name}}
location: /user/von/project1
```

deploy-node.yaml
```yaml
- name: Deploy nodejs app
  hosts: 123.123.123.12  
  vars_file:
    - project-vars
  tasks:
    - name: unpack tar
      unarchive:
        src: "{{location}}/nodejs-app-{{app-version}}.tgz"
        dest: "{{user_home_dir}}"
        remote_src: no
```

```bash
ansible-playbook -i hosts deploy-node.yaml
```

## special variables
https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html

These variables cannot be set directly by the user; Ansible will always override them to reflect internal state.

**Magic variables**
| Variable Name | Desc |
| --- | --- |
| inventory_hostname | The inventory name for the ‘current’ host being iterated over in the play |


## variable precedence
There is a variable precedence least to greater.
https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html#ansible-variable-precedence

Ansible does apply variable precedence, and you might have a use for it. Here is the order of precedence from least to greatest (the last listed variables override all other variables):

1. command line values (for example, -u my_user, these are not variables)
1. role defaults (defined in role/defaults/main.yml) 
1. inventory file or script group vars 
1. inventory group_vars/all
1. playbook group_vars/all 
1. inventory group_vars/* 
1. playbook group_vars/* 
1. inventory file or script host vars 
1. inventory host_vars/* 
1. playbook host_vars/* 
1. host facts / cached set_facts 
1. play vars
1. play vars_prompt
1. play vars_files
1. role vars (defined in role/vars/main.yml)
1. block vars (only for tasks in block)
1. task vars (only for the task)
1. include_vars
1. set_facts / registered vars
1. role (and include_role) params
1. include params
1. extra vars (for example, -e "user=my_user")(always win precedence)