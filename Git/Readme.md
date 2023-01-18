## Init

- `git config --global user.name "John Doe"` = Set Name
- `git config --global user.email johndoe@example.com` = Set Email

## Common
- `git init ` = Initalize directory for git
- `git log` = Display logs
- `git status` = display status of git directory
- `git add -A` = Add all changes in directory
- `git commit -m "commit Message"` = Commits change
- `git commit -am "commit Message"` = Commits change include changed files; not new
- `git clone https://example.com/example/repo.git` = Clone git project.
- `git checkout branch-name` = switch to branch
- `git fetch` = get meta data changes from origin
- `git pull` = get changes from origin
- `git push` =  upload changes from working directory to origin

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


