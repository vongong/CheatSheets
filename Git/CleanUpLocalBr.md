# Clean up local branches

```sh
# Fetch and prune remote-tracking branches
git fetch --prune

# List local branches and their upstream status
git branch -vv

# Identify local branches marked as [gone] and delete them
git branch -d local-branch-name-that-is-gone

# The "git error: the branch is not fully merged" message typically appears when attempting to delete a local branch. Force deletion (if confident about merged status).
git branch -D local-branch-name-that-is-gone

```