# .p10k.zsh

Enhanced Powerlevel10k prompt configuration with extensive customization for a beautiful, informative, and performant terminal experience.

## Overview

This configuration file customizes Powerlevel10k (p10k) to display:
- Current directory with smart path truncation
- Git status with branch and changes
- Command execution time
- Exit status (success/failure)
- Development environment information
- System status indicators
- Comprehensive right-side information display

## Installation

### Prerequisites
1. **Zsh** shell (version 5.1+)
2. **Oh My Zsh** framework: https://ohmyzsh.sh/
3. **Powerlevel10k** theme: https://github.com/romkatv/powerlevel10k

### Install Powerlevel10k
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### Install Nerd Font
Download and install a Nerd Font for proper icon display:
- **Recommended:** FiraCode Nerd Font, JetBrains Mono Nerd Font
- Set as your terminal font in preferences
- https://www.nerdfonts.com/

### Setup Configuration
1. Place `.p10k.zsh` in your home directory:
   ```bash
   ~/.p10k.zsh
   ```

2. Set Powerlevel10k as your theme in `.zshrc`:
   ```bash
   ZSH_THEME="powerlevel10k/powerlevel10k"
   ```

3. Source the config in `.zshrc` (usually automatic):
   ```bash
   [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
   ```

4. Reload your shell:
   ```bash
   source ~/.zshrc
   ```

## Quick Customization

### Interactive Configuration
```bash
p10k configure
```
This launches an interactive wizard to customize your prompt.

### Manual Editing
Edit `~/.p10k.zsh` directly to tweak specific settings.

## Prompt Structure

### Left Prompt (Primary Information)
The main prompt displays:

1. **Directory** 📂
   - Current working directory with smart truncation
   - Different icons for special directories (Documents, Projects, Config, etc.)
   - Path anchoring with bold last component
   - Shortened middle components with ellipsis

2. **Git Status** (VCS) 🌿
   - Branch name with icon
   - Status indicators:
     - `?` - Untracked files (yellow)
     - `!` - Unstaged changes (red)
     - `+` - Staged changes (green)
   - Branch ahead/behind indicators

3. **Newline** ↵
   - Separates directory/git info from command prompt

4. **Prompt Character** ❯
   - Changes color based on exit status:
     - Green (❯) - Last command succeeded
     - Red (❯) - Last command failed
   - Changes shape in different vim modes

### Right Prompt (Contextual Information)
The prompt intelligently displays relevant information:

#### Status & Timing
- **Exit Status** ✅/❌
  - Shows only for failed commands
  - Green checkmark for success (hidden by default)
  - Red X for failures with exit code

- **Command Execution Time** ⏱️
  - Only shows if command took > 3 seconds
  - Useful for identifying slow operations

- **Background Jobs** 🔄
  - Number of running background processes

#### Development Tools
- **Python Virtual Environment** 🐍
  - Active venv/conda name
  - Helpful when switching environments

- **Node.js Version** ⬢
  - Current Node version
  - Shows when node/nvm detected

- **Git Remote URL** 🔗 (Custom segment)
  - Repository name from origin
  - Shows which repo you're working in

- **Docker Status** 🐳 (Custom segment)
  - Number of running containers
  - Useful when juggling multiple services

#### Infrastructure & Tools
- **Kubernetes Context** ☸️
  - Current kubectl context
  - Only shown when using k8s commands

- **Terraform Workspace** 🌍
  - Active Terraform workspace

- **AWS Profile** ☁️
  - Active AWS profile (if configured)

- **Google Cloud** 🔵
  - GCP project and account info

- **Azure** ☁️
  - Azure subscription info

#### System Status
- **Battery** 🔋
  - Battery level with visual bars
  - Color coded (red when low, green when full)
  - Hidden when plugged in

- **WiFi** 📶
  - WiFi signal strength
  - Only shown on laptops

- **RAM Usage** 🧠
  - Current memory consumption

- **Disk Usage** 💾
  - Disk space utilization

- **System Load** 📊
  - CPU load average

#### Time & Connectivity
- **Current Time** 🕐
  - Real-time clock (HH:MM:SS format)
  - Optional, can be toggled

- **IP Address** 🌐
  - Local IP addresses
  - Useful for network troubleshooting

## Styling

### Colors & Themes
The configuration uses a carefully selected color scheme:

