# ~/.oh-my-zsh/custom/200-help-completion.zsh
# Help system and ZSH completions

# ===============================
# HELP SYSTEM
# ===============================

help() {
    cat << 'EOF'
Enhanced Command Line Functions (80+ Functions):

IMPORTANT NOTES:
  - Use 'command <cmd>' to bypass aliases (e.g., 'command cp' for non-interactive)
  - 'code' alias removed - VS Code CLI won't conflict
  - System commands (mount, shutdown, etc.) require explicit 'sudo'
  - Go lang 'go' command is preserved (no alias conflict)

NAVIGATION & FILES:
  mkcd <dir>       - Create and enter directory
  fcd              - Fuzzy find and change directory
  proj [name]      - Go to project directory (fuzzy finder)
  bookmark [name]  - Bookmark current directory
  listbookmarks    - List all bookmarks
  up [n]           - Go up n directories

FILE OPERATIONS:
  ff <pattern>     - Smart file finder with preview
  fdir <pattern>   - Find directories
  ffile <pattern>  - Find files
  ftype <ext>      - Find files by extension
  extract <file>   - Universal archive extractor
  archive <name>   - Create archive
  backup <file>    - Smart backup with rotation
  large [size]     - Find files larger than size
  duplicates       - Find duplicate files
  info <file>      - Show detailed file information

GIT WORKFLOW:
  gcp 'msg'        - Add, commit with message, and push
  gcpp 'msg'       - Add, commit, push (same as gcp, both auto-push now)
  gfeat 'msg' [files...] - Semantic commit: feat, and push
  gfix 'msg' [files...]  - Semantic commit: fix, and push
  gdocs 'msg' [files...] - Semantic commit: docs, and push
  gstyle 'msg' [files...] - Semantic commit: style, and push
  grefactor 'msg' [files...] - Semantic commit: refactor, and push
  gtest 'msg' [files...] - Semantic commit: test, and push
  gchore 'msg' [files...] - Semantic commit: chore, and push
  gperf 'msg' [files...] - Semantic commit: perf (performance), and push
  gbuild 'msg' [files...] - Semantic commit: build, and push
  gci 'msg' [files...] - Semantic commit: ci (continuous integration), and push
  grevert 'msg' [files...] - Semantic commit: revert, and push
  NOTE: Use simple filenames like 'own-aliases' (without path/extension) for convenience
  gnew <branch>    - Create and push new branch
  gsync            - Sync with main branch
  gcleanup         - Clean merged branches
  gfzf             - Fuzzy select files to add
  glog             - Git log with file changes
  gblame <file>    - Git blame with context

GIT ANNOYANCE FIXES:
  gwrongbranch <b> - Move last commit to new branch
  guncommit        - Undo commit but keep changes
  gnuke            - Remove last commit from history
  gwip / gunwip    - Save/restore work in progress
  gback            - Switch to previous branch
  gcompare <b1> <b2> - Compare branches

PNPM WORKFLOW:
  pfresh           - Clean reinstall (removes lock files)
  psize            - Check node_modules & pnpm store size
  paudit           - Audit with fix suggestions
  pclean           - Clean pnpm store
  pinfo            - Complete pnpm system info
  pcreate <t> [n]  - Create projects (react, vue, etc.)
  prun             - Fuzzy-find and run scripts
  pworkspace <act> - Manage workspaces (init/list/clean)
  pcd              - Navigate between workspace packages

DEVELOPMENT:
  deps             - List package dependencies
  devdeps          - List dev dependencies
  scripts          - Show npm scripts
  loc              - Count lines of code
  todos            - Find TODO comments
  format           - Format code with prettier
  testfile <file>  - Test specific file
  quickstart <name> - Scaffold new projects

DOCKER & KUBERNETES:
  dbash <container> - Bash into container
  dsh <container>  - Shell into container
  dcleanup         - Clean Docker system
  dwatch <cont>    - Watch container logs
  dstats           - Docker resource usage
  dstopall         - Stop all containers
  dcleanall        - Remove all containers/images
  kexec <pod>      - Exec into pod
  kpf <pod>        - Port forward with auto-detect
  klog <pod>       - Pod logs with grep

SYSTEM MONITORING:
  sysinfo          - Complete system information
  topcpu [n]       - Top CPU processes
  topmem [n]       - Top memory processes
  psg <pattern>    - Find processes (clean output)
  ports [port]     - Check port usage
  netdiag <host>   - Network diagnostics
  whoport <port>   - See what's using a port
  killdev          - Kill processes on dev ports
  hungry           - Show resource hogs

NETWORK & API:
  httpget <url>    - HTTP GET with stats
  httppost <url>   - HTTP POST with data
  api <method>     - API testing
  myip             - Show public IP and location
  portscan <host>  - Scan ports on host
  net              - Check network connectivity
  alive <host>     - Check if service responds
  scanlocal        - Scan common local ports

UTILITIES:
  weather [city]   - Full weather forecast
  genpass [len]    - Generate secure password
  qrcode <text>    - Generate QR code
  shorten <url>    - Shorten URL
  serve [port]     - Enhanced HTTP server
  killport <port>  - Kill process on port
  fkill            - Interactive process killer
  timer <sec>      - Quick countdown timer
  uuid             - Generate UUID
  testdata [type]  - Generate test data

ENCODING/TEXT:
  search <term>    - Content search with context
  replace <s> <r>  - Search and replace in files
  json <file>      - Pretty print JSON
  b64 / unb64      - Base64 encode/decode
  urlencode/decode - URL encode/decode

SYSTEM MAINTENANCE:
  clean            - Complete system cleanup
  cleanup          - Remove junk files (.DS_Store, etc.)
  diskpig          - Find what's eating disk space
  monitor          - Live system resource monitoring
  hosts            - Edit /etc/hosts
  fstab            - Edit /etc/fstab
  sudoers          - Edit sudoers file
  own <path>       - Take ownership of files
  nuke <path>      - Force delete with sudo
  fixown <path>    - Fix ownership recursively
  bigdirs          - Find largest directories
  rmempty          - Remove empty directories

NOTES & TASKS:
  note <text>      - Add timestamped note
  notes            - Show recent notes
  searchnotes <q>  - Search in notes
  clearnotes       - Clear all notes
  task <text>      - Add task
  tasks            - Show pending tasks
  taskdone         - Mark all tasks complete

QUICK SHORTCUTS:
  now              - Current time
  timestamp        - Timestamp for filenames
  calc <expr>      - Calculator
  random           - Generate random hex
  reload / rl      - Reload shell config
  c / cls / clr    - Clear screen variants
  colors           - Show terminal color palette

Type 'help' for this reference anytime!
EOF
}

# ===============================
# ZSH GIT COMPLETION SETUP
# ===============================

# Auto-completion for git semantic commit functions
# Shows changed/untracked files when you press tab
_git_semantic_completion() {
    local expl

    # Get modified/untracked files from git status
    local -a files
    files=(${(f)"$(git status --porcelain 2>/dev/null | awk '{print $NF}')"})

    if (( ${#files[@]} )); then
        _describe -t git-files "git files" files
    fi
}

# Register zsh completion for all semantic commit functions
compdef _git_semantic_completion gfeat
compdef _git_semantic_completion gfix
compdef _git_semantic_completion gdocs
compdef _git_semantic_completion gstyle
compdef _git_semantic_completion grefactor
compdef _git_semantic_completion gtest
compdef _git_semantic_completion gchore
compdef _git_semantic_completion gperf
compdef _git_semantic_completion gbuild
compdef _git_semantic_completion gci
compdef _git_semantic_completion grevert
compdef _git_semantic_completion gcp
compdef _git_semantic_completion gcpp
