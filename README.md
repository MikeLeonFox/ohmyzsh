# Zsh Configuration

A comprehensive, modular zsh setup with 80+ productivity-boosting aliases and functions, plus an enhanced Powerlevel10k prompt configuration. Organized into 19 focused modules for easy maintenance and customization.

## Quick Links

- [Installation](#installation)
- [Module Structure](#module-structure)
- [Available Commands](#available-commands)
- [Powerlevel10k Prompt](#powerlevel10k-prompt)
- [Troubleshooting](#troubleshooting)

## What You Get

- **Modular aliases & functions** - 19 organized files, ~50 KB total
- **Advanced git workflow** - Semantic commits with auto-push
- **Docker & Kubernetes** - Quick shortcuts for container operations
- **Development utilities** - Code scaffolding, formatting, testing
- **System monitoring** - Process, disk, memory, and network tools
- **Beautiful prompt** - Powerlevel10k with git, docker, and system info
- **Zero startup overhead** - Fast, lazy-loaded where possible

## Installation

### Prerequisites

- **Zsh** shell
- **Oh My Zsh** framework: https://ohmyzsh.sh/
- **Powerlevel10k** theme: https://github.com/romkatv/powerlevel10k
- **Nerd Font** for icons: https://www.nerdfonts.com/

### Quick Setup

```bash
# 1. Install Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# 2. Copy configuration files to ~/.oh-my-zsh/custom/
#    (This repo should already be cloned there)

# 3. Update ~/.zshrc
# Add this line to set the theme:
#   ZSH_THEME="powerlevel10k/powerlevel10k"

# Add this line to source the aliases:
#   source ~/.oh-my-zsh/custom/own-aliases.zsh

# The .p10k.zsh is sourced automatically by oh-my-zsh

# 4. Reload shell
source ~/.zshrc
```

---

## Module Structure

The aliases and functions are organized into 19 focused modules, loaded automatically via `init.zsh`:

### Core Setup
- **01-env.zsh** - Environment variables and shell initialization
- **init.zsh** - Main loader that sources all other modules in order

### Navigation & Shortcuts
- **10-directory-shortcuts.zsh** - Directory navigation aliases (doc, dl, repos, etc.)
- **20-privileges.zsh** - sudo and privilege management (s, please, admin, etc.)

### Platform Tools
- **30-kubernetes.zsh** - kubectl aliases and functions
- **40-git-aliases.zsh** - Git shortcut aliases
- **41-git-functions.zsh** - Git workflow functions (semantic commits)
- **50-docker.zsh** - Docker and docker-compose aliases
- **60-package-managers.zsh** - pnpm, npm, yarn, python package shortcuts

### System & Files
- **70-filesystem.zsh** - File operations, ls variants, safe aliases
- **75-system.zsh** - System shortcuts, process monitoring, terminal
- **80-macos.zsh** - macOS-specific functions
- **90-pnpm-functions.zsh** - Advanced pnpm utilities

### Advanced Functions
- **100-functions-navigation.zsh** - Directory finding and fuzzy navigation
- **101-functions-file-ops.zsh** - Archive, backup, and file utilities
- **110-functions-development.zsh** - Development tools and scaffolding
- **120-functions-system.zsh** - System monitoring and maintenance
- **130-functions-network.zsh** - Network diagnostics and API tools
- **140-functions-utilities.zsh** - Text processing, encoding, utilities

### Documentation & Help
- **200-help-completion.zsh** - Help system and ZSH completions

---

## Available Commands

Type `help` in your terminal to see all available commands with descriptions. Below is a quick reference organized by category:

### Git Workflow (semantic commits with auto-push)

```bash
gcp 'message'     # Add all, commit, push
gfeat 'msg'       # feat: commit
gfix 'msg'        # fix: commit
gdocs 'msg'       # docs: commit
grefactor 'msg'   # refactor: commit
gtest 'msg'       # test: commit
gchore 'msg'      # chore: commit
```

**Git helpers:**
- `gwrongbranch <name>` - Move last commit to new branch
- `guncommit` - Undo last commit, keep changes
- `gwip / gunwip` - Save/restore work in progress
- `gcompare <b1> <b2>` - Compare branches

### Navigation

```bash
mkcd <dir>        # Create and cd into directory
fcd               # Fuzzy find and cd
proj [name]       # Jump to projects
up [n]            # Go up n levels (default: 1)
..  / ... / ....  # Go up 1, 2, 3 levels
```

**Directory shortcuts:**
```bash
doc / dt / dl     # Documents / Desktop / Downloads
repos / dev       # Code directories
config / zsh      # Config directories
```

### File Operations

```bash
ff <pattern>      # Smart file finder with preview
extract <file>    # Universal archive extractor
archive <n> <t>   # Create archive
backup <file>     # Smart backup with rotation
large [size]      # Find files larger than size
duplicates        # Find duplicate files
info <file>       # Show detailed file info
```

### Docker & Kubernetes

**Docker:**
```bash
d                 # docker
dc / dcu / dcd    # docker compose up/down
dbash <name>      # Bash into container
dwatch <name>     # Watch logs
dstats / dstatus  # Resource usage
dcleanall         # Remove all containers/images
```

**Kubernetes:**
```bash
k / kgp / kgs     # kubectl commands
kpf <pod> [port]  # Port forward
kexec <pod>       # Exec into pod
klog <pod>        # Pod logs
kwatch            # Watch pods
```

### Package Management (pnpm-first)

```bash
p / pi / pa / pr  # pnpm / install / add / run
pstart / ptest    # pnpm start / test
pdev / plint      # pnpm run dev / lint
pw / pwa / pwr    # pnpm workspace
pcd               # Navigate between packages
pcreate <t>       # Scaffold new project
psize / pinfo     # Show sizes and info
```

### System Monitoring

```bash
sysinfo           # Complete system info
topcpu / topmem   # Top processes by CPU/memory
whoport <port>    # What's using a port
diskpig           # What's eating disk space
monitor           # Live system monitoring
hungry            # Top CPU and memory eaters
psg <pattern>     # Find processes
```

### Development & Utilities

```bash
deps / devdeps    # List package dependencies
scripts           # Show npm scripts
loc               # Count lines of code
todos             # Find TODO comments
format            # Format code with prettier
testfile <file>   # Test specific file
timer <seconds>   # Countdown timer
genpass [len]     # Generate secure password
```

### Network & API

```bash
httpget <url>     # HTTP GET with timing
httppost <url>    # HTTP POST
api <method> <url> # API testing
myip              # Public IP and location
netdiag <host>    # Network diagnostics
alive <host>      # Check if service responds
```

### File System & System Shortcuts

**Safe by default (interactive):**
```bash
cp / mv / rm      # Interactive by default
mkdir             # Creates parents (-p)
chmod 755/644/600 # Quick shortcuts
```

**ls variants:**
```bash
ll / la / l       # Detailed / all / long
lt / lz / lx      # Sort by time / size / extension
```

**Privileges:**
```bash
s / please        # Shortcuts for sudo
admin / noadmin   # Toggle privileges
amiadmin          # Check if admin
```

### Text & Encoding

```bash
b64 / unb64       # Base64 encode/decode
urlencode/decode  # URL encoding
colors            # Terminal color palette
uuid              # Generate UUID
```

---

## Advanced Features

**Smart file completion for git commits:**
```bash
gfeat 'added validation' own-aliases
# Automatically resolves to the full path
```

**Tool integration (gracefully degrades if missing):**
- fzf - Fuzzy finding
- fd - Fast directory search
- bat - Syntax highlighting
- ripgrep - Fast text search

**Bypassing aliases in scripts:**
```bash
command cp file1 file2      # Bypasses the -i flag
command sudo ls             # Bypasses Privileges.app
```

**Disable features:** Comment out modules in `init.zsh` to skip loading them.

---

## Powerlevel10k Prompt

Enhanced Powerlevel10k prompt configuration with extensive customization for a beautiful, informative, and performant terminal experience.

### Prompt Structure

**Left prompt** shows:
- **Directory** with smart truncation and special icons
- **Git status** with branch name and indicators (modified, staged, untracked)
- **Newline** for visual separation
- **Prompt character** (❯) - green when successful, red on error

**Right prompt** intelligently displays:
- **Exit status** (only on errors)
- **Command execution time** (only if > 3 seconds)
- **Background jobs** count
- **Development tools:** Python venv, Node.js version, Git remote
- **Infrastructure:** Kubernetes context, Terraform workspace, AWS profile
- **System status:** Battery, WiFi, RAM usage, disk usage, CPU load
- **Time & connectivity:** Current time and IP address

### Customization

```bash
p10k configure        # Interactive wizard
p10k reload          # Refresh configuration
```

**Hide the time:**
```bash
# Edit ~/.p10k.zsh and comment out 'time' in POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS
```

**Change colors:**
```bash
# In ~/.p10k.zsh
typeset -g POWERLEVEL9K_DIR_BACKGROUND=5  # Change directory color
```

**Add custom segment:**
```bash
# Define function
function prompt_my_segment() {
  p10k segment -t "content"
}

# Add to POWERLEVEL9K_LEFT_PROMPT_ELEMENTS
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs my_segment newline prompt_char)
```

### Features

- **Instant Prompt** - Displays before shell finishes loading
- **Transient Prompt** - Previous prompts become minimal for less clutter
- **Conditional Rendering** - Segments only show when relevant
- **Fast & Lightweight** - Negligible startup impact
- **Multiline** - Separates directory/git info from input prompt

---

## Troubleshooting

**Command not found:**
- Check if it's a function: `type commandname`
- Reload shell: `source ~/.zshrc`

**Git auto-push fails:**
- Semantic commit functions auto-push by default
- Stage changes first: `git add .`

**Docker/Kubernetes commands not working:**
- These require the respective tools installed
- They gracefully skip if missing

**Prompt not appearing:**
1. Verify Powerlevel10k: `ls $ZSH_CUSTOM/themes/powerlevel10k/`
2. Check `.zshrc` has `ZSH_THEME="powerlevel10k/powerlevel10k"`
3. Verify `.p10k.zsh` is sourced
4. Reload: `source ~/.zshrc`

**Missing icons/glyphs:**
1. Install a Nerd Font (e.g., FiraCode Nerd Font)
2. Set as terminal font
3. Restart terminal

**Git status not showing:**
- Verify in a git repo: `git status`
- Run: `p10k configure` and test

**Slow prompt:**
1. Disable unused segments in `.p10k.zsh`
2. Check specific tool performance: `time git status`
3. Run: `p10k reload`

**Color issues:**
- Add to `.zshrc` before sourcing p10k.zsh:
  ```bash
  export TERM=xterm-256color
  ```

---

## Project Info

- **19 modular alias files** - ~50 KB total
- **Powerlevel10k configuration** - 40+ customizable segments
- **80+ aliases & functions** - Organized by category
- **Zero external dependencies** - Gracefully degrades if tools missing
- **macOS and Linux compatible**

## Resources

- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Nerd Fonts](https://www.nerdfonts.com/)
