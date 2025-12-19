# ~/.oh-my-zsh/custom/01-consolidated-aliases.zsh

# Powerlevel10k instant prompt compatibility - MUST BE FIRST
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# ===============================
# CLEAR CONFLICTING ALIASES FIRST (MUST BE EARLY)
# ===============================
# Clear any conflicting aliases from oh-my-zsh plugins BEFORE defining functions
{
    unalias gcp gcpp gclone gnew gundo gsync gfeat gfix gdocs gstyle grefactor gtest 2>/dev/null || true
    unalias gpush gpull gsquash gcleanup gfzf glog gblame 2>/dev/null || true
    unalias gwip gunwip gwrongbranch gnuke gcompare gback gmergetool 2>/dev/null || true
    unalias mkcd take up fcd proj bookmark listbookmarks 2>/dev/null || true
    unalias ff fdir ffile ftype extract archive backup large duplicates info 2>/dev/null || true
    unalias dbash dsh dcleanup dwatch dstats kexec kpf klog 2>/dev/null || true
    unalias psg ports sysinfo topcpu topmem netdiag 2>/dev/null || true
    unalias weather genpass qrcode shorten serve killport fkill 2>/dev/null || true
    unalias note notes searchnotes clearnotes task tasks taskdone 2>/dev/null || true
    unalias deps devdeps scripts loc todos testfile format 2>/dev/null || true
    unalias httpget httppost api myip portscan json search replace 2>/dev/null || true
    unalias clean hosts fstab sudoers own 2>/dev/null || true
    unalias kernel now nowdate timestamp week calc random listening 2>/dev/null || true
    unalias reload rl c cls clr h hg dirsize help 2>/dev/null || true
    unalias pw prun psize pinfo pcreate pworkspace pcd 2>/dev/null || true
} &>/dev/null

# ===============================
# ADDITIONAL DIRECTORY SHORTCUTS
# ===============================

# More document shortcuts
alias doc='cd ~/Documents'
alias dt='cd ~/Desktop'

# Programming directories (assuming they're in ~/Documents)
alias pms='cd ~/Documents/Programmin\ Shit/'
# REMOVED: alias code='cd ~/Documents/Programmin\ Shit/'  # Conflicts with VS Code CLI
alias cdev='cd ~/Documents/Programmin\ Shit/'  # Use 'cdev' instead
alias dev='cd ~/Documents/Programmin\ Shit/' 
alias repos='cd ~/Documents/Programmin\ Shit/'

# Common system directories
alias apps='cd /Applications'
alias bin='cd /usr/local/bin'
alias etc='cd /etc'
alias var='cd /var'
alias opt='cd /opt'
alias usr='cd /usr'

# User directories
alias lib='cd ~/Library'
alias pics='cd ~/Pictures'
alias music='cd ~/Music'
alias movies='cd ~/Movies'
alias pub='cd ~/Public'

# macOS specific useful directories
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias appsupp='cd ~/Library/Application\ Support'
    alias prefs='cd ~/Library/Preferences'
    alias logs='cd ~/Library/Logs'
    alias caches='cd ~/Library/Caches'
fi

# Cloud storage shortcuts (adjust paths as needed)
alias icloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias dropbox='cd ~/Dropbox'
alias gdrive='cd ~/Google\ Drive'
alias onedrive='cd ~/OneDrive'

# Web development specific
alias www='cd ~/Documents/Web'
alias sites='cd ~/Documents/Sites'
alias webdev='cd ~/Documents/WebDev'

# Mobile development
alias mobile='cd ~/Documents/Mobile'
alias ios='cd ~/Documents/iOS'
alias android='cd ~/Documents/Android'

# Configuration directories
alias config='cd ~/.config'
alias zsh='cd ~/.oh-my-zsh'

# ===============================
# PRIVILEGES INTEGRATION (ENHANCED)
# ===============================

# Enhanced sudo function with Privileges CLI integration
sudo() {
    # Check if privilegescli is available
    if command -v privilegescli &> /dev/null; then
        # Check if we already have admin privileges using privilegescli
        if privilegescli -s &>/dev/null; then
            # Already have privileges, just run sudo
            command sudo "$@"
            return
        else
            # Request admin privileges using CLI
            echo "Requesting admin privileges..."
            if privilegescli -a; then
                # Brief wait for privileges to be granted
                sleep 0.5
                # Execute the original sudo command
                command sudo "$@"
            else
                echo "Failed to obtain admin privileges"
                return 1
            fi
        fi
    else
        # Fallback to GUI method if CLI not available
        # Check if we already have admin privileges
        if groups | grep -q admin && command sudo -n true 2>/dev/null; then
            # Already have privileges, just run sudo
            command sudo "$@"
            return
        fi
        # Check if Privileges app is installed
        if ! [ -d "/Applications/Privileges.app" ]; then
            echo "Neither Privileges CLI nor GUI app found. Please install Privileges first."
            return 1
        fi
        # Only open Privileges if we don't have admin rights
        open -a "Privileges" 2>/dev/null
        # Request admin privileges automatically using AppleScript (silently)
        osascript >/dev/null 2>&1 <<EOF
tell application "Privileges"
    activate
    delay 0.5
    tell application "System Events"
        tell process "Privileges"
            try
                click button "Request Privileges" of window 1
            on error
            end try
        end tell
    end delay 1
end tell
EOF
        # Brief wait for privileges to be granted
        sleep 1.5
        # Execute the original sudo command
        command sudo "$@"
    fi
}

# Legacy command-line interface support (if available)
if command -v privilegescli &> /dev/null; then
    alias admin='privilegescli -a'
    alias noadmin='privilegescli -d'
    alias amiadmin='privilegescli -s'
    PRIVILEGES_AVAILABLE=true
else
    PRIVILEGES_AVAILABLE=false
fi

# Universal sudo shortcuts (now enhanced)
alias s='sudo'
alias please='sudo'
alias fuck='sudo'

# ===============================
# KUBERNETES (ENHANCED)
# ===============================
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deployment'
alias kgn='kubectl get nodes'
alias kga='kubectl get all'
alias kgns='kubectl get namespaces'

# Apply/Delete
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kdel='kubectl delete'

# Describe
alias kdp='kubectl describe pod'
alias kds='kubectl describe svc'
alias kdd='kubectl describe deployment'

# Logs & Exec
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias kex='kubectl exec -it'
alias ksh='kubectl exec -it'

# Context & Namespace
alias kctx='kubectl config current-context'
alias kns='kubectl config set-context --current --namespace'
alias ctx='kubectx'
alias ns='kubens'

# Enhanced shortcuts
# kpf defined as function below for enhanced port forwarding
alias kgpw='kubectl get pods -o wide'
alias kgpg='kubectl get pods | grep'
alias kgsg='kubectl get svc | grep'
alias kwatch='kubectl get pods -w'
alias kgpy='kubectl get pods -o yaml'
alias kgpj='kubectl get pods -o json'

# ===============================
# GIT (ENHANCED WORKFLOW)
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

# ===============================
# DOCKER (ENHANCED)
# ===============================
alias d='docker'
alias dc='docker compose'
alias dcu='docker compose up'
alias dcud='docker compose up -d'
alias dcd='docker compose down'
alias dcb='docker compose build'
alias dcr='docker compose restart'
alias dcl='docker compose logs'
alias dclf='docker compose logs -f'
alias dcps='docker compose ps'
alias dce='docker compose exec'

# Container management
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dstop='docker stop'
alias dstart='docker start'
alias drestart='docker restart'

# System management
alias dprune='docker system prune'
alias dprunea='docker system prune -a'
alias ddf='docker system df'
alias dinfo='docker system info'

# Execution
alias dexec='docker exec -it'
alias drun='docker run -it --rm'
alias drund='docker run -d'

# Logs
alias dlogs='docker logs'
alias dlogsf='docker logs -f'
alias dlogst='docker logs --tail'

# Inspection
alias dins='docker inspect'
alias dport='docker port'
alias dnet='docker network ls'
alias dvol='docker volume ls'

# ===============================
# PNPM ALIASES (PRIMARY PACKAGE MANAGER)
# ===============================
alias p='pnpm'
alias pi='pnpm install'
alias pa='pnpm add'
alias pad='pnpm add --save-dev'
alias pag='pnpm add --global'
alias pr='pnpm run'
alias pstart='pnpm start'
alias pt='pnpm test'
alias pb='pnpm build'
alias pwatch='pnpm run watch'
alias pdev='pnpm run dev'
alias plint='pnpm run lint'
alias pf='pnpm run format'
alias pup='pnpm update'
alias pout='pnpm outdated'
alias prm='pnpm remove'

# pnpm shortcuts
alias px='pnpm exec'
alias pdlx='pnpm dlx'  # equivalent to npx
alias pls='pnpm list'
alias pwhy='pnpm why'

# pnpm workspace shortcuts  
alias pw='pnpm -w'  # workspace root
alias pwa='pnpm -w add'  # add to workspace root
alias pwr='pnpm -w run'  # run script in workspace root
alias pwls='pnpm -r list'  # list all packages in workspace
alias pwrun='pnpm -r run'  # run script in all packages

# Legacy npm/yarn (for when you encounter non-pnpm projects)
alias n='npm'
alias ni='npm install'
alias nr='npm run'
alias nt='npm test'
alias nb='npm run build'
alias ndev='npm run dev'

alias y='yarn'
alias ya='yarn add'
alias yr='yarn run'
alias ys='yarn start'
alias yt='yarn test'
alias yb='yarn build'

# Python
alias py='python3'
alias pip='pip3'
alias pipi='pip3 install'
alias pipu='pip3 install --upgrade'
alias pipf='pip3 freeze'
alias pipr='pip3 install -r requirements.txt'
alias venv='python3 -m venv'
alias venvon='source venv/bin/activate'
alias venvoff='deactivate'

# ===============================
# FILE SYSTEM & NAVIGATION
# ===============================
alias ll='ls -lahF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -lhtrF'
alias lz='ls -lhSrF'
alias lx='ls -lhAXF'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# Quick directories
alias desk='cd ~/Desktop'
alias docs='cd ~/Documents'
alias dl='cd ~/Downloads'
alias home='cd ~'
alias tmp='cd /tmp'

# SAFER OPERATIONS - Use command prefix to bypass in scripts
# These add safety for interactive use but won't break scripts that use 'command cp'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'
alias ln='ln -v'

# Permissions
alias chx='chmod +x'
alias 755='chmod 755'
alias 644='chmod 644'
alias 600='chmod 600'

# Archive operations
alias tarx='tar -xvf'
alias tarc='tar -cvf'
alias tarz='tar -czvf'
alias untar='tar -xvf'

# Utilities
alias mk='mkdir -p'
alias path='echo $PATH | tr ":" "\n"'
alias which='type -a'
alias count='find . -type f | wc -l'
alias countdir='find . -type d | wc -l'
alias size='du -sh'
alias dsize='du -sh .'

# ===============================
# SYSTEM & PROCESS MANAGEMENT
# ===============================
alias psa='ps aux'
alias psc='ps aux --sort=-%cpu | head'
alias psm='ps aux --sort=-%mem | head'
alias kill9='kill -9'
alias killall='killall'

# System info
alias arch='uname -m'
alias distro='cat /etc/*-release'
alias meminfo='cat /proc/meminfo'
alias cpuinfo='cat /proc/cpuinfo'

# History
alias histdel='history -d'
alias histclean='history -c'

# ===============================
# MACOS SPECIFIC
# ===============================
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS specific
    alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
    alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
    alias emptytrash='rm -rf ~/.Trash/*'
    alias finder='open -a Finder'
    alias preview='open -a Preview'
    # VS Code - only if 'code' command doesn't exist
    if ! command -v code &> /dev/null; then
        alias code='open -a "Visual Studio Code"'
    fi
    
    # Clipboard
    alias copy='pbcopy'
    alias paste='pbpaste'
    
    # Network
    alias flush='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
fi

# ===============================
# ENHANCED FUNCTIONS (REPLACING CONFLICTING ALIASES)
# ===============================

# ===============================
# NAVIGATION & FILE MANAGEMENT
# ===============================

# Enhanced navigation
mkcd() { mkdir -p "$1" && cd "$1"; }
take() { mkcd "$1"; }
up() { cd $(printf "%0.s../" $(seq 1 ${1:-1})); }

# Smart directory navigation with fuzzy finder
fcd() {
    if command -v fzf &> /dev/null; then
        if command -v fd &> /dev/null; then
            local dir=$(fd -t d | fzf --preview 'ls -la {}')
        else
            local dir=$(find . -type d | fzf --preview 'ls -la {}')
        fi
        [[ -n "$dir" ]] && cd "$dir"
    else
        echo "fzf not available"
    fi
}

# Project navigation with fuzzy finder
proj() {
    if [[ -n "$1" ]]; then
        cd ~/Projects/"$1"
    else
        if [[ -d ~/Projects ]]; then
            if command -v fzf &> /dev/null; then
                local project=$(find ~/Projects -maxdepth 1 -type d | fzf)
                [[ -n "$project" ]] && cd "$project"
            else
                cd ~/Projects
            fi
        else
            echo "Projects directory not found"
        fi
    fi
}

# Directory bookmarks
bookmark() {
    local name=${1:-$(basename $PWD)}
    echo "$PWD" > ~/.bookmark_$name
    echo "Bookmarked current directory as '$name'"
}

listbookmarks() {
    echo "Available bookmarks:"
    for bookmark in ~/.bookmark_*; do
        if [[ -f "$bookmark" ]]; then
            local name=$(basename "$bookmark" | sed 's/^\.bookmark_//')
            local path=$(cat "$bookmark")
            echo "  $name -> $path"
        fi
    done
}

# ===============================
# FILE OPERATIONS
# ===============================

# Smart file finder with preview
ff() {
    if command -v fzf &> /dev/null; then
        if command -v fd &> /dev/null; then
            fd "$1" | fzf --preview 'bat --color=always {} 2>/dev/null || ls -la {}'
        else
            find . -name "*$1*" -type f | fzf --preview 'bat --color=always {} 2>/dev/null || ls -la {}'
        fi
    else
        if command -v fd &> /dev/null; then
            fd "$1"
        else
            find . -name "*$1*" -type f
        fi
    fi
}

# Find directories
fdir() {
    find . -type d -name "*$1*"
}

# Find files by name
ffile() {
    find . -type f -name "*$1*"
}

# Find files by extension
ftype() {
    local ext="$1"
    find . -name "*.$ext" -type f
}

# Universal archive extractor
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "Cannot extract '$1'" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Create archive
archive() {
    local name="$1"
    local target="$2"
    
    if [[ -z "$target" ]]; then
        target="$name"
        name="$(basename "$target")"
    fi
    
    case "$name" in
        *.tar.gz|*.tgz) tar czf "$name" "$target" ;;
        *.tar.bz2|*.tbz2) tar cjf "$name" "$target" ;;
        *.zip) zip -r "$name" "$target" ;;
        *.7z) 7z a "$name" "$target" ;;
        *) echo "Unsupported archive format" ;;
    esac
}

# Smart backup with rotation
backup() {
    local item="$1"
    local keep=${2:-5}
    local timestamp=$(date +%Y%m%d-%H%M%S)
    
    if [[ ! -e "$item" ]]; then
        echo "Error: '$item' not found"
        return 1
    fi
    
    local backup_name="$item.bak-$timestamp"
    
    if [[ -d "$item" ]]; then
        command cp -r "$item" "$backup_name"
        echo "Directory backup: $backup_name"
    else
        command cp "$item" "$backup_name"
        echo "File backup: $backup_name"
    fi
    
    # Clean old backups
    local old_backups=(${item}.bak-*)
    if [[ ${#old_backups[@]} -gt $keep ]]; then
        local to_remove=("${old_backups[@]:0:$((${#old_backups[@]} - $keep))}")
        command rm -rf "${to_remove[@]}"
        echo "Removed old backups: ${to_remove[*]}"
    fi
}

# Find large files
large() {
    local size=${1:-100M}
    find . -size +$size -type f -exec ls -lh {} \; | awk '{print $5 " " $9}'
}

# Find duplicate files
duplicates() {
    find . -type f -exec md5sum {} \; | sort | uniq -d -w 32
}

# Quick file info
info() {
    if [[ -f "$1" ]]; then
        echo "File: $1"
        echo "Size: $(du -h "$1" | cut -f1)"
        echo "Type: $(file "$1")"
        echo "Modified: $(stat -c %y "$1" 2>/dev/null || stat -f %Sm "$1")"
        echo "Permissions: $(ls -la "$1" | cut -d' ' -f1)"
    elif [[ -d "$1" ]]; then
        echo "Directory: $1"
        echo "Size: $(du -sh "$1" | cut -f1)"
        echo "Files: $(find "$1" -type f | wc -l)"
        echo "Subdirs: $(find "$1" -type d | wc -l)"
    else
        echo "'$1' not found"
    fi
}

# ===============================
# GIT WORKFLOW FUNCTIONS
# ===============================

# Enhanced git functions (with auto-push)
gcp() { git add . && git commit -m "$1" && git push; }
gcpp() { git add . && git commit -m "$1" && git push; }
gclone() { git clone "$1" && cd "$(basename "$1" .git)"; }
gnew() { git checkout -b "$1" && git push -u origin "$1"; }
gundo() { git reset --soft HEAD~1; }
gsync() { git checkout main && git pull && git checkout - && git rebase main; }

# Helper to resolve file paths (allows simple filenames like 'own-aliases')
_resolve_file() {
    local file="$1"

    # If it's 'own-aliases' (without extension), resolve to the full path
    if [[ "$file" == "own-aliases" ]]; then
        echo "${HOME}/.oh-my-zsh/custom/own-aliases.zsh"
        return
    fi

    # If file doesn't exist as-is, try with common extensions
    if [[ ! -e "$file" ]]; then
        for ext in .zsh .ts .js .py .go .rs .md; do
            if [[ -e "${file}${ext}" ]]; then
                echo "${file}${ext}"
                return
            fi
        done
    fi

    # Return as-is if it exists or no extension matched
    echo "$file"
}

# Semantic commits (with auto-push and easier file specification)
gfeat() {
    local message="$1"
    shift
    if [[ $# -gt 0 ]]; then
        for file in "$@"; do
            git add "$(_resolve_file "$file")"
        done
    else
        git add .
    fi
    git commit -m "feat: $message" && git push
}

gfix() {
    local message="$1"
    shift
    if [[ $# -gt 0 ]]; then
        for file in "$@"; do
            git add "$(_resolve_file "$file")"
        done
    else
        git add .
    fi
    git commit -m "fix: $message" && git push
}

gdocs() {
    local message="$1"
    shift
    if [[ $# -gt 0 ]]; then
        for file in "$@"; do
            git add "$(_resolve_file "$file")"
        done
    else
        git add .
    fi
    git commit -m "docs: $message" && git push
}

gstyle() {
    local message="$1"
    shift
    if [[ $# -gt 0 ]]; then
        for file in "$@"; do
            git add "$(_resolve_file "$file")"
        done
    else
        git add .
    fi
    git commit -m "style: $message" && git push
}

grefactor() {
    local message="$1"
    shift
    if [[ $# -gt 0 ]]; then
        for file in "$@"; do
            git add "$(_resolve_file "$file")"
        done
    else
        git add .
    fi
    git commit -m "refactor: $message" && git push
}

gtest() {
    local message="$1"
    shift
    if [[ $# -gt 0 ]]; then
        for file in "$@"; do
            git add "$(_resolve_file "$file")"
        done
    else
        git add .
    fi
    git commit -m "test: $message" && git push
}

gchore() {
    local message="$1"
    shift
    if [[ $# -gt 0 ]]; then
        for file in "$@"; do
            git add "$(_resolve_file "$file")"
        done
    else
        git add .
    fi
    git commit -m "chore: $message" && git push
}

gperf() {
    local message="$1"
    shift
    if [[ $# -gt 0 ]]; then
        for file in "$@"; do
            git add "$(_resolve_file "$file")"
        done
    else
        git add .
    fi
    git commit -m "perf: $message" && git push
}

gbuild() {
    local message="$1"
    shift
    if [[ $# -gt 0 ]]; then
        for file in "$@"; do
            git add "$(_resolve_file "$file")"
        done
    else
        git add .
    fi
    git commit -m "build: $message" && git push
}

gci() {
    local message="$1"
    shift
    if [[ $# -gt 0 ]]; then
        for file in "$@"; do
            git add "$(_resolve_file "$file")"
        done
    else
        git add .
    fi
    git commit -m "ci: $message" && git push
}

grevert() {
    local message="$1"
    shift
    if [[ $# -gt 0 ]]; then
        for file in "$@"; do
            git add "$(_resolve_file "$file")"
        done
    else
        git add .
    fi
    git commit -m "revert: $message" && git push
}

# Advanced git operations
gpush() { git push origin $(git branch --show-current); }
gpull() { git pull origin $(git branch --show-current); }
gsquash() { git rebase -i HEAD~"${1:-2}"; }
gcleanup() {
    git branch --merged | grep -v "\*\|master\|main\|develop" | xargs -n 1 git branch -d
    git remote prune origin
}

# Git status with fuzzy search
gfzf() {
    if command -v fzf &> /dev/null; then
        git status --porcelain | fzf --preview 'git diff --color=always {2}' | awk '{print $2}' | xargs git add
    else
        git status
    fi
}

# Show git log with file changes
glog() {
    git log --oneline --name-status | head -20
}

# Git blame with line numbers
gblame() {
    git blame -L "${2:-1},+20" "$1"
}

# ===============================
# GIT ANNOYANCE FIXES
# ===============================

# Fix "I committed to the wrong branch" - moves last commit to new branch
gwrongbranch() {
    local branch_name="$1"
    if [[ -z "$branch_name" ]]; then
        echo "Usage: gwrongbranch <new-branch-name>"
        return 1
    fi
    git branch "$branch_name"
    git reset HEAD~1 --hard
    git checkout "$branch_name"
    echo "Moved last commit to branch '$branch_name'"
}

# Fix "I need to undo that commit but keep changes"
guncommit() {
    git reset --soft HEAD~1
    echo "Last commit undone, changes kept"
}

# Fix "I accidentally committed secrets/personal info"
gnuke() {
    echo "WARNING: This will completely remove the last commit from history"
    read "?Are you sure? (y/n): " confirm
    if [[ "$confirm" == "y" ]]; then
        git reset --hard HEAD~1
        git push --force-with-lease
        echo "Last commit nuked from history"
    fi
}

# Fix "I need to quickly save work in progress"
gwip() {
    git add -A
    git commit -m "WIP: $(date +%H:%M:%S)"
    echo "Work in progress saved"
}

# Fix "I want to continue where I left off"
gunwip() {
    if git log -1 --pretty=%B | grep -q "^WIP:"; then
        git reset HEAD~1
        echo "Continued from WIP commit"
    else
        echo "Last commit is not a WIP commit"
    fi
}

# Fix "I need to see what changed between branches"
gcompare() {
    local branch1=${1:-main}
    local branch2=${2:-HEAD}
    git log --left-right --graph --cherry-pick --oneline "$branch1"..."$branch2"
}

# Fix "I want to quickly switch to the previous branch"
alias gback='git checkout -'

# Fix merge conflicts with a better interface
gmergetool() {
    if command -v code &> /dev/null; then
        git mergetool --tool=vscode
    elif command -v vim &> /dev/null; then
        git mergetool --tool=vimdiff
    else
        git mergetool
    fi
}

# ===============================
# PNPM/NODE ANNOYANCE FIXES
# ===============================

# Fix "node_modules is huge and I want to clean it"
nuke_modules() {
    find . -name "node_modules" -type d -prune -exec rm -rf {} +
    echo "All node_modules directories deleted"
}

# Fix "I need to reinstall everything clean"
pfresh() {
    command rm -rf node_modules pnpm-lock.yaml package-lock.json yarn.lock
    pnpm install
    echo "Fresh pnpm install completed"
}

# Legacy npm fresh install (in case you encounter npm projects)
nfresh() {
    command rm -rf node_modules package-lock.json
    npm install
    echo "Fresh npm install completed"
}

# Fix "I want to quickly check what's using space"
psize() {
    du -sh node_modules 2>/dev/null || echo "No node_modules found"
    echo "Package count: $(find node_modules -name package.json 2>/dev/null | wc -l)"
    if [[ -f pnpm-lock.yaml ]]; then
        echo "pnpm store location: $(pnpm store path)"
        echo "pnpm store size: $(du -sh $(pnpm store path) 2>/dev/null | cut -f1)"
    fi
}

# Fix "I want to audit and fix vulnerabilities quickly" 
paudit() {
    pnpm audit
    echo "Run 'pnpm audit --fix' to attempt automatic fixes"
}

# Fix "I want to see outdated packages quickly"
pold() {
    pnpm outdated
}

# Fix "I want to clean pnpm store"
pclean() {
    pnpm store prune
    echo "pnpm store cleaned"
}

# Fix "I want to update all packages"
pupdate() {
    pnpm update --latest
    echo "All packages updated to latest"
}

# Fix "I want to see pnpm info"
pinfo() {
    echo "pnpm Information:"
    echo "==================="
    echo "pnpm version: $(pnpm --version)"
    echo "Store path: $(pnpm store path)"
    echo "Store size: $(du -sh $(pnpm store path) 2>/dev/null | cut -f1 || echo 'Unknown')"
    echo "Node version: $(node --version)"
    echo ""
    pnpm list --depth=0 2>/dev/null || echo "No packages installed"
}

# Fix "I want to create a new project with pnpm"
pcreate() {
    local template="$1"
    local name="$2"
    
    if [[ -z "$template" ]]; then
        echo "Available templates:"
        echo "  react, vue, svelte, vanilla, typescript"
        echo "Usage: pcreate <template> [project-name]"
        return 1
    fi
    
    if [[ -z "$name" ]]; then
        name="my-${template}-app"
    fi
    
    case "$template" in
        react)
            pnpm create react-app "$name"
            ;;
        vue)
            pnpm create vue@latest "$name"
            ;;
        svelte)
            pnpm create svelte@latest "$name"
            ;;
        typescript)
            mkdir "$name" && cd "$name"
            pnpm init
            pnpm add -D typescript @types/node
            pnpm exec tsc --init
            ;;
        vanilla)
            mkdir "$name" && cd "$name"
            pnpm init
            mkdir src
            echo "console.log('Hello World');" > src/index.js
            echo "node_modules/" > .gitignore
            ;;
        *)
            echo "Unknown template: $template"
            return 1
            ;;
    esac
    
    echo "Project '$name' created with $template template"
}

# Fix "I want to run scripts with fuzzy finder"
prun() {
    if command -v fzf &> /dev/null && [[ -f package.json ]]; then
        local script=$(jq -r '.scripts | keys[]' package.json 2>/dev/null | fzf --prompt="Select script: ")
        if [[ -n "$script" ]]; then
            pnpm run "$script"
        fi
    else
        pnpm run "$1"
    fi
}

# Fix "I want to manage pnpm workspaces easily"
pworkspace() {
    local action="$1"
    
    case "$action" in
        init)
            echo "packages:" > pnpm-workspace.yaml
            echo "  - 'packages/*'" >> pnpm-workspace.yaml
            mkdir -p packages
            echo "pnpm workspace initialized"
            ;;
        list)
            pnpm -r list --depth=0
            ;;
        clean)
            pnpm -r exec rm -rf node_modules
            command rm -rf node_modules
            echo "All node_modules cleaned from workspace"
            ;;
        install)
            pnpm install
            echo "Workspace dependencies installed"
            ;;
        *)
            echo "pnpm workspace commands:"
            echo "  init    - Initialize workspace"
            echo "  list    - List all packages"
            echo "  clean   - Clean all node_modules"
            echo "  install - Install all dependencies"
            ;;
    esac
}

# Fix "I want to quickly navigate between workspace packages"
pcd() {
    if [[ ! -f pnpm-workspace.yaml ]]; then
        echo "Not in a pnpm workspace"
        return 1
    fi
    
    if command -v fzf &> /dev/null; then
        local package_dir=$(find packages -name package.json -exec dirname {} \; | fzf --prompt="Select package: ")
        if [[ -n "$package_dir" ]]; then
            cd "$package_dir"
        fi
    else
        echo "Available packages:"
        find packages -name package.json -exec dirname {} \;
    fi
}

# ===============================
# PROCESS/PORT ANNOYANCE FIXES
# ===============================

# Fix "Something is using port 3000 and I don't know what"
whoport() {
    local port=${1:-3000}
    echo "Process using port $port:"
    lsof -ti:$port | head -5 | xargs ps -fp 2>/dev/null || echo "No process found on port $port"
}

# Fix "I need to kill all node processes"
killnode() {
    pkill -f node
    echo "All node processes killed"
}

# Fix "I need to kill all processes on common dev ports"
killdev() {
    local ports=(3000 3001 8000 8080 5000 4200 8888 9000)
    for port in "${ports[@]}"; do
        local pid=$(lsof -ti:$port 2>/dev/null)
        if [[ -n "$pid" ]]; then
            kill -9 $pid 2>/dev/null
            echo "Killed process on port $port"
        fi
    done
}

# Fix "I want to see what's eating my CPU/Memory"
hungry() {
    echo "Top CPU eaters:"
    ps aux --sort=-%cpu | head -6
    echo ""
    echo "Top memory eaters:"
    ps aux --sort=-%mem | head -6
}

# ===============================
# FILE SYSTEM ANNOYANCE FIXES
# ===============================

# Fix "I can't delete this because permissions"
nuke() {
    local target="$1"
    if [[ -z "$target" ]]; then
        echo "Usage: nuke <file-or-directory>"
        return 1
    fi
    sudo rm -rf "$target"
    echo "Nuked: $target"
}

# Fix "I need to make everything in this dir executable"
chexec() {
    find "${1:-.}" -type f -exec chmod +x {} \;
    echo "Made all files executable in ${1:-.}"
}

# Fix "I need to fix ownership of everything here"
fixown() {
    sudo chown -R $(whoami):$(whoami) "${1:-.}"
    echo "Fixed ownership of ${1:-.}"
}

# Fix "I want to see hidden files sizes"
lsizes() {
    ls -laSh "${1:-.}" | head -20
}

# Fix "I need to find the biggest directories quickly"
bigdirs() {
    du -h "${1:-.}" | sort -hr | head -10
}

# Fix "I want to clean up empty directories"
rmempty() {
    find "${1:-.}" -type d -empty -delete
    echo "Removed empty directories"
}

# ===============================
# DEVELOPMENT ANNOYANCE FIXES
# ===============================

# Fix "I want to quickly start a project"
quickstart() {
    local name="$1"
    local type="${2:-node}"
    
    if [[ -z "$name" ]]; then
        echo "Usage: quickstart <project-name> [node|python|go]"
        return 1
    fi
    
    mkdir "$name" && cd "$name"
    
    case "$type" in
        node)
            pnpm init
            echo "console.log('Hello World');" > index.js
            echo "node_modules/" > .gitignore
            echo "dist/" >> .gitignore
            ;;
        python)
            echo "print('Hello World')" > main.py
            echo "venv/" > .gitignore
            echo "__pycache__/" >> .gitignore
            echo "*.pyc" >> .gitignore
            ;;
        go)
            command go mod init "$name"
            echo 'package main

import "fmt"

func main() {
    fmt.Println("Hello World")
}' > main.go
            ;;
    esac
    
    git init
    git add .
    git commit -m "Initial commit"
    echo "Project '$name' created and initialized with $type"
}

# Fix "I want to quickly test an HTTP endpoint"
httptest() {
    local url="$1"
    local method="${2:-GET}"
    
    echo "Testing $method $url"
    echo "========================"
    curl -w "Status: %{http_code}\nTime: %{time_total}s\nSize: %{size_download} bytes\n" \
         -X "$method" \
         -s \
         -o /dev/null \
         "$url"
}

# Fix "I want to see what ports are open on localhost"
scanlocal() {
    echo "Scanning common local ports..."
    for port in 80 443 3000 3001 8000 8080 5000 4200 8888 9000 5432 3306 6379 27017; do
        if nc -z localhost $port 2>/dev/null; then
            echo "Port $port: OPEN"
        fi
    done
}

# Fix "I want to quickly generate test data"
testdata() {
    local type="${1:-json}"
    local count="${2:-10}"
    
    case "$type" in
        json)
            echo "["
            for i in $(seq 1 $count); do
                echo "  {\"id\": $i, \"name\": \"Item $i\", \"value\": $((RANDOM % 100))}"
                [[ $i -lt $count ]] && echo ","
            done
            echo "]"
            ;;
        csv)
            echo "id,name,value"
            for i in $(seq 1 $count); do
                echo "$i,Item $i,$((RANDOM % 100))"
            done
            ;;
        *)
            echo "Usage: testdata [json|csv] [count]"
            ;;
    esac
}

# ===============================
# DOCKER ANNOYANCE FIXES
# ===============================

# Fix "I want to stop all Docker containers"
dstopall() {
    docker stop $(docker ps -q) 2>/dev/null || echo "No running containers"
}

# Fix "I want to remove all containers and images"
dcleanall() {
    echo "This will remove ALL Docker containers and images"
    read "?Are you sure? (y/n): " confirm
    if [[ "$confirm" == "y" ]]; then
        docker stop $(docker ps -aq) 2>/dev/null || true
        docker rm $(docker ps -aq) 2>/dev/null || true
        docker rmi $(docker images -q) 2>/dev/null || true
        docker system prune -af
        echo "All Docker data removed"
    fi
}

# Fix "I want to see Docker resource usage"
dstatus() {
    echo "Docker Status:"
    echo "==============="
    echo "Containers: $(docker ps -q | wc -l) running, $(docker ps -aq | wc -l) total"
    echo "Images: $(docker images -q | wc -l)"
    echo ""
    docker system df
}

# ===============================
# NETWORK ANNOYANCE FIXES
# ===============================

# Fix "Is the internet working?"
net() {
    echo "Network Status:"
    echo "================"
    
    # Test local network
    if command ping -c 1 -W 1000 192.168.1.1 &>/dev/null; then
        echo "Local network: OK"
    else
        echo "Local network: FAIL"
    fi
    
    # Test DNS
    if nslookup google.com &>/dev/null; then
        echo "DNS: OK"
    else
        echo "DNS: FAIL"
    fi
    
    # Test internet
    if curl -s --max-time 3 https://google.com &>/dev/null; then
        echo "Internet: OK"
    else
        echo "Internet: FAIL"
    fi
}

# Fix "I need to check if a service is responding"
alive() {
    local host="$1"
    local port="${2:-80}"
    
    if [[ -z "$host" ]]; then
        echo "Usage: alive <host> [port]"
        return 1
    fi
    
    if nc -z "$host" "$port" 2>/dev/null; then
        echo "$host:$port is alive"
    else
        echo "$host:$port is not responding"
    fi
}

# ===============================
# SYSTEM MAINTENANCE ANNOYANCE FIXES
# ===============================

# Fix "My disk is full, what's eating space?"
diskpig() {
    echo "Disk space hogs:"
    echo "=================="
    df -h
    echo ""
    echo "Largest directories in current location:"
    du -sh */ 2>/dev/null | sort -hr | head -10
}

# Fix "I want to clean up common junk files"
cleanup() {
    echo "Cleaning up junk files..."
    
    # Remove common temp files
    find . -name ".DS_Store" -delete 2>/dev/null
    find . -name "Thumbs.db" -delete 2>/dev/null
    find . -name "*.tmp" -delete 2>/dev/null
    find . -name "*.temp" -delete 2>/dev/null
    find . -name "*~" -delete 2>/dev/null
    
    # Clean pnpm cache if it exists
    if command -v pnpm &>/dev/null; then
        pnpm store prune 2>/dev/null
        echo "Cleaned pnpm store"
    fi
    
    # Clean npm cache if it exists (legacy)
    if command -v npm &>/dev/null; then
        npm cache clean --force 2>/dev/null
    fi
    
    # Clean yarn cache if it exists
    if command -v yarn &>/dev/null; then
        yarn cache clean 2>/dev/null
    fi
    
    echo "Cleanup completed"
}

# Fix "I want to monitor system resources live"
monitor() {
    echo "System Monitor (Press Ctrl+C to stop)"
    echo "========================================"
    
    while true; do
        clear
        echo "$(date)"
        echo "===================="
        echo "CPU: $(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//' 2>/dev/null || echo 'N/A')"
        echo "Memory: $(vm_stat | awk '/free:/{free=$3} /inactive:/{inactive=$3} END{print int((free+inactive)*4096/1024/1024)" MB free"}' 2>/dev/null || free -h | awk '/Mem:/{print $7" free"}')"
        echo "Disk: $(df -h . | awk 'NR==2{print $4" free"}')"
        echo ""
        echo "Top processes:"
        ps aux | sort -rn -k3 | head -6
        sleep 2
    done
}

# ===============================
# QUICK UTILITIES
# ===============================

# Fix "I need a quick timer"
timer() {
    local duration="$1"
    if [[ -z "$duration" ]]; then
        echo "Usage: timer <seconds>"
        return 1
    fi
    
    echo "Timer set for $duration seconds"
    sleep "$duration"
    echo "Time's up!"
    
    # Try to make a sound
    if [[ "$OSTYPE" == "darwin"* ]]; then
        afplay /System/Library/Sounds/Glass.aiff 2>/dev/null || true
    fi
}

# Fix "I need to encode/decode base64 quickly"
b64() {
    if [[ -p /dev/stdin ]]; then
        # Input from pipe
        base64
    else
        # Input from argument
        echo "$1" | base64
    fi
}

unb64() {
    if [[ -p /dev/stdin ]]; then
        # Input from pipe
        base64 -d
    else
        # Input from argument
        echo "$1" | base64 -d
    fi
}

# Fix "I need to URL encode/decode"
urlencode() {
    python3 -c "import urllib.parse; print(urllib.parse.quote('$1'))"
}

urldecode() {
    python3 -c "import urllib.parse; print(urllib.parse.unquote('$1'))"
}

# Fix "I need to generate a UUID"
uuid() {
    if command -v uuidgen &>/dev/null; then
        uuidgen | tr '[:upper:]' '[:lower:]'
    else
        python3 -c "import uuid; print(uuid.uuid4())"
    fi
}

# Fix "I want to see colors in terminal"
colors() {
    for i in {0..255}; do
        printf "\e[48;5;%sm%3d\e[0m " "$i" "$i"
        if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
            printf "\n"
        fi
    done
}

# ===============================
# SHORTCUTS FOR LAZY PEOPLE
# ===============================

# Fix "I'm too lazy to type full commands"
alias fucking='sudo'
alias wtf='dmesg | tail'
alias onef='find . -name'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# REMOVED: System commands forced to use sudo
# These can break automation and scripts. Use 'sudo mount' explicitly instead.
# If you really want these, uncomment the lines below:
# for cmd in mount umount su shutdown poweroff reboot; do
#     alias $cmd="sudo $cmd"
# done

# Fix "I want to copy to clipboard from command line"
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias clip='pbcopy'
    alias unclip='pbpaste'
else
    alias clip='xclip -selection clipboard'
    alias unclip='xclip -o -selection clipboard'
fi

# ===============================
# DOCKER & KUBERNETES FUNCTIONS
# ===============================

# Enhanced docker functions
dbash() { docker exec -it "$1" bash; }
dsh() { docker exec -it "$1" sh; }
dcleanup() {
    docker rm $(docker ps -aq) 2>/dev/null || true
    docker rmi $(docker images -q) 2>/dev/null || true
    docker system prune -f
}

# Docker log monitoring
dwatch() {
    docker logs -f "$1" | grep --line-buffered "$2"
}

# Docker resource usage
dstats() {
    docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}"
}

# Kubernetes helpers
kexec() {
    local pod="$1"
    local container="$2"
    if [[ -n "$container" ]]; then
        kubectl exec -it "$pod" -c "$container" -- /bin/bash
    else
        kubectl exec -it "$pod" -- /bin/bash
    fi
}

# Port forward with automatic port detection
kpf() {
    local pod="$1"
    local port="$2"
    if [[ -z "$port" ]]; then
        port=$(kubectl get pod "$pod" -o jsonpath='{.spec.containers[0].ports[0].containerPort}')
    fi
    kubectl port-forward "$pod" "$port:$port"
}

# Get pod logs with grep
klog() {
    kubectl logs -f "$1" | grep --line-buffered "$2"
}

# ===============================
# SYSTEM MONITORING
# ===============================

# Process monitoring
psg() {
    ps aux | grep "$1" | grep -v grep
}

# Port monitoring
ports() {
    if [[ -z "$1" ]]; then
        netstat -tuln | grep LISTEN
    else
        netstat -tuln | grep ":$1"
    fi
}

# System resource monitoring
sysinfo() {
    echo "System Information:"
    echo "=================="
    echo "OS: $(uname -s)"
    echo "Kernel: $(uname -r)"
    echo "Arch: $(uname -m)"
    echo "Uptime: $(uptime | awk '{print $3,$4}' | sed 's/,//')"
    
    # Memory - macOS vs Linux
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "Memory: $(vm_stat | awk '/free:/{free=$3} /inactive:/{inactive=$3} END{print int((free+inactive)*4096/1024/1024)" MB free"}')"
    elif command -v free &> /dev/null; then
        echo "Memory: $(free -h | awk 'NR==2{print $3"/"$2}')"
    fi
    
    echo "Disk: $(df -h | awk '$NF=="/"{print $3"/"$2}')"
    
    # CPU - macOS vs Linux
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "CPU: $(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')"
    else
        echo "CPU: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/%us,//' 2>/dev/null || echo 'N/A')"
    fi
}

# Top processes by CPU/Memory
topcpu() {
    ps aux --sort=-%cpu | head -${1:-10}
}

topmem() {
    ps aux --sort=-%mem | head -${1:-10}
}

# Network diagnostics
netdiag() {
    local host=${1:-google.com}
    echo "Network Diagnostics for $host:"
    echo "=============================="
    command ping -c 4 "$host"
    echo ""
    nslookup "$host"
}

# ===============================
# DEVELOPMENT UTILITIES
# ===============================

# Package.json helpers
deps() {
    if [[ -f package.json ]]; then
        cat package.json | jq -r '.dependencies | keys[]' | sort
    else
        echo "No package.json found"
    fi
}

devdeps() {
    if [[ -f package.json ]]; then
        cat package.json | jq -r '.devDependencies | keys[]' | sort
    else
        echo "No package.json found"
    fi
}

scripts() {
    if [[ -f package.json ]]; then
        cat package.json | jq -r '.scripts'
    else
        echo "No package.json found"
    fi
}

# Code statistics
loc() {
    find . -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" | xargs wc -l | tail -1
}

# Find TODOs in code
todos() {
    grep -r "TODO\|FIXME\|XXX\|HACK" --include="*.js" --include="*.ts" --include="*.jsx" --include="*.tsx" --include="*.py" --include="*.rb" --include="*.go" . | head -20
}

# Test specific functions
testfile() {
    if [[ -f package.json ]]; then
        npm test -- "$1"
    else
        echo "No package.json found"
    fi
}

# Code formatting
format() {
    if command -v prettier &> /dev/null; then
        prettier --write .
    elif [[ -f package.json ]]; then
        npm run format
    else
        echo "No formatter found"
    fi
}

# ===============================
# NETWORK & API UTILITIES
# ===============================

# HTTP testing
httpget() {
    curl -s -w "\nStatus: %{http_code}\nTime: %{time_total}s\n" "$1"
}

httppost() {
    local url="$1"
    local data="$2"
    curl -s -X POST -H "Content-Type: application/json" -d "$data" -w "\nStatus: %{http_code}\nTime: %{time_total}s\n" "$url"
}

# API testing
api() {
    local method=${1:-GET}
    local url="$2"
    local data=${3:-"{}"}
    curl -s -X "$method" -H "Content-Type: application/json" -d "$data" -w "\nStatus: %{http_code}\nTime: %{time_total}s\n" "$url"
}

# Get public IP
myip() {
    local ip=$(curl -s https://api.ipify.org)
    echo "Public IP: $ip"
    curl -s "https://ipapi.co/$ip/json" | jq -r '"Location: " + .city + ", " + .region + ", " + .country_name'
}

# Port scanner
portscan() {
    local host=${1:-localhost}
    local start_port=${2:-1}
    local end_port=${3:-1000}
    
    for port in $(seq $start_port $end_port); do
        timeout 1 bash -c "echo >/dev/tcp/$host/$port" && echo "Port $port is open" || true
    done 2>/dev/null
}

# ===============================
# TEXT PROCESSING
# ===============================

# JSON processing
json() {
    if [[ -f "$1" ]]; then
        cat "$1" | jq .
    else
        echo "$1" | jq .
    fi
}

# Enhanced search with context
search() {
    local term="$1"
    local context=${2:-3}
    
    if command -v rg &> /dev/null; then
        rg -C "$context" "$term"
    else
        grep -r -C "$context" "$term" .
    fi
}

# Search and replace
replace() {
    local search_term="$1"
    local replace_term="$2"
    local files="${3:-*.txt}"
    
    if command -v fd &> /dev/null; then
        fd "$files" -x sed -i "s/$search_term/$replace_term/g" {}
    else
        find . -name "$files" -exec sed -i "s/$search_term/$replace_term/g" {} \;
    fi
}

# ===============================
# UTILITIES
# ===============================

# Enhanced weather
weather() {
    local location=${1:-Munich}
    echo "Weather for $location:"
    curl -s "wttr.in/$location?format=v2"
}

# Password generation
genpass() {
    local length=${1:-16}
    local count=${2:-1}
    
    for i in $(seq 1 $count); do
        openssl rand -base64 "$length" | tr -d "=+/" | cut -c1-"$length"
    done
}

# QR code generation
qrcode() {
    if command -v qrencode &> /dev/null; then
        qrencode -t UTF8 "$1"
    else
        echo "qrencode not installed"
    fi
}

# URL shortener
shorten() {
    curl -s "https://tinyurl.com/api-create.php?url=$1"
}

# Enhanced serve with directory listing
serve() {
    local port=${1:-8000}
    local dir=${2:-.}
    echo "Serving $dir on port $port"
    echo "URL: http://localhost:$port"
    python3 -m http.server "$port" --directory "$dir"
}

# Kill process by port
killport() {
    local port="$1"
    if [[ -z "$port" ]]; then
        echo "Usage: killport <port>"
        return 1
    fi
    
    local pids=$(lsof -ti:"$port" 2>/dev/null)
    if [[ -n "$pids" ]]; then
        sudo kill -9 $pids
        echo "Killed processes on port $port: $pids"
    else
        echo "No processes found on port $port"
    fi
}

# Process finder and killer
fkill() {
    if command -v fzf &> /dev/null; then
        local pid=$(ps -ef | sed 1d | fzf --header "Select process to kill" | awk '{print $2}')
        if [[ -n "$pid" ]]; then
            kill -${1:-9} "$pid"
            echo "Killed process $pid"
        fi
    else
        echo "fzf not available"
    fi
}

# ===============================
# SYSTEM MAINTENANCE
# ===============================

# System cleanup
clean() {
    echo "Cleaning system..."
    
    # Clear temporary files
    sudo rm -rf /tmp/* 2>/dev/null || true
    command rm -rf ~/.cache/* 2>/dev/null || true
    
    # Clear log files
    sudo rm -rf /var/log/*.log 2>/dev/null || true
    
    # Docker cleanup
    if command -v docker &>/dev/null; then
        docker system prune -f
    fi
    
    echo "System cleaned"
}

# System file editing
hosts() { sudo vim /etc/hosts; }
fstab() { sudo vim /etc/fstab; }
sudoers() { sudo visudo; }

# Ownership change
own() {
    local target="${1:-.}"
    sudo chown -R $(whoami):$(id -gn) "$target"
    echo "Ownership of $target changed to $(whoami)"
}

# ===============================
# NOTES & PRODUCTIVITY
# ===============================

# Quick notes system
note() {
    local note_file=~/.notes
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $*" >> "$note_file"
    echo "Note added to $note_file"
}

notes() {
    local note_file=~/.notes
    if [[ -f "$note_file" ]]; then
        cat "$note_file" | tail -20
    else
        echo "No notes found"
    fi
}

# Search notes
searchnotes() {
    local note_file=~/.notes
    if [[ -f "$note_file" ]]; then
        grep -i "$1" "$note_file"
    else
        echo "No notes found"
    fi
}

# Clear notes
clearnotes() {
    local note_file=~/.notes
    read "?Clear all notes? (y/n): " confirm
    if [[ "$confirm" == "y" ]]; then
        command rm -f "$note_file"
        echo "All notes cleared"
    fi
}

# Task management
task() {
    local task_file=~/.tasks
    echo "$(date '+%Y-%m-%d %H:%M:%S'): [ ] $*" >> "$task_file"
    echo "Task added"
}

tasks() {
    local task_file=~/.tasks
    if [[ -f "$task_file" ]]; then
        cat "$task_file" | grep -E '\[ \]' | tail -10
    else
        echo "No tasks found"
    fi
}

taskdone() {
    local task_file=~/.tasks
    local backup_file=~/.tasks.bak
    
    if [[ -f "$task_file" ]]; then
        command cp "$task_file" "$backup_file"
        sed -i.tmp "s/\[ \]/\[x\]/g" "$task_file"
        command rm -f "$task_file.tmp"
        echo "All tasks marked as done"
    else
        echo "No tasks found"
    fi
}

# ===============================
# SYSTEM INFO & TIME
# ===============================

kernel() { uname -r; }
now() { date +"%T"; }
nowdate() { date +"%d-%m-%Y"; }
timestamp() { date +"%Y%m%d_%H%M%S"; }
week() { date +%V; }

# ===============================
# ALIASES FOR UTILITIES
# ===============================

calc() { bc -l <<< "$1"; }
random() { openssl rand -hex 16; }
listening() { lsof -i -P -n | grep LISTEN; }
# REMOVED: ping alias that modifies default behavior
# Use 'command ping' or just 'ping' for normal behavior now

# ===============================
# TERMINAL SHORTCUTS
# ===============================

reload() { source ~/.zshrc; }
rl() { source ~/.zshrc; }
c() { clear; }
cls() { clear; }
clr() { clear && ls; }
h() { history; }
hg() { history | grep "$1"; }

# Directory size
dirsize() { du -sh */ | sort -hr; }

# ===============================
# HELP SYSTEM
# ===============================

help() {
    cat << 'EOF'
Enhanced Command Line Functions (80+ Functions):

IMPORTANT NOTES:
  - Use 'command <cmd>' to bypass aliases (e.g., 'command cp' for non-interactive)
  - 'code' alias removed - VS Code CLI won't conflict
  - System commands (mount, shutdown, etc.) require explicit 'sudo'
  - Go lang 'go' command is preserved (no alias conflict)

NAVIGATION & FILES:
  mkcd <dir>       - Create and enter directory
  fcd              - Fuzzy find and change directory  
  proj [name]      - Go to project directory (fuzzy finder)
  bookmark [name]  - Bookmark current directory
  listbookmarks    - List all bookmarks
  up [n]           - Go up n directories

FILE OPERATIONS:
  ff <pattern>     - Smart file finder with preview
  fdir <pattern>   - Find directories
  ffile <pattern>  - Find files
  ftype <ext>      - Find files by extension
  extract <file>   - Universal archive extractor
  archive <name>   - Create archive
  backup <file>    - Smart backup with rotation
  large [size]     - Find files larger than size
  duplicates       - Find duplicate files
  info <file>      - Show detailed file information

GIT WORKFLOW:
  gcp 'msg'        - Add, commit with message, and push
  gcpp 'msg'       - Add, commit, push (same as gcp, both auto-push now)
  gfeat 'msg' [files...] - Semantic commit: feat, and push
  gfix 'msg' [files...]  - Semantic commit: fix, and push
  gdocs 'msg' [files...] - Semantic commit: docs, and push
  gstyle 'msg' [files...] - Semantic commit: style, and push
  grefactor 'msg' [files...] - Semantic commit: refactor, and push
  gtest 'msg' [files...] - Semantic commit: test, and push
  gchore 'msg' [files...] - Semantic commit: chore, and push
  gperf 'msg' [files...] - Semantic commit: perf (performance), and push
  gbuild 'msg' [files...] - Semantic commit: build, and push
  gci 'msg' [files...] - Semantic commit: ci (continuous integration), and push
  grevert 'msg' [files...] - Semantic commit: revert, and push
  NOTE: Use simple filenames like 'own-aliases' (without path/extension) for convenience
  gnew <branch>    - Create and push new branch
  gsync            - Sync with main branch
  gcleanup         - Clean merged branches
  gfzf             - Fuzzy select files to add
  glog             - Git log with file changes
  gblame <file>    - Git blame with context

GIT ANNOYANCE FIXES:
  gwrongbranch <b> - Move last commit to new branch
  guncommit        - Undo commit but keep changes
  gnuke            - Remove last commit from history
  gwip / gunwip    - Save/restore work in progress
  gback            - Switch to previous branch
  gcompare <b1> <b2> - Compare branches

PNPM WORKFLOW:
  pfresh           - Clean reinstall (removes lock files)
  psize            - Check node_modules & pnpm store size
  paudit           - Audit with fix suggestions
  pclean           - Clean pnpm store
  pinfo            - Complete pnpm system info
  pcreate <t> [n]  - Create projects (react, vue, etc.)
  prun             - Fuzzy-find and run scripts
  pworkspace <act> - Manage workspaces (init/list/clean)
  pcd              - Navigate between workspace packages

DEVELOPMENT:
  deps             - List package dependencies
  devdeps          - List dev dependencies
  scripts          - Show npm scripts
  loc              - Count lines of code
  todos            - Find TODO comments
  format           - Format code with prettier
  testfile <file>  - Test specific file
  quickstart <name> - Scaffold new projects

DOCKER & KUBERNETES:
  dbash <container> - Bash into container
  dsh <container>  - Shell into container
  dcleanup         - Clean Docker system
  dwatch <cont>    - Watch container logs
  dstats           - Docker resource usage
  dstopall         - Stop all containers
  dcleanall        - Remove all containers/images
  kexec <pod>      - Exec into pod
  kpf <pod>        - Port forward with auto-detect
  klog <pod>       - Pod logs with grep

SYSTEM MONITORING:
  sysinfo          - Complete system information
  topcpu [n]       - Top CPU processes
  topmem [n]       - Top memory processes
  psg <pattern>    - Find processes (clean output)
  ports [port]     - Check port usage
  netdiag <host>   - Network diagnostics
  whoport <port>   - See what's using a port
  killdev          - Kill processes on dev ports
  hungry           - Show resource hogs

NETWORK & API:
  httpget <url>    - HTTP GET with stats
  httppost <url>   - HTTP POST with data
  api <method>     - API testing
  myip             - Show public IP and location
  portscan <host>  - Scan ports on host
  net              - Check network connectivity
  alive <host>     - Check if service responds
  scanlocal        - Scan common local ports

UTILITIES:
  weather [city]   - Full weather forecast
  genpass [len]    - Generate secure password
  qrcode <text>    - Generate QR code
  shorten <url>    - Shorten URL
  serve [port]     - Enhanced HTTP server
  killport <port>  - Kill process on port
  fkill            - Interactive process killer
  timer <sec>      - Quick countdown timer
  uuid             - Generate UUID
  testdata [type]  - Generate test data

ENCODING/TEXT:
  search <term>    - Content search with context
  replace <s> <r>  - Search and replace in files
  json <file>      - Pretty print JSON
  b64 / unb64      - Base64 encode/decode
  urlencode/decode - URL encode/decode

SYSTEM MAINTENANCE:
  clean            - Complete system cleanup
  cleanup          - Remove junk files (.DS_Store, etc.)
  diskpig          - Find what's eating disk space
  monitor          - Live system resource monitoring
  hosts            - Edit /etc/hosts
  fstab            - Edit /etc/fstab
  sudoers          - Edit sudoers file
  own <path>       - Take ownership of files
  nuke <path>      - Force delete with sudo
  fixown <path>    - Fix ownership recursively
  bigdirs          - Find largest directories
  rmempty          - Remove empty directories

NOTES & TASKS:
  note <text>      - Add timestamped note
  notes            - Show recent notes
  searchnotes <q>  - Search in notes
  clearnotes       - Clear all notes
  task <text>      - Add task
  tasks            - Show pending tasks
  taskdone         - Mark all tasks complete

QUICK SHORTCUTS:
  now              - Current time
  timestamp        - Timestamp for filenames
  calc <expr>      - Calculator
  random           - Generate random hex
  reload / rl      - Reload shell config
  c / cls / clr    - Clear screen variants
  colors           - Show terminal color palette

Type 'help' for this reference anytime!
EOF
}

# ===============================
# ZSH GIT COMPLETION SETUP
# ===============================

# Auto-completion for git semantic commit functions
# Shows changed/untracked files when you press tab
_git_semantic_completion() {
    local expl

    # Get modified/untracked files from git status
    local -a files
    files=(${(f)"$(git status --porcelain 2>/dev/null | awk '{print $NF}')"})

    if (( ${#files[@]} )); then
        _describe -t git-files "git files" files
    fi
}

# Register zsh completion for all semantic commit functions
compdef _git_semantic_completion gfeat
compdef _git_semantic_completion gfix
compdef _git_semantic_completion gdocs
compdef _git_semantic_completion gstyle
compdef _git_semantic_completion grefactor
compdef _git_semantic_completion gtest
compdef _git_semantic_completion gchore
compdef _git_semantic_completion gperf
compdef _git_semantic_completion gbuild
compdef _git_semantic_completion gci
compdef _git_semantic_completion grevert
compdef _git_semantic_completion gcp
compdef _git_semantic_completion gcpp

# ===============================
# INITIALIZATION (COMPLETELY SILENT)
# ===============================

# Silent loading - no output during zsh initialization
[[ -z "$ALIASES_LOADED" ]] && export ALIASES_LOADED=1