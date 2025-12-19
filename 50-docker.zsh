# ~/.oh-my-zsh/custom/50-docker.zsh
# Docker aliases and functions

# ===============================
# DOCKER ALIASES
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
# DOCKER FUNCTIONS
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
