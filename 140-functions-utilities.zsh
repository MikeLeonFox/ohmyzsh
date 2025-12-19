# ~/.oh-my-zsh/custom/140-functions-utilities.zsh
# Text processing and utility functions

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
# ENCODING/DECODING
# ===============================

# Base64 encode/decode
b64() {
    if [[ -p /dev/stdin ]]; then
        base64
    else
        echo "$1" | base64
    fi
}

unb64() {
    if [[ -p /dev/stdin ]]; then
        base64 -d
    else
        echo "$1" | base64 -d
    fi
}

# URL encode/decode
urlencode() {
    python3 -c "import urllib.parse; print(urllib.parse.quote('$1'))"
}

urldecode() {
    python3 -c "import urllib.parse; print(urllib.parse.unquote('$1'))"
}

# ===============================
# QUICK UTILITIES
# ===============================

# UUID generator
uuid() {
    if command -v uuidgen &>/dev/null; then
        uuidgen | tr '[:upper:]' '[:lower:]'
    else
        python3 -c "import uuid; print(uuid.uuid4())"
    fi
}

# Terminal color palette
colors() {
    for i in {0..255}; do
        printf "\e[48;5;%sm%3d\e[0m " "$i" "$i"
        if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
            printf "\n"
        fi
    done
}

# Timer
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

# ===============================
# UTILITY FUNCTIONS
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

# ===============================
# NOTES & TASKS
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
