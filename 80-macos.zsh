# ~/.oh-my-zsh/custom/80-macos.zsh
# macOS specific aliases and functions

if [[ "$OSTYPE" == "darwin"* ]]; then
    # File visibility
    alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
    alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'

    # Trash management
    alias emptytrash='rm -rf ~/.Trash/*'

    # Application shortcuts
    alias finder='open -a Finder'
    alias preview='open -a Preview'

    # VS Code - only if 'code' command doesn't exist
    if ! command -v code &> /dev/null; then
        alias code='open -a "Visual Studio Code"'
    fi

    # Clipboard
    alias copy='pbcopy'
    alias paste='pbpaste'
    alias clip='pbcopy'
    alias unclip='pbpaste'

    # Network
    alias flush='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
else
    # Linux clipboard alternatives
    alias clip='xclip -selection clipboard'
    alias unclip='xclip -o -selection clipboard'
fi
