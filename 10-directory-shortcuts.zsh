# ~/.oh-my-zsh/custom/10-directory-shortcuts.zsh
# Directory navigation shortcuts

# More document shortcuts
alias doc='cd ~/Documents'
alias dt='cd ~/Desktop'

# Programming directories (assuming they're in ~/Documents)
alias pms='cd ~/Documents/Programmin\ Shit/'
alias cdev='cd ~/Documents/Programmin\ Shit/'
alias dev='cd ~/Documents/Programmin\ Shit/'
alias repos='cd ~/Documents/Programmin\ Shit/'

# Common system directories
alias apps='cd /Applications'
alias bin='cd /usr/local/bin'
alias etc='cd /etc'
alias var='cd /var'
alias opt='cd /opt'
alias usr='cd /usr'

# User directories
alias lib='cd ~/Library'
alias pics='cd ~/Pictures'
alias music='cd ~/Music'
alias movies='cd ~/Movies'
alias pub='cd ~/Public'

# macOS specific useful directories
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias appsupp='cd ~/Library/Application\ Support'
    alias prefs='cd ~/Library/Preferences'
    alias logs='cd ~/Library/Logs'
    alias caches='cd ~/Library/Caches'
fi

# Cloud storage shortcuts (adjust paths as needed)
alias icloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'
alias dropbox='cd ~/Dropbox'
alias gdrive='cd ~/Google\ Drive'
alias onedrive='cd ~/OneDrive'

# Web development specific
alias www='cd ~/Documents/Web'
alias sites='cd ~/Documents/Sites'
alias webdev='cd ~/Documents/WebDev'

# Mobile development
alias mobile='cd ~/Documents/Mobile'
alias ios='cd ~/Documents/iOS'
alias android='cd ~/Documents/Android'

# Configuration directories
alias config='cd ~/.config'
alias zsh='cd ~/.oh-my-zsh'
