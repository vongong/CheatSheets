# Git

## different enviroment
- `working` = dir
- `staging` = git status
- `commit` = git commit; git log;

## .git folder
this folder stores the repo.
- HEAD = Link to point in history
- Config = holds config data
- log = created on the fly summary of history
- object = past versions compressed into folder/subfolder
  - use SHA1 for hash
  - `git cat-file <parameter> <hash>` = get hash info
    - `-t` = type
    - `-p` = print info 
    - parent = hash of parent of the hash
    - tree = hash of files in object
  - subfolder of first 2 char of hash


## Commands

### Init
- `git config --global user.name "John Doe"` = Set Name
- `git config --global user.email johndoe@example.com` = Set Email
- `git config --list ` = View Config
- `git config --global core.editor "nano"`
  - Add to path: `C:\Program Files\Git\usr\bin`

### Common
- `git help [command]` = Get Help on command
- `git init ` = Initalize directory for git
- `git log` = Display logs
  - `git log --oneline` = Display logs overview
  - `git log -p` = Display logs details
  - `git status` = display status of git directory
- `git add filename` = Add file changes to Staging
  - `git add -A` = Add all changes in project to Staging
  - `git add .` = Add all changes in directory to Staging
- `git commit -m "commit Message"` = Commits staged change
- `git commit -am "commit Message"` = Commits change include changed files; not new
- `git clone https://example.com/example/repo.git` = Clone git project.
- git checkout split into switch and restore 
  - `git switch branch-name` = switch to branch
  - `git restore filename` = restore filename
- `git fetch` = get meta data changes from origin
- `git pull` = get changes from origin
- `git push` =  upload changes from working directory to origin
  - `git push -- all` = push all branch

### Branch
- `git branch` = get branch names
- `git branch -a` = all
- `git branch new-branch-name` = create branch names
- `git branch -c new-branch-name` = create new branch names and switch to it
- `git branch -d branch-name` = delete branch names
- `git branch -v` = verbose

### Reset
- `git reset --soft HEAD~1` = Undo last git commit; keep changes in working dir
- `git reset --hard HEAD~1` = Undo last git commit; discard changes

### Restore
- `git restore --staged index.html` = unstage index.html
- `git restore --staged *.css` = unstage multiple files
- `git restore index.html` = discard umcommited change
- `git restore --source 7173808e index.html` = restore file from specific commit
- `git restore --source main~2 index.html` = restore file from 2 commits before HEAD of the main branch

### Remote
- `git remote add origin https://github.com/example/repo.git` = adds origin remote
- `git remote set-url origin https://github.com/example/repo.git` = updates origin remote

### Stash
- `git stash save "comment on save"` = add files to stash and name it
- `git stash -u`      = Add Untracked files files
- `git stash list`    = List stash id and comments
- `git stash apply 0` = Apply from list, left in stash
- `git stash pop`     = Apply from list, remove from stash
- `git stash drop 0`  = Remove from stash
- `git stash clear`   = Remove all stashes

### Diff
- `git diff branch1...branch2` = see diff between branches
- `git diff main new_branch ./diff_test.txt` = see diff in file between 2 branches

### Alias
**Command:**
- git config --global alias.ft fetch
- git config --global alias.cm "commit -m"
- git config --global alias.aa "add -A"
- git config --global alias.sw switch

**get config:** git config --list --show-origin

**Add to File:** ~/.gitconfig
```ini
[alias]
	aa = !git add -A && git status
	st = status
	cm = commit -m
	ft = fetch
	sw = switch
	co = checkout
	br = branch
```


## Merge
**Merge Hotfix into main branch**
```sh
git checkout main
git merge hotfix
```

**Merge main branch into work-branch**
```sh
git fetch
git pull
git checkout work-branch
git merge main
```

**Merge Conflict**
Look at files that were identified. They will have sections with markers like `<<<<<<<`, `=======`, and `>>>>>>>`. Fix the section and completely removed those markers. You can run `git status` again to verify that all conflicts have been resolved. Once verified that everything that had conflicts has been staged, you can type `git commit` to finalize the merge commit.


## unset credentials
- Use Windows Credential Manager
- cmd:
```sh
git config --system --unset credential.helper
```

## Windows Install
Bash `.\Bin` files are included with windows Git install. See `C:\Program Files\Git\usr\bin` for programs like `nano.exe`, `grep.exe`, and the like.

The `git.exe` and `bash.exe` are found in `C:\Program Files\Git\bin`.