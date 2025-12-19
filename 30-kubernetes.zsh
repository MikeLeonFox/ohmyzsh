# ~/.oh-my-zsh/custom/30-kubernetes.zsh
# Kubernetes (kubectl) aliases and functions

# ===============================
# KUBERNETES ALIASES
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
alias kgpw='kubectl get pods -o wide'
alias kgpg='kubectl get pods | grep'
alias kgsg='kubectl get svc | grep'
alias kwatch='kubectl get pods -w'
alias kgpy='kubectl get pods -o yaml'
alias kgpj='kubectl get pods -o json'

# ===============================
# KUBERNETES FUNCTIONS
# ===============================

# Kubernetes exec into pod
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