**Directory:** Blue background (#004)
**Git Status:**
  - Clean: Green (#002)
  - Modified: Red (#001)
  - Untracked: Yellow (#003)
  - Background: Black (#000)

**Prompt Char:**
  - Success: Green (#076)
  - Error: Red (#196)

**Battery:**
  - Low (0-20%): Red
  - Charging: Yellow
  - Charged: Green
  - Disconnected: Grey

### Icons & Symbols
- **Directory Icons:** Customized by folder type (📄 Documents, 📥 Downloads, 💼 Projects, ⚙️ Config)
- **Git Icons:** Branch (🌿), Status indicators, Merge info
- **Command Char:** Changes with vim mode (❯ insert, ❮ command, Ⅴ visual, ▶ replace)

## Advanced Features

### Transient Prompt
When navigating to the same directory, previous command prompts become minimal, reducing visual clutter.

### Instant Prompt
Powerlevel10k renders an instant prompt before your shell is fully loaded for faster perceived startup.

### Multiline Prompt
The prompt spans two lines:
- First line: Directory and git info
- Second line: Prompt character and input

### Custom Segments
The config includes example custom segments:

```bash
# Show Git remote URL
prompt_git_remote() {
    local remote_url=$(git remote get-url origin 2>/dev/null)
    if [[ -n $remote_url ]]; then
        p10k segment -b 5 -f 7 -t "🔗 ${remote_url##*/}"
    fi
}

# Show Docker container count
prompt_docker_status() {
    if command -v docker &> /dev/null && docker info &> /dev/null; then
        local containers=$(docker ps -q | wc -l | tr -d ' ')
        p10k segment -b 6 -f 7 -t "🐳 $containers"
    fi
}
```

### Conditional Segments
Some segments only display when relevant commands are active:
- **Kubernetes:** Only when using `kubectl`, `helm`, `kubens`, etc.
- **Terraform:** Only when using `terraform` or `tf`

## Supported Environments

The right prompt intelligently detects and displays:

- **Programming Languages:** Python, Node, Ruby, Go, Java, PHP, Perl, Scala, Haskell, Lua
- **Containers:** Docker, Kubernetes
- **Cloud Platforms:** AWS, Azure, Google Cloud
- **VPN/Network:** NordVPN, Network status
- **Shells:** Vim, Midnight Commander, nix-shell, ranger, nnn
- **Version Managers:** nvm, nodenv, rbenv, pyenv, goenv, jenv, etc.

## Performance

This configuration is optimized for speed:

- **Instant Prompt:** Displays before shell fully loads
- **Conditional Rendering:** Segments only render when needed
- **Cached Information:** Git and environment info cached
- **No External Dependencies:** Uses built-in features and tools
- **Fast Startup:** Negligible overhead on shell initialization

## Customization Examples

### Hide the Time
In `.p10k.zsh`, find `POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS` and remove `time`:
```bash
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  # ... other elements ...
  # time          # Remove or comment this line
)
```

### Change Directory Truncation
```bash
typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
# Other options: truncate_to_unique, truncate_with_folder_marker, etc.
```

### Modify Colors
```bash
# Change directory background from blue to purple
typeset -g POWERLEVEL9K_DIR_BACKGROUND=5
```

### Add Custom Segment to Prompt
```bash
# In POWERLEVEL9K_LEFT_PROMPT_ELEMENTS, add your segment name
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir
  vcs
  my_custom_segment  # Add this
  newline
  prompt_char
)

# Then define the function above
function prompt_my_custom_segment() {
  p10k segment -t "your custom content"
}
```

### Disable Segments
Comment out segments in `POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS` you don't need.

## Troubleshooting

### Prompt Not Appearing
1. Verify Powerlevel10k is installed: `ls $ZSH_CUSTOM/themes/powerlevel10k/`
2. Check `.zshrc` has `ZSH_THEME="powerlevel10k/powerlevel10k"`
3. Verify `.p10k.zsh` is sourced
4. Reload: `source ~/.zshrc`

### Missing Icons/Glyphs
1. Install a Nerd Font
2. Set it as your terminal font
3. Restart terminal

### Git Status Not Showing
1. Verify you're in a git repository: `git status`
2. Check git config: `git config --list`
3. Run `p10k configure` and test git segment

### Slow Prompt
1. Disable unused segments in right prompt
2. Check if a specific tool is slow: `time git status`
3. Run `p10k reload` to refresh caches

### Color Issues
1. Set terminal to 256-color mode: `export TERM=xterm-256color`
2. In `.zshrc` before sourcing p10k.zsh

## Configuration File Structure

```
.p10k.zsh
├── Instant Prompt Cache
├── Configuration Function
│   ├── Safety Checks
│   ├── Prompt Style (Left/Right elements)
│   ├── Basic Styling (colors, separators)
│   ├── Colors & Icons
│   │   ├── OS identification
│   │   ├── Directory icons by type
│   │   ├── Git icons and colors
│   │   └── System status indicators
│   ├── Component Styling
│   │   ├── Directory
│   │   ├── Git/VCS
│   │   ├── Command execution time
│   │   └── Status indicators
│   ├── Custom Segments
│   │   ├── Git remote URL
│   │   └── Docker status
│   ├── Conditional Segments
│   └── Advanced Features (transient, multiline)
└── Initialization
```

## File Statistics
- **276 lines** of carefully organized configuration
- **40+ customizable segments**
- **Extensive color and icon customization**
- **Zero dependencies beyond Powerlevel10k**

## Further Reading

- **Powerlevel10k GitHub:** https://github.com/romkatv/powerlevel10k
- **Configuration Guide:** https://github.com/romkatv/powerlevel10k/blob/master/README.md
- **Nerd Fonts:** https://www.nerdfonts.com/

## See Also
- `own-aliases.zsh` - 80+ productivity aliases and functions
- Oh My Zsh documentation: https://github.com/ohmyzsh/ohmyzsh
