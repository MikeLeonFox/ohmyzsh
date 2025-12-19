# ~/.oh-my-zsh/custom/70-filesystem.zsh
# File system and navigation aliases

# ===============================
# LISTING & NAVIGATION
# ===============================
alias ll='ls -lahF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -lhtrF'
alias lz='ls -lhSrF'
alias lx='ls -lhAXF'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# Quick directories
alias desk='cd ~/Desktop'
alias docs='cd ~/Documents'
alias dl='cd ~/Downloads'
alias home='cd ~'
alias tmp='cd /tmp'

# ===============================
# SAFER FILE OPERATIONS
# ===============================
# These add safety for interactive use but won't break scripts
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'
alias ln='ln -v'

# ===============================
# PERMISSIONS & OWNERSHIP
# ===============================
alias chx='chmod +x'
alias 755='chmod 755'
alias 644='chmod 644'
alias 600='chmod 600'

# ===============================
# ARCHIVE OPERATIONS
# ===============================
alias tarx='tar -xvf'
alias tarc='tar -cvf'
alias tarz='tar -czvf'
alias untar='tar -xvf'

# ===============================
# UTILITIES
# ===============================
alias mk='mkdir -p'
alias path='echo $PATH | tr ":" "\n"'
alias which='type -a'
alias count='find . -type f | wc -l'
alias countdir='find . -type d | wc -l'
alias size='du -sh'
alias dsize='du -sh .'
