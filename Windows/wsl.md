# WSL

## Install
run as Admin: `wsl --install`

## Check which version of WSL 
You can list your installed Linux distributions and check the version of WSL each is set to by entering the command: `wsl --list --verbose`

To set the default version to WSL 1 or WSL 2 when a new Linux distribution is installed, use the command: `wsl --set-default-version <Version#>`

## Access file system
WSL mounts your machine's fixed drives under the /mnt/<drive> folder in your Linux distros. For example, your C: drive is mounted under /mnt/c/

## Windows - Linux Awareness
WSL is aware of windows path. In WSL, when run `explorer.exe .`, the explorer.exe in windows will run.

In a windows command line, can pass info the WSL. Example `dir | wsl grep txt`

## enable systemd
```sh
sudo nano /etc/wsl.conf
```

```ini
[boot]
systemd=true
```

```powershell
wsl.exe --shutdown ubuntu
```

## wsl bash alias
```sh
cd ~
touch .bash_aliases
nano .bash_aliases
```
add to file:
```sh
alias cd..="cd .."
```

## fix dns
- Disable Generate resolv.conf
```ini
[network]
generateResolvConf = false
```
- Update /etc/wsl.conf
```sh
sudo nano /etc/resolv.conf
```
nameserver 8.8.8.8

## override sudo
- open visudo
```sh
sudo visudo
```
- scroll to bottom and add: `linuxadmin ALL=(ALL) NOPASSWD: ALL`
- save and exit

## Unable to open wsl file in vscode
- Open VScode
- Go to Settings `Ctrl + ,`
- add `wsl.localhost` and `wsl$` to Allow UNCHosts
- Restart vscode
