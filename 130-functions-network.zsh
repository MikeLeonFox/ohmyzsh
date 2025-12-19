# ~/.oh-my-zsh/custom/130-functions-network.zsh
# Network and API utilities

# ===============================
# NETWORK STATUS
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
# HTTP & API TESTING
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

# ===============================
# IP & LOCATION
# ===============================

# Get public IP
myip() {
    local ip=$(curl -s https://api.ipify.org)
    echo "Public IP: $ip"
    curl -s "https://ipapi.co/$ip/json" | jq -r '"Location: " + .city + ", " + .region + ", " + .country_name'
}

# ===============================
# PORT SCANNING
# ===============================

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
# PORT & PROCESS MANAGEMENT
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

# Fix "I want to kill process by port"
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
