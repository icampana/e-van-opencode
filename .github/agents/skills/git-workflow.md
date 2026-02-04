# Git Workflow Skill

This skill helps work effectively with Git for version control.

## Purpose

Manage code changes using Git best practices for clean history and effective collaboration.

## Common Git Workflows

### Basic Workflow
```bash
# 1. Check status
git status

# 2. View changes
git diff

# 3. Stage changes
git add path/to/file
git add .  # Add all changes

# 4. Commit
git commit -m "Brief description of changes"

# 5. Push
git push origin branch-name
```

### Feature Branch Workflow
```bash
# 1. Create and switch to feature branch
git checkout -b feature/new-feature

# 2. Make changes and commit
git add .
git commit -m "Add new feature"

# 3. Push branch
git push origin feature/new-feature

# 4. Create pull request (on GitHub)

# 5. After PR is merged, clean up
git checkout main
git pull origin main
git branch -d feature/new-feature
```

### Working with Existing Branch
```bash
# 1. Fetch latest changes
git fetch origin

# 2. Switch to branch
git checkout branch-name

# 3. Pull latest changes
git pull origin branch-name

# 4. Make changes and push
git add .
git commit -m "Update feature"
git push origin branch-name
```

## Commit Messages

### Format
```
<type>: <brief description>

<optional detailed description>

<optional footer>
```

### Types
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

### Examples
```bash
# Good commit messages
git commit -m "feat: Add user authentication"
git commit -m "fix: Handle null values in parser"
git commit -m "docs: Update API documentation"
git commit -m "refactor: Extract validation logic"

# Bad commit messages
git commit -m "changes"
git commit -m "fix stuff"
git commit -m "WIP"
```

## Viewing History

### Check Logs
```bash
# View commit history
git log

# View compact history
git log --oneline

# View last N commits
git log -5

# View changes in commits
git log -p

# View specific file history
git log -- path/to/file
```

### View Specific Commit
```bash
# Show commit details
git show <commit-hash>

# Show specific file in commit
git show <commit-hash>:path/to/file

# Show changes in commit
git show <commit-hash> --stat
```

### Blame (Find who changed what)
```bash
# See who last modified each line
git blame path/to/file

# Blame specific lines
git blame -L 10,20 path/to/file
```

## Branch Management

### List Branches
```bash
# List local branches
git branch

# List all branches (local + remote)
git branch -a

# List remote branches
git branch -r
```

### Create and Delete Branches
```bash
# Create branch
git branch branch-name

# Create and switch to branch
git checkout -b branch-name

# Delete local branch
git branch -d branch-name

# Force delete branch
git branch -D branch-name

# Delete remote branch
git push origin --delete branch-name
```

### Switch Branches
```bash
# Switch to existing branch
git checkout branch-name

# Switch to main/master
git checkout main

# Switch to previous branch
git checkout -
```

## Undoing Changes

### Unstage Files
```bash
# Unstage specific file
git reset path/to/file

# Unstage all files
git reset
```

### Discard Changes
```bash
# Discard changes in working directory
git checkout -- path/to/file

# Discard all changes
git checkout -- .

# Modern way (Git 2.23+)
git restore path/to/file
```

### Amend Last Commit
```bash
# Change last commit message
git commit --amend -m "New message"

# Add more changes to last commit
git add forgotten-file.js
git commit --amend --no-edit
```

### Revert Commit
```bash
# Create new commit that undoes changes
git revert <commit-hash>

# Revert without committing
git revert --no-commit <commit-hash>
```

## Checking Status

### Status
```bash
# See changed files
git status

# Short format
git status -s

# Show branch info
git status -sb
```

### Diff
```bash
# See unstaged changes
git diff

# See staged changes
git diff --staged

# See changes in specific file
git diff path/to/file

# Compare branches
git diff main..feature-branch
```

## Remote Operations

### Fetch and Pull
```bash
# Fetch changes from remote
git fetch origin

# Pull changes from remote
git pull origin branch-name

# Pull and rebase
git pull --rebase origin branch-name
```

### Push
```bash
# Push to remote branch
git push origin branch-name

# Push and set upstream
git push -u origin branch-name

# Push all branches
git push --all origin
```

## Stashing Changes

### Save Work Temporarily
```bash
# Stash current changes
git stash

# Stash with message
git stash save "WIP: working on feature"

# Stash including untracked files
git stash -u
```

### Apply Stashed Changes
```bash
# List stashes
git stash list

# Apply latest stash
git stash apply

# Apply specific stash
git stash apply stash@{1}

# Apply and remove from stash
git stash pop
```

### Manage Stashes
```bash
# Show stash contents
git stash show

# Show detailed stash contents
git stash show -p

# Delete stash
git stash drop stash@{0}

# Clear all stashes
git stash clear
```

## Best Practices

### Commit Often
- Make small, focused commits
- Commit logical units of work
- Don't commit broken code

### Write Good Messages
- Be descriptive but concise
- Use imperative mood ("Add feature" not "Added feature")
- Explain why, not just what

### Keep History Clean
- Use meaningful branch names
- Squash commits before merging if needed
- Don't commit generated files

### Sync Regularly
- Pull changes frequently
- Push your work daily
- Resolve conflicts early

## Troubleshooting

### Merge Conflicts
```bash
# See conflicted files
git status

# Open files and resolve conflicts
# Look for <<<<<<< and >>>>>>>

# After resolving
git add resolved-file.js
git commit
```

### Recover Lost Commits
```bash
# View all commits including lost ones
git reflog

# Recover lost commit
git checkout <commit-hash>
git branch recovered-branch
```

### Fix Wrong Branch
```bash
# Committed to wrong branch
git checkout correct-branch
git cherry-pick <commit-hash>
git checkout wrong-branch
git reset --hard HEAD~1
```

## Configuration

### User Info
```bash
# Set name and email
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# View config
git config --list
```

### Aliases
```bash
# Create useful aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.lg "log --oneline --graph"
```

## Usage

Use this skill whenever you need to:
- Make commits
- Create or switch branches
- View history or changes
- Undo or fix mistakes
- Sync with remote repository
- Resolve conflicts
