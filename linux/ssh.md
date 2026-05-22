# ssh

## ssh key permission
- **Private Key**: chmod 600 ~/.ssh/id_rsa (Only the owner can read and write; required for SSH to function)
- **.SSH Directory**: chmod 700 ~/.ssh (Only the owner can enter and list the contents of the folder).
- **Public Key**: chmod 644 ~/.ssh/id_rsa.pub (Owner can read/write; others can read only).

## Commands
```sh
# Generate 
## Current best algorithm is ed25519 (prev was rsa)
## ~/.ssh/ed25519 = Private Key
## ~/.ssh/ed25519.pub = Public Key
ssh-keygen -t ed25519 -C "comment-on-key"

# Connect to server
ssh user1@159.89.14.94

# Copy Pubic Key to server
## This is a script; won't work in Win
## Append Public key to ~/.ssh/authorized_keys on Server
ssh-copy-id -i ~/.ssh/ed25519.pub user1@159.89.14.94

# Connect to server with ssh key
ssh -i ~/.ssh/ed25519.pub user1@159.89.14.94

# Remove host from Known_hosts
ssh-keygen -R $hostname_or_ip

# ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/ed25519
ssh-add -l # Verify
```

### Powershell ssh-agent
```powershell
# Set the service to start automatically (recommended) or manually
Get-Service ssh-agent | Set-Service -StartupType Automatic

# Start the service
Start-Service ssh-agent

# Add your default key
ssh-add $env:USERPROFILE\.ssh\id_ed25519
```


## Two Files used by SSH
- `~/.ssh/known_hosts` = lets the client authenticate the server to check that it isn't connecting to an impersonator
- `~/.ssh/authorized_keys` = lets the server authenticate the user

## New OpenSSH format
- When creating new ssh keys with OpenSSH. Some service may not want the new format
- The new format can be identified when looking at the key.
- new format: `-----BEGIN OPENSSH PRIVATE KEY-----`
- classic format: `-----BEGIN RSA PRIVATE KEY-----`