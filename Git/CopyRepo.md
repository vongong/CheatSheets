# Copy Repo

## Azure 
[Doc Link](https://learn.microsoft.com/en-us/azure/devops/repos/git/move-git-repos-between-team-projects?view=azure-devops)

### Create Dest Repo (empty repo)
- ie DestRepo

### Mirror the repository (Source)
`git clone --mirror <Source Repo URL>`

### Push Repo
`git push --mirror <Dest Repo URL>`
