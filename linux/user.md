# Manage User

## notes
**Key Differences: adduser vs. useradd**
- *adduser*: A high-level, interactive script that automatically creates a home directory and sets up the environment for you.
- *useradd*: A low-level utility that doesn't create a home directory or prompt for a password by default; it is typically used for scripting.

## cmd
```sh
# create user
sudo adduser newusername

# add user to sudo group (optional)
sudo usermod -aG sudo newusername

# check user groups
groups newusername

# Delete user
sudo deluser newusername
sudo deluser --remove-home newusername

# Lock user
sudo passwd -l username

# UnLock user
sudo passwd -u username

# Disable Account
sudo usermod -s /usr/sbin/nologin username

# Disable Account - Revert
sudo usermod -s /bin/bash username
```