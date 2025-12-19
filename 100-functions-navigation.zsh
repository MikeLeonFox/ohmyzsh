# ~/.oh-my-zsh/custom/100-functions-navigation.zsh
# Navigation and file finding functions

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

# ===============================
# DIRECTORY BOOKMARKS
# ===============================

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
# FILE FINDING & SEARCH
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
