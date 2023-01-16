# ssh

## Connecting
Connecting via SSH: `ssh username@SSHserver`
- `ssh root@159.89.14.94`= Connect with root user to 159.89.14.94 server address
- `ssh-keygen -t rsa`= Create SSH Key Pair with 'rsa' algorithm. SSH Key Pair is stored to the default location `~/.ssh`
- `ls .ssh/`= Display contents of .ssh folder, which has:
  - `id_rsa` = Private Key
  - `id_rsa.pub` = Public Key
- `ssh -i .ssh/id_rsa root@159.89.14.94` = Connect with root user to 159.89.14.94 server address with specified private key file location (.ssh/id_rsa = default, but you can specify a different one like this)
- `ssh-copy-id root@10.10.10.222` = Command to copy public key to remote server


**Two Files used by SSH:**
- `~/.ssh/known_hosts` = lets the client authenticate the server to check that it isn't connecting to an impersonator
- `~/.ssh/authorized_keys` = lets the server authenticate the user

## New OpenSSH format
- When creating new ssh keys with OpenSSH. Some service may not want the new format
- The new format can be identified when looking at the key.
- new format: `-----BEGIN OPENSSH PRIVATE KEY-----`
- classic format: `-----BEGIN RSA PRIVATE KEY-----`

**Convert it to classic**
ssh-keygen -p -f .ssh/id_rsa -m pem -P "" -N""