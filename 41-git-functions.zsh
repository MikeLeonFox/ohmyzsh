# ~/.oh-my-zsh/custom/41-git-functions.zsh
# Git workflow functions and advanced operations

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

# ===============================
# SEMANTIC COMMITS
# ===============================

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

# ===============================
# QUICK GIT OPERATIONS
# ===============================

# Enhanced git functions (with auto-push)
gcp() { git add . && git commit -m "$1" && git push; }
gcpp() { git add . && git commit -m "$1" && git push; }
gclone() { git clone "$1" && cd "$(basename "$1" .git)"; }
gnew() { git checkout -b "$1" && git push -u origin "$1"; }
gundo() { git reset --soft HEAD~1; }
gsync() { git checkout main && git pull && git checkout - && git rebase main; }

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
