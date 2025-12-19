# ~/.oh-my-zsh/custom/75-system.zsh
# System and process management aliases

# ===============================
# PROCESS MANAGEMENT
# ===============================
alias psa='ps aux'
alias psc='ps aux --sort=-%cpu | head'
alias psm='ps aux --sort=-%mem | head'
alias kill9='kill -9'
alias killall='killall'

# ===============================
# SYSTEM INFO
# ===============================
alias arch='uname -m'
alias distro='cat /etc/*-release'
alias meminfo='cat /proc/meminfo'
alias cpuinfo='cat /proc/cpuinfo'

# ===============================
# HISTORY MANAGEMENT
# ===============================
alias histdel='history -d'
alias histclean='history -c'

# ===============================
# GREP WITH COLOR
# ===============================
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ===============================
# UTILITIES
# ===============================
alias wtf='dmesg | tail'
alias onef='find . -name'
alias calc='bc -l'
alias random='openssl rand -hex 16'
alias listening='lsof -i -P -n | grep LISTEN'

# ===============================
# TERMINAL SHORTCUTS
# ===============================
alias reload='source ~/.zshrc'
alias rl='source ~/.zshrc'
alias c='clear'
alias cls='clear'
alias clr='clear && ls'
alias h='history'
alias hg='history | grep'
alias dirsize='du -sh */ | sort -hr'

# ===============================
# TIME & SYSTEM INFO FUNCTIONS
# ===============================
kernel() { uname -r; }
now() { date +"%T"; }
nowdate() { date +"%d-%m-%Y"; }
timestamp() { date +"%Y%m%d_%H%M%S"; }
week() { date +%V; }
