# CyberArk Module

## Link
[Cyberark.pas](https://docs.ansible.com/ansible/latest/collections/cyberark/pas/index.html#plugins-in-cyberark-pas)

## cyberark cli tool
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

## cyberark.pas.cyberark_credential
[ex 1 - Greg](https://gregsowell.com/?p=6772)
Greg Mentioned Query is where the magic happens.
```yaml
- name: pull in pw
  hosts: all
  gather_facts: false
  tasks:
  - name: Retrieve pws
    cyberark.pas.cyberark_credential:
      api_base_url: "{{ ca_base_url }}"
      app_id: "testappid"
      query: "safe=test;object={{inventory_hostname}}"
      validate_certs: no
      client_cert: /user/test001/project1/client.crt
      client_key: /user/test001/project1/client.pem
    register: ca_password
    no_log: true    
  - name: set ansible_password for each host
    set_facts:      
      ansible_password: "{{ ca_password.result.Content }}"
    no_log: true
```



