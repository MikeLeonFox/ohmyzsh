# Modular Aliases System

This directory now uses a modular approach to organize aliases and functions.

## File Organization

The aliases are split into numbered modules for easy loading and maintenance:

### Core Setup
- **01-env.zsh** - Environment variables and initialization
- **init.zsh** - Main loader that sources all modules

### Navigation & Directories
- **10-directory-shortcuts.zsh** - Directory navigation aliases
- **20-privileges.zsh** - sudo and privilege management

### Tools & Platforms
- **30-kubernetes.zsh** - kubectl aliases and functions
- **40-git-aliases.zsh** - Git shortcut aliases
- **41-git-functions.zsh** - Git workflow functions
- **50-docker.zsh** - Docker aliases and functions
- **60-package-managers.zsh** - pnpm, npm, yarn, python

### System & Files
- **70-filesystem.zsh** - File operations and navigation aliases
- **75-system.zsh** - System, process, and terminal aliases
- **80-macos.zsh** - macOS-specific functions

### Functions (Major Categories)
- **90-pnpm-functions.zsh** - pnpm-specific utility functions
- **100-functions-navigation.zsh** - Directory finding and navigation
- **101-functions-file-ops.zsh** - Archive, backup, and file utilities
- **110-functions-development.zsh** - Dev tools and scaffolding
- **120-functions-system.zsh** - System monitoring and maintenance
- **130-functions-network.zsh** - Network and API utilities
- **140-functions-utilities.zsh** - Text, encoding, and general utilities

### Documentation
- **200-help-completion.zsh** - Help system and ZSH completions

## How It Works

1. **own-aliases.zsh** - The main entry point that sources **init.zsh**
2. **init.zsh** - Loads all modular files in numbered order
3. Individual module files - Contain related aliases and functions

## Adding New Aliases

To add new aliases:

1. Choose the appropriate file based on category
2. Add your alias to the relevant section
3. If creating a new category, create a file with an appropriate number

## Benefits

- **Organized** - Related aliases are grouped together
- **Maintainable** - Easy to find and modify specific categories
- **Modular** - Can disable features by commenting out individual files
- **Fast** - Faster to load than a single 2000+ line file
- **Backup** - Original file backed up as `own-aliases.zsh.backup`

## Testing

All individual files have been tested and work correctly. To reload your shell:

```bash
reload  # or
source ~/.zshrc
```

## Size Reduction

- **Before**: own-aliases.zsh (2252 lines, 60 KB)
- **After**: Distributed across 19 files (~50 KB total)
  - Each file is focused and easy to navigate
  - Roughly 50-300 lines per file

## Disabling Features

To disable a specific module, comment out its source line in **init.zsh**:

```zsh
# [[ -f "$ZSH_CUSTOM/90-pnpm-functions.zsh" ]] && source "$ZSH_CUSTOM/90-pnpm-functions.zsh"
```
