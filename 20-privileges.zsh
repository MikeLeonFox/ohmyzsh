# ~/.oh-my-zsh/custom/20-privileges.zsh
# Sudo and privilege-related functions

# Enhanced sudo function with Privileges CLI integration
sudo() {
    # Check if privilegescli is available
    if command -v privilegescli &> /dev/null; then
        # Check if we already have admin privileges using privilegescli
        if privilegescli -s &>/dev/null; then
            # Already have privileges, just run sudo
            command sudo "$@"
            return
        else
            # Request admin privileges using CLI
            echo "Requesting admin privileges..."
            if privilegescli -a; then
                # Brief wait for privileges to be granted
                sleep 0.5
                # Execute the original sudo command
                command sudo "$@"
            else
                echo "Failed to obtain admin privileges"
                return 1
            fi
        fi
    else
        # Fallback to GUI method if CLI not available
        # Check if we already have admin privileges
        if groups | grep -q admin && command sudo -n true 2>/dev/null; then
            # Already have privileges, just run sudo
            command sudo "$@"
            return
        fi
        # Check if Privileges app is installed
        if ! [ -d "/Applications/Privileges.app" ]; then
            echo "Neither Privileges CLI nor GUI app found. Please install Privileges first."
            return 1
        fi
        # Only open Privileges if we don't have admin rights
        open -a "Privileges" 2>/dev/null
        # Request admin privileges automatically using AppleScript (silently)
        osascript >/dev/null 2>&1 <<EOF
tell application "Privileges"
    activate
    delay 0.5
    tell application "System Events"
        tell process "Privileges"
            try
                click button "Request Privileges" of window 1
            on error
            end try
        end tell
    end delay 1
end tell
EOF
        # Brief wait for privileges to be granted
        sleep 1.5
        # Execute the original sudo command
        command sudo "$@"
    fi
}

# Legacy command-line interface support (if available)
if command -v privilegescli &> /dev/null; then
    alias admin='privilegescli -a'
    alias noadmin='privilegescli -d'
    alias amiadmin='privilegescli -s'
    PRIVILEGES_AVAILABLE=true
else
    PRIVILEGES_AVAILABLE=false
fi

# Universal sudo shortcuts
alias s='sudo'
alias please='sudo'
alias fuck='sudo'
alias fucking='sudo'
