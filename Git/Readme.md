## Init

- `git config --global user.name "John Doe"` = Set Name
- `git config --global user.email johndoe@example.com` = Set Email
- `git config --list ` = View Config

## different enviroment
- `working` = dir
- `staging` = git status
- `commit` = git commit; git log;

## Common
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
- `git diff` = see changes
- `git fetch` = get meta data changes from origin
- `git pull` = get changes from origin
- `git push` =  upload changes from working directory to origin
  - `git push -- all` = push all branch

## Branch
- `git branch` = get branch names
- `git branch new-branch-name` = create branch names
- `git switch -c new-branch-name` = create new branch names and switch to it
- `git branch -d branch-name` = delete branch names

## restore
- `git restore --staged index.html` = unstage index.html
- `git restore --staged *.css` = unstage multiple files
- `git restore index.html` = discard umcommited change
- `git restore --source 7173808e index.html` = restore file from specific commit
- `git restore --source main~2 index.html` = restore file from 2 commits before HEAD of the main branch

## Remote
- `git remote add origin https://github.com/example/repo.git` = adds origin remote
- `git remote set-url origin https://github.com/example/repo.git` = updates origin remote

## stash
- `git stash save "comment on save"` = add files to stash and name it
- `git stash -u`      = Add Untracked files files
- `git stash list`    = List stash id and comments
- `git stash apply 0` = Apply from list, left in stash
- `git stash pop`     = Apply from list, remove from stash
- `git stash drop 0`  = Remove from stash
- `git stash clear`   = Remove all stashes

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


