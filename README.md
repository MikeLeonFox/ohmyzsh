# Zsh Configuration

A comprehensive zsh setup with 80+ productivity-boosting aliases/functions and an enhanced Powerlevel10k prompt configuration.

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [own-aliases.zsh](#own-aliaseszsh)
- [.p10k.zsh](#p10kzsh)
- [Troubleshooting](#troubleshooting)

---

## Overview

This repository contains two powerful zsh configuration files:

1. **own-aliases.zsh** - 2250+ lines with 80+ aliases and functions for developers and power users
2. **.p10k.zsh** - Enhanced Powerlevel10k prompt with 40+ customizable segments

Together they provide:
- Advanced git workflow automation
- Docker & Kubernetes helpers
- Development utilities
- System monitoring tools
- Beautiful, informative terminal prompt
- Zero startup performance impact

## Installation

### Prerequisites

- **Zsh** shell
- **Oh My Zsh** framework: https://ohmyzsh.sh/
- **Powerlevel10k** theme: https://github.com/romkatv/powerlevel10k
- **Nerd Font** for icons: https://www.nerdfonts.com/

### Quick Setup

```bash
# 1. Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# 2. Copy configuration files
cp own-aliases.zsh ~/.oh-my-zsh/custom/
cp .p10k.zsh ~/

# 3. Update ~/.zshrc
# Set theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Source own-aliases (add to .zshrc)
source ~/.oh-my-zsh/custom/own-aliases.zsh

# The .p10k.zsh should be sourced automatically by oh-my-zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 4. Reload shell
source ~/.zshrc
```

---

# own-aliases.zsh

A comprehensive zsh configuration with 80+ productivity-boosting aliases and functions designed for developers, DevOps engineers, and power users.

## Quick Start

View all available commands:
```bash
help
```

## Key Features

### Directory Navigation
- **`mkcd <dir>`** - Create and immediately cd into a directory
- **`fcd`** - Fuzzy find directories and navigate
- **`proj [name]`** - Jump to projects (with fuzzy finder)
- **`bookmark [name]`** - Bookmark current directory
- **`up [n]`** - Go up n directory levels (default: 1)

### Git Workflow (with auto-push)

Simple commands that add, commit, and push in one go:

```bash
gcp 'message'              # Add all, commit with message, push
gfeat 'message' [files]    # feat: semantic commit
gfix 'message' [files]     # fix: semantic commit
gdocs 'message' [files]    # docs: semantic commit
grefactor 'message'        # refactor: semantic commit
gtest 'message'            # test: semantic commit
gchore 'message'           # chore: semantic commit
gperf 'message'            # perf: semantic commit
gbuild 'message'           # build: semantic commit
gci 'message'              # ci: semantic commit
grevert 'message'          # revert: semantic commit
```

Supports simple filenames: `gfeat 'added validation' own-aliases` (no path needed)

**Git Annoyance Fixes:**
- **`gwrongbranch <name>`** - Move last commit to a new branch
- **`guncommit`** - Undo last commit but keep changes
- **`gwip / gunwip`** - Save/restore work in progress
- **`gcompare <branch1> <branch2>`** - Compare branches

### File Operations
- **`ff <pattern>`** - Smart file finder with preview
- **`extract <file>`** - Universal archive extractor (supports zip, tar, 7z, etc.)
- **`archive <name> <target>`** - Create archives
- **`backup <file>`** - Smart backup with automatic rotation
- **`large [size]`** - Find files larger than specified size
- **`duplicates`** - Find duplicate files by checksum
- **`info <file>`** - Show detailed file information

### Package Management (pnpm-first)

```bash
p                   # pnpm
pi / pa / pr        # pnpm install / add / run
pstart / ptest      # pnpm start / test
pdev / plint        # pnpm run dev / lint

# Workspace commands
pw / pwa / pwr      # pnpm workspace operations
pworkspace init     # Initialize workspace
pcd                 # Navigate between workspace packages
pfresh              # Clean reinstall (removes lock files)
psize               # Check node_modules and store size
pinfo               # Complete pnpm system information
pcreate <t> [n]     # Create projects (react, vue, svelte, etc.)
```

### Docker & Kubernetes

**Docker:**
```bash
d                   # docker
dc / dcu / dcd      # docker compose up/down
dbash <container>   # Bash into container
dwatch <container>  # Watch container logs
dstats              # Resource usage
dcleanall           # Remove all containers/images
dstopall            # Stop all containers
dstatus             # Docker resource summary
```

**Kubernetes:**
```bash
k / kgp / kgs       # kubectl commands
kpf <pod> [port]    # Port forward with auto-detect
kexec <pod>         # Exec into pod
klog <pod>          # Pod logs
ctx / ns            # Switch context/namespace
kwatch              # Watch pods in real-time
```

### System Monitoring
- **`sysinfo`** - Complete system information
- **`topcpu [n]`** - Top CPU-consuming processes
- **`topmem [n]`** - Top memory-consuming processes
- **`whoport <port>`** - See what's using a port
- **`diskpig`** - Find what's eating disk space
- **`monitor`** - Live system resource monitoring
- **`hungry`** - Show top CPU and memory eaters
- **`psg <pattern>`** - Find processes (clean output)
- **`netdiag <host>`** - Network diagnostics

### Development Utilities
- **`deps / devdeps`** - List package dependencies
- **`scripts`** - Show npm scripts
- **`loc`** - Count lines of code
- **`todos`** - Find TODO comments in code
- **`format`** - Format code with prettier
- **`testfile <file>`** - Test specific file
- **`quickstart <name> [type]`** - Scaffold new projects (node/python/go)

### Network & API
- **`httpget <url>`** - HTTP GET with timing
- **`httppost <url> <data>`** - HTTP POST
- **`api <method> <url> [data]`** - API testing
- **`myip`** - Show public IP and location
- **`portscan <host>`** - Scan ports on host
- **`net`** - Check network connectivity
- **`alive <host> [port]`** - Check if service responds
- **`scanlocal`** - Scan common local ports

### Utilities
- **`timer <seconds>`** - Countdown timer
- **`weather [city]`** - Weather forecast
- **`genpass [length]`** - Generate secure passwords
- **`qrcode <text>`** - Generate QR codes
- **`serve [port]`** - Start HTTP server
- **`uuid`** - Generate UUIDs
- **`b64 / unb64`** - Base64 encode/decode
- **`urlencode / urldecode`** - URL encoding
- **`colors`** - Show terminal color palette

### Privileged Operations

Enhanced `sudo` with automatic Privileges.app integration (macOS):
```bash
sudo command                # Uses Privileges.app if available
s / please / fuck 'cmd'     # Shortcuts for sudo
admin / noadmin             # Toggle admin privileges
amiadmin                    # Check if admin
```

## Navigation Aliases

```bash
..  / ...  / ....        # Go up directories
~                         # Home directory
doc / dt / dl            # Documents / Desktop / Downloads
pms / cdev / dev / repos # Programming directories
apps / bin / etc         # Common system directories
config / zsh             # Config directories
```

## System Shortcuts

```bash
ll / la / l              # ls variants with different details
lt / lz / lx             # Sort by time / size / extension
psa / psc / psm          # Process monitoring
```

## Git Shortcuts (Common)

```bash
g = git
gs = git status
ga = git add
gc = git commit -m
gp = git push
gpl = git pull
gd = git diff
gl = git log
gb = git branch
gco = git checkout
gcb = git checkout -b
gm = git merge
gr = git rebase
gf = git fetch
grh = git reset HEAD
```

## File System Operations

All file operations are safer by default with confirmation flags:
```bash
cp / mv / rm        # Interactive versions by default
mkdir               # Creates parents (-p) automatically
chmod 755/644/600   # Quick permission shortcuts
```

Bypass safety in scripts: `command cp file1 file2` (won't trigger confirmation)

## Advanced Features

### Smart File Completion for Git Commits
When using semantic commit functions, reference files by simple name:
```bash
gfeat 'added validation' own-aliases
# Automatically resolves to ~/.oh-my-zsh/custom/own-aliases.zsh
```

### Intelligent Tool Integration
- **fzf** support: Enhanced navigation with fuzzy finder
- **fd** support: Faster find operations (falls back to find)
- **bat** support: Syntax-highlighted file previews
- **ripgrep** support: Faster search operations

### Important Notes

**Bypassing Aliases:**
For scripts that shouldn't trigger interactive features:
```bash
command cp file1 file2      # Bypasses the -i flag
command sudo ls             # Bypasses Privileges.app
```

**Removed/Changed Commands:**
- **`code`** - No longer aliased (conflicts with VS Code CLI)
- **`go`** - Not aliased (preserves golang)
- System commands like `mount`, `shutdown` - Require explicit `sudo`

---

# .p10k.zsh

Enhanced Powerlevel10k prompt configuration with extensive customization for a beautiful, informative, and performant terminal experience.

## Prompt Structure

### Left Prompt (Primary Information)

The main prompt displays:

1. **Directory** 📂
   - Current working directory with smart truncation
   - Different icons for special directories (Documents, Projects, Config, etc.)
   - Path anchoring with bold last component
   - Shortened middle components

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
   - Changes shape in different vim modes (❮ in command mode, Ⅴ in visual)

### Right Prompt (Contextual Information)

The prompt intelligently displays relevant information:

#### Status & Timing
- **Exit Status** ✅/❌
  - Shows only for failed commands
  - Red X for failures with exit code

- **Command Execution Time** ⏱️
  - Only shows if command took > 3 seconds

- **Background Jobs** 🔄
  - Number of running background processes

#### Development Tools
- **Python Virtual Environment** 🐍
  - Active venv/conda name

- **Node.js Version** ⬢
  - Current Node version (via nvm/nodenv)

- **Git Remote URL** 🔗 (Custom)
  - Repository name from origin

- **Docker Status** 🐳 (Custom)
  - Number of running containers

#### Infrastructure & Tools
- **Kubernetes Context** ☸️
  - Current kubectl context
  - Only shown when using k8s commands

- **Terraform Workspace** 🌍
  - Active Terraform workspace

- **AWS Profile** ☁️
  - Active AWS profile

- **Azure/Google Cloud** ☁️
  - Cloud account information

#### System Status
- **Battery** 🔋
  - Battery level with visual bars
  - Color coded (red when low, green when full)

- **WiFi** 📶
  - WiFi signal strength

- **RAM Usage** 🧠
  - Current memory consumption

- **Disk Usage** 💾
  - Disk space utilization

- **System Load** 📊
  - CPU load average

#### Time & Connectivity
- **Current Time** 🕐
  - Real-time clock (HH:MM:SS format)

- **IP Address** 🌐
  - Local IP addresses

## Styling

### Colors & Themes

The configuration uses a carefully selected color scheme:

**Directory:** Blue background
**Git Status:**
  - Clean: Green
  - Modified: Red
  - Untracked: Yellow

**Prompt Char:**
  - Success: Green
  - Error: Red

**Battery:**
  - Low (0-20%): Red
  - Charging: Yellow
  - Charged: Green
  - Disconnected: Grey

### Icons & Symbols
- **Directory Icons:** Customized by folder type (📄 Documents, 📥 Downloads, 💼 Projects, ⚙️ Config)
- **Git Icons:** Branch, Status indicators, Merge info
- **Command Char:** Changes with vim mode (❯ insert, ❮ command, Ⅴ visual, ▶ replace)

## Advanced Features

### Transient Prompt
When navigating to the same directory, previous command prompts become minimal, reducing visual clutter.

### Instant Prompt
Powerlevel10k renders an instant prompt before your shell is fully loads for faster perceived startup.

### Multiline Prompt
The prompt spans two lines:
- First line: Directory and git info
- Second line: Prompt character and input

### Custom Segments
The config includes example custom segments:

```bash
# Show Git remote URL
function prompt_git_remote() {
    local remote_url=$(git remote get-url origin 2>/dev/null)
    if [[ -n $remote_url ]]; then
        p10k segment -b 5 -f 7 -t "🔗 ${remote_url##*/}"
    fi
}

# Show Docker container count
function prompt_docker_status() {
    if command -v docker &> /dev/null && docker info &> /dev/null; then
        local containers=$(docker ps -q | wc -l | tr -d ' ')
        p10k segment -b 6 -f 7 -t "🐳 $containers"
    fi
}
```

### Conditional Segments
Some segments only display when relevant:
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

## Customization

### Interactive Configuration
```bash
p10k configure
```
This launches an interactive wizard to customize your prompt.

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

## Performance

This configuration is optimized for speed:

- **Instant Prompt:** Displays before shell fully loads
- **Conditional Rendering:** Segments only render when needed
- **Cached Information:** Git and environment info cached
- **No External Dependencies:** Uses built-in features and tools
- **Fast Startup:** Negligible overhead on shell initialization

---

## Troubleshooting

### Aliases & Functions

**Command Not Found:**
1. Check if it's a function: `type commandname`
2. Verify file is sourced: `echo $ALIASES_LOADED`
3. Reload shell: `source ~/.zshrc`

**Git Commit Auto-Push Issues:**
- Semantic functions auto-push by default
- Push fails if you have uncommitted changes
- Use `git add .` first if needed

**Docker/Kubernetes Commands Not Working:**
These require the respective tools installed. They're silent if missing.

### Prompt

**Prompt Not Appearing:**
1. Verify Powerlevel10k is installed: `ls $ZSH_CUSTOM/themes/powerlevel10k/`
2. Check `.zshrc` has `ZSH_THEME="powerlevel10k/powerlevel10k"`
3. Verify `.p10k.zsh` is sourced
4. Reload: `source ~/.zshrc`

**Missing Icons/Glyphs:**
1. Install a Nerd Font
2. Set it as your terminal font
3. Restart terminal

**Git Status Not Showing:**
1. Verify you're in a git repository: `git status`
2. Check git config: `git config --list`
3. Run `p10k configure` and test git segment

**Slow Prompt:**
1. Disable unused segments in right prompt
2. Check if a specific tool is slow: `time git status`
3. Run `p10k reload` to refresh caches

**Color Issues:**
1. Set terminal to 256-color mode: `export TERM=xterm-256color`
2. Add to `.zshrc` before sourcing p10k.zsh

---

## File Statistics

- **own-aliases.zsh:** 2250+ lines, 80+ aliases/functions
- **.p10k.zsh:** 276 lines, 40+ customizable segments
- **Zero external dependencies** (gracefully degrades if tools missing)
- **macOS and Linux** compatible

## Further Reading

- **Oh My Zsh:** https://github.com/ohmyzsh/ohmyzsh
- **Powerlevel10k:** https://github.com/romkatv/powerlevel10k
- **Nerd Fonts:** https://www.nerdfonts.com/
