# CyberArk Module
All examples use ansible tower

## Link
[Cyberark.pas](https://docs.ansible.com/ansible/latest/collections/cyberark/pas/index.html#plugins-in-cyberark-pas)
[Ansible Galaxy](https://github.com/cyberark/ansible-security-automation-collection/blob/master/docs/cyberark_credential.md)

## cyberark.pas.cyberark_credential
[ex 1 - Greg](https://gregsowell.com/?p=6772)
https://github.com/gregsowell/ansible-cyberark
https://www.youtube.com/watch?v=SAuSRCqlOgI
https://www.youtube.com/watch?v=Hrm-46uDIMk

**Cyberark**
- Create an application
  - can scope to have access to specific vaults
- create certs and associate with application
  - can lockdown to machine
- create policy to access safe

**Ansible Tower**
- Add as Credentials

**Ansible example**
- Greg Mentioned Query is where the magic happens.
```yaml
- name: credential retrieval basic
  hosts: all
  gather_facts: false
  vars:
    ca_base_url: "https://MyPath.com:12345"
  tasks:
    - name: Retrieve pws
      cyberark.pas.cyberark_credential:
        api_base_url: "{{ ca_base_url }}"
        app_id: "testappid"
        query: "safe=test;object={{ inventory_hostname }}"
        validate_certs: no
        client_cert: /user/test001/project1/client.crt
        client_key: /user/test001/project1/client.pem
      register: ca_password
      no_log: true    
    - name: set ansible_password for each host
      set_facts:      
        ansible_user: admin
        ansible_password: "{{ ca_password.result.Content }}"
      no_log: true
```

## cyberark cli tool ??
Is there one?
```yaml
- name: pull in pw
  tasks:
  - name: set ansible_password for each host
    vars: 
      cyquery:
        appid: "testappid"
        query: "safe=test;object={{inventory_hostname}}"
        output: "Password"
    set_facts:
      ansible_user: admin
      ansible_password: "{{ lookup('cyberarkpassword', cyquery) }}"
```


