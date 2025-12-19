# own-aliases.zsh

A comprehensive zsh configuration file with 80+ productivity-boosting aliases and functions designed for developers, DevOps engineers, and power users.

## Overview

This file consolidates everything you need for an enhanced command-line experience, including:
- Directory navigation shortcuts
- Git workflow automation
- Docker & Kubernetes helpers
- Development utilities
- System monitoring tools
- Network & API utilities
- File management functions
- Package manager integration (pnpm, npm, yarn)

## Installation

1. Place `own-aliases.zsh` in your oh-my-zsh custom directory:
   ```bash
   ~/.oh-my-zsh/custom/own-aliases.zsh
   ```

2. Source it in your `.zshrc`:
   ```bash
   source ~/.oh-my-zsh/custom/own-aliases.zsh
   ```

3. Reload your shell:
   ```bash
   source ~/.zshrc
   ```

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
```

**Kubernetes:**
```bash
k / kgp / kgs       # kubectl commands
kpf <pod> [port]    # Port forward with auto-detect
kexec <pod>         # Exec into pod
klog <pod>          # Pod logs
ctx / ns            # Switch context/namespace
```

### System Monitoring
- **`sysinfo`** - Complete system information
- **`topcpu [n]`** - Top CPU-consuming processes
- **`topmem [n]`** - Top memory-consuming processes
- **`whoport <port>`** - See what's using a port
- **`diskpig`** - Find what's eating disk space
- **`monitor`** - Live system resource monitoring
- **`hungry`** - Show top CPU and memory eaters

### Development Utilities
- **`deps / devdeps`** - List package dependencies
- **`scripts`** - Show npm scripts
- **`loc`** - Count lines of code
- **`todos`** - Find TODO comments in code
- **`format`** - Format code with prettier
- **`quickstart <name> [type]`** - Scaffold new projects

### Network & API
- **`httpget <url>`** - HTTP GET with timing
- **`httppost <url> <data>`** - HTTP POST
- **`api <method> <url> [data]`** - API testing
- **`myip`** - Show public IP and location
- **`portscan <host>`** - Scan ports on host
- **`net`** - Check network connectivity

### Utilities
- **`timer <seconds>`** - Countdown timer
- **`weather [city]`** - Weather forecast
- **`genpass [length]`** - Generate secure passwords
- **`qrcode <text>`** - Generate QR codes
- **`serve [port]`** - Start HTTP server
- **`uuid`** - Generate UUIDs
- **`b64 / unb64`** - Base64 encode/decode
- **`urlencode / urldecode`** - URL encoding

### Privileged Operations

Enhanced `sudo` with automatic Privileges.app integration (macOS):
```bash
sudo command                # Uses Privileges.app if available
s / please / fuck 'cmd'     # Shortcuts for sudo
admin / noadmin             # Toggle admin privileges
amiadmin                    # Check if admin
```

## File System Operations

All file operations are safer by default with confirmation flags:
```bash
cp / mv / rm        # Interactive versions by default
mkdir               # Creates parents (-p) automatically
chmod 755/644/600   # Quick permission shortcuts
```

Bypass safety: `command cp file1 file2` (scripts won't trigger confirmation)

## Aliases at a Glance

### Navigation Shortcuts
```bash
..  / ...  / ....        # Go up directories
~                         # Home directory
doc / dt / dl            # Documents / Desktop / Downloads
apps / bin / etc         # Common system directories
config / zsh             # Config directories
```

### System Shortcuts
```bash
ll / la / l              # ls variants with different details
lt / lz / lx             # Sort by time / size / extension
psa / psc / psm          # Process monitoring
ps aux shortcuts         # Easier process viewing
```

### Kubernetes Shortcuts
```bash
k = kubectl
kgp = kubectl get pods
kgs = kubectl get services
kgd = kubectl get deployments
kaf = kubectl apply -f
kdel = kubectl delete
kdp = kubectl describe pod
klf = kubectl logs -f
kwatch = kubectl get pods -w
```

### Git Shortcuts (Common)
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
```

## Advanced Features

### Smart File Completion for Git Commits
When using semantic commit functions, you can reference files by simple name:
```bash
gfeat 'added validation' own-aliases
# Automatically resolves to ~/.oh-my-zsh/custom/own-aliases.zsh
```

### Intelligent Tool Integration
- **fzf** support: Enhanced navigation with fuzzy finder
- **fd** support: Faster find operations (falls back to find)
- **bat** support: Syntax-highlighted file previews
- **ripgrep** support: Faster search operations

### Conditional Features
- macOS-specific features automatically enabled (Privileges app, clipboard, etc.)
- Linux fallbacks for commands (memory info, CPU usage, etc.)
- Docker/Kubernetes commands only error if tools aren't available

## Important Notes

### Bypassing Aliases
For scripts that shouldn't trigger interactive features:
```bash
command cp file1 file2      # Bypasses the -i flag
command sudo ls             # Bypasses Privileges.app
```

### Removed/Changed Commands
- **`code`** - No longer aliased (conflicts with VS Code CLI)
- **`go`** - Not aliased (preserves golang)
- System commands like `mount`, `shutdown` - Require explicit `sudo`

### Performance Tips
- First load clears conflicting aliases from oh-my-zsh plugins
- Completely silent during zsh initialization (no startup slowdown)
- Uses `ALIASES_LOADED` flag to prevent duplicate sourcing

## Troubleshooting

### Command Not Found
1. Check if it's a function: `type commandname`
2. Verify file is sourced: `echo $ALIASES_LOADED`
3. Reload shell: `source ~/.zshrc`

### Git Commit Auto-Push Issues
- Semantic functions auto-push by default
- Push fails if you have uncommitted changes
- Use `git add .` first if needed

### Docker/Kubernetes Commands Not Working
These require the respective tools installed. They're silent if missing.

## Customization

### Adding Your Own Aliases
Add to `own-aliases.zsh` after the main section:
```bash
alias myalias='command here'
myfunction() { some code; }
```

### Disabling Auto-Push
Comment out the `&& git push` at the end of semantic commit functions

### Changing Privileges Method
Modify the `sudo()` function to use your preferred privilege escalation method

## File Statistics
- **2250+ lines** of carefully organized shell code
- **80+ aliases and functions**
- **Zero external dependencies** (gracefully degrades if tools missing)
- **macOS and Linux** compatible

## License
Feel free to use, modify, and share!

## See Also
- `.p10k.zsh` - Enhanced Powerlevel10k prompt configuration
- `oh-my-zsh` documentation: https://github.com/ohmyzsh/ohmyzsh
