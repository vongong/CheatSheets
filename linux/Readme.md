
## Basic Command

**Directory Operatings:**
- `pwd` = Show current directory. Example Output: `/home/nana`
- `ls` = List folders and files. Example Output: `Desktop  Downloads  Pictures  Documents`
- `cd [dirname]` = Change directory to [dir]
- `mkdir [dirname]` = Make directory [dirname]
- `cd ..` = Go up a directory

**File Operations:**
- `touch [filename]` = Create [filename]
- `rm [filename]` = Delete [filename]
- `rm -r [dirname]` = Delete a non-empty directory and all the files in it
- `rm -d [dirname]` or `rmdir [dirname]` = Delete an empty directory

**Navigating in the File System:**
- `cd usr/local/bin` = Navigate multiple dirs (relative path - relative to current dir). Move to bin directory
- `cd ../..` = Move up 2 hierarchies, so go to 'usr' directory
- `cd /usr` = Alternative to go to 'usr' directly (absolute path)
- `cd [absolute path]` = Move to any location by providing the full path
- `cd /home/nana` = Go to my home directory (absolute path)
- `cd ~` = Shortcut alternative to go to home directory
- `ls /etc/network` = List folders and files of 'network' directory

**More File and Directory Operations**
- `mv [filename] [new_filename]` = Rename the file to a new file name
- `cp -r [dirname] [new_dirname]` = Copy dirname to new_dirname recursively meaning including the files
- `cp [filename] [new_filename]` = Copy filename to new_filename

**Other**
- `clear` = Clears the terminal
- `cat [filename]` = Display the file content
- `ls -R [dirname]` = Show dirs and files but also sub dirs and files
- `ls -a` = See hidden files too
- `history` = Gives a list of all past commands typed in the current terminal session
- `history 20` = Show list of last 20 commands

**Display OS Information**
- `uname -a` = Show system and kernel
- `cat /etc/os-release` =  Show OS information
- `lscpu` = Display hardware information, e.g. how many CPU you have etc.
- `lsmem` = Display memory information

**APT Package Manager:**
- `sudo apt search [package_name]` = Search for a given package
- `sudo apt install [package_name]` = Install a given package
- `sudo apt install [package_name] [package_name2]` = Install multiple packages with one command
- `sudo apt remove [package_name]` = Remove installed package
- `sudo apt update` = Updates the package index. Pulls the latest change sfrom the APT repositories

**Locations of Access Control Files:**
- /etc/passwd
- /etc/shadow
- /etc/group
<!-- -->
- `sudo adduser [username]` = Create a new user
- `sudo passwd [username]` = Change password of a user
- `su - [username]` = Login as username ('su' = short for substitute or switch user)
- `su -` = Login as root
<!-- -->
- `sudo groupadd [groupname]` = Create new group (System assigns next available GID)
- `sudo adduser [username]` = Switch to Insert Mode

**Existing Environment Variables:**
- `SHELL=/bin/bash`= default shell program, in this case bash
- `HOME=/home/nana`= current user's home directory
- `USER=nana` = currently logged in user
<!-- -->
- `printenv` = List all environment variables
- `printenv | less` = List all environment variables with less program
- `printenv [environment variable]` = Display value of given environment variable, e.g. `printenv USER`
- `printenv | grep USER` = Filter environment variables, which have 'USER' in the name
<!-- -->
- `echo $USER` = Print value of USER environment variable

**Create own Environment Variables:**
- `export DB_USERNAME=dbuser` = Set environment variable 'DB_USERNAME' with value 'dbuser'
- `export DB_PASSWORD=secretpwdvalue` = Set environment variable 'DB_PASSWORD' with value 'secretpwdvalue'
- `export DB_NAME=mydb` = Set environment variable 'DB_NAME' with value 'mydb'
- `printenv | grep DB` = Filter environment variables for 'DB' characters
- `export DB_NAME=newdbname` = Set environment variable 'DB_NAME' to new value 'newdbname'

**Delete Environment Variables:**
- `unset DB_NAME` = Delete variable with name 'DB_NAME'

**Useful Networking Commands:**
- `ip`= one of the basic commands. For setting up new systems and assigning IPs to troubleshooting existing systems. Can show address information, manipulate routing, plus display network various devices, interfaces, and tunnels.
- `ifconfig`= for configuring and troubleshooting networks. It has since been replaced by the `ip` command
- `netstat`= tool for printing network connections, routing tables, interface statistics, masquerade connections, and multicast memberships
- `ps aux` =
  - ps = displays information about a selection of the active processes
  - a = show processes for all users
  - u = display the process's user/owner
  - x = also show processes not attached to a terminal
- `nslookup` = Find DNS related query
- `ping` = To check connectivity between two nodes

## Sed 
```sh
sed -i 's/old-text/new-text/g' input.txt
```

## find nginx service 
```sh
ps aux | grep nginx
```
