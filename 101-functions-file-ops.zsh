# ~/.oh-my-zsh/custom/101-functions-file-ops.zsh
# File operation functions

# ===============================
# ARCHIVE OPERATIONS
# ===============================

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

# ===============================
# BACKUP & CLEANUP
# ===============================

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

# ===============================
# FILE INFORMATION
# ===============================

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
