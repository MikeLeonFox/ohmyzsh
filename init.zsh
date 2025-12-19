# ~/.oh-my-zsh/custom/init.zsh
# Main initialization file that sources all alias modules

# Source all modular alias files in order
# The numbered prefix determines load order

# 01: Environment and initialization
[[ -f "$ZSH_CUSTOM/01-env.zsh" ]] && source "$ZSH_CUSTOM/01-env.zsh"

# 10: Directory shortcuts
[[ -f "$ZSH_CUSTOM/10-directory-shortcuts.zsh" ]] && source "$ZSH_CUSTOM/10-directory-shortcuts.zsh"

# 20: Privileges and sudo
[[ -f "$ZSH_CUSTOM/20-privileges.zsh" ]] && source "$ZSH_CUSTOM/20-privileges.zsh"

# 30: Kubernetes
[[ -f "$ZSH_CUSTOM/30-kubernetes.zsh" ]] && source "$ZSH_CUSTOM/30-kubernetes.zsh"

# 40-41: Git aliases and functions
[[ -f "$ZSH_CUSTOM/40-git-aliases.zsh" ]] && source "$ZSH_CUSTOM/40-git-aliases.zsh"
[[ -f "$ZSH_CUSTOM/41-git-functions.zsh" ]] && source "$ZSH_CUSTOM/41-git-functions.zsh"

# 50: Docker
[[ -f "$ZSH_CUSTOM/50-docker.zsh" ]] && source "$ZSH_CUSTOM/50-docker.zsh"

# 60: Package managers (pnpm, npm, yarn, python)
[[ -f "$ZSH_CUSTOM/60-package-managers.zsh" ]] && source "$ZSH_CUSTOM/60-package-managers.zsh"

# 70: File system and navigation
[[ -f "$ZSH_CUSTOM/70-filesystem.zsh" ]] && source "$ZSH_CUSTOM/70-filesystem.zsh"

# 75: System and process management
[[ -f "$ZSH_CUSTOM/75-system.zsh" ]] && source "$ZSH_CUSTOM/75-system.zsh"

# 80: macOS specific
[[ -f "$ZSH_CUSTOM/80-macos.zsh" ]] && source "$ZSH_CUSTOM/80-macos.zsh"

# 90: pnpm functions
[[ -f "$ZSH_CUSTOM/90-pnpm-functions.zsh" ]] && source "$ZSH_CUSTOM/90-pnpm-functions.zsh"

# 100-101: Navigation and file operations functions
[[ -f "$ZSH_CUSTOM/100-functions-navigation.zsh" ]] && source "$ZSH_CUSTOM/100-functions-navigation.zsh"
[[ -f "$ZSH_CUSTOM/101-functions-file-ops.zsh" ]] && source "$ZSH_CUSTOM/101-functions-file-ops.zsh"

# 110: Development utilities
[[ -f "$ZSH_CUSTOM/110-functions-development.zsh" ]] && source "$ZSH_CUSTOM/110-functions-development.zsh"

# 120: System monitoring and maintenance
[[ -f "$ZSH_CUSTOM/120-functions-system.zsh" ]] && source "$ZSH_CUSTOM/120-functions-system.zsh"

# 130: Network utilities
[[ -f "$ZSH_CUSTOM/130-functions-network.zsh" ]] && source "$ZSH_CUSTOM/130-functions-network.zsh"

# 140: Text processing and utilities
[[ -f "$ZSH_CUSTOM/140-functions-utilities.zsh" ]] && source "$ZSH_CUSTOM/140-functions-utilities.zsh"

# 200: Help system and completions
[[ -f "$ZSH_CUSTOM/200-help-completion.zsh" ]] && source "$ZSH_CUSTOM/200-help-completion.zsh"
