# ~/.oh-my-zsh/custom/120-functions-system.zsh
# System monitoring and maintenance functions

# ===============================
# PROCESS & SYSTEM MONITORING
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

# ===============================
# NETWORK DIAGNOSTICS
# ===============================

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
# DISK & SPACE MANAGEMENT
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
# FILE SYSTEM UTILITIES
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

# ===============================
# SYSTEM MAINTENANCE
# ===============================

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

# System cleanup (requires sudo)
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
# SYSTEM FILE EDITING
# ===============================

hosts() { sudo vim /etc/hosts; }
fstab() { sudo vim /etc/fstab; }
sudoers() { sudo visudo; }

# Ownership change
own() {
    local target="${1:-.}"
    sudo chown -R $(whoami):$(id -gn) "$target"
    echo "Ownership of $target changed to $(whoami)"
}
