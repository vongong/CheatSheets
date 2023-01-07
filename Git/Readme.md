## Init
```sh
git config --global user.name "John Doe"
git config --global user.email johndoe@example.com
```

## Common
```sh
git init 
git log
git status
git add -A
git commit -m "commit Message"
git push
git fetch
git pull
```

## Remote
```sh
git remote add origin https://github.com/example/repo.git
git remote set-url origin https://github.com/example/repo.git
```

## stash
```sh
git stash save "comment on save"
git stash -u        //Untracked files files
git stash list      //List stash id and comments
git stash apply 0   //Apply from list, left in stash
git stash pop       //Apply from list, remove from stash
git stash drop 0    //Remove from stash
git stash clear    //Remove all stashes
```

## Pull master into branch
```sh
git checkout dmgr2      # gets you "on branch dmgr2"
git fetch origin        # gets you up to date with origin
git merge origin/master
```