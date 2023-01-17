
## Secure Sensitive data with Ansible Vault

**ansible-vault file**
- `ansible-vault create filename` = Create new encrypted file
- `ansible-vault view filename` = View Encrypted file
- `ansible-vault edit filename` = Edit Encrypted file

**ansible-vault existing file**
- `ansible-vault encrypt filename` = Encrypt Existing file
  - `--output=new_filename` = encrypt as new file
- `ansible-vault decrypt filename`
  - `--vault-id password` for vault when calling from playbook
  - `--vault-id @prompt` = prompt for value
  - `--vault-id vars@prompt` = Set label and prompt for value
- `ansible-vault rekey filename` = change password for file

**Other**
- `ansible-vault --vault-id vars@prompt --vault-id playbook@prompt site.yaml` = multiple vault password
- yaml tasks `no_log: true` = suppress output
- run without providing password = Attempting to decrypt but no vault secrets found
- `ansible-playbook --ask-vault-pass example.yaml` - call playbook with vault password