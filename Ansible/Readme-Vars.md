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