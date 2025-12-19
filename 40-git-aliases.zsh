# ~/.oh-my-zsh/custom/40-git-aliases.zsh
# Git simple aliases and shortcuts

# ===============================
# GIT ALIASES
# ===============================
alias g='git'
alias gs='git status'
alias gss='git status --short'
alias ga='git add'
alias gaa='git add .'
alias gap='git add -p'

# Commits
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git commit -a -m'
alias gcem='git commit --amend'
alias gcnem='git commit --amend --no-edit'

# Push/Pull
alias gp='git push'
alias gpo='git push origin'
alias gpom='git push origin main'
alias gpf='git push --force-with-lease'
alias gpl='git pull'
alias gplo='git pull origin'
alias gplom='git pull origin main'
alias gplr='git pull --rebase'

# Branches
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcom='git checkout main'
alias gcod='git checkout develop'
alias gsw='git switch'
alias gswc='git switch -c'

# Merging & Rebasing
alias gm='git merge'
alias gmnf='git merge --no-ff'
alias gr='git rebase'
alias gri='git rebase -i'
alias grc='git rebase --continue'
alias gra='git rebase --abort'

# Diffs & Logs
alias gd='git diff'
alias gds='git diff --staged'
alias gdh='git diff HEAD'
alias gl='git log'
alias glo='git log --oneline'
alias glg='git log --graph --oneline --decorate --all'
alias gls='git log --stat'
alias glp='git log -p'

# Stash
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gstd='git stash drop'
alias gsts='git stash show'
alias gstk='git stash -k'

# Remote & Fetch
alias gf='git fetch'
alias gfa='git fetch --all'
alias grao='git remote add origin'
alias grv='git remote -v'
alias grs='git remote show'

# Reset & Clean
alias grh='git reset HEAD'
alias grhard='git reset --hard'
alias grsoft='git reset --soft'
alias gclean='git clean -fd'
alias gprune='git remote prune origin'

# Show & Blame
alias gsh='git show'
alias gbl='git blame'
alias gwt='git worktree'
alias gback='git checkout -'
