
## Install
run as Admin: `wsl --install`

## Check which version of WSL 
You can list your installed Linux distributions and check the version of WSL each is set to by entering the command: `wsl -l -v`

To set the default version to WSL 1 or WSL 2 when a new Linux distribution is installed, use the command: `wsl --set-default-version <Version#>`


## Access file system
WSL mounts your machine's fixed drives under the /mnt/<drive> folder in your Linux distros. For example, your C: drive is mounted under /mnt/c/
