# ~/.oh-my-zsh/custom/90-pnpm-functions.zsh
# pnpm and Node.js specific functions

# ===============================
# PNPM/NODE ANNOYANCE FIXES
# ===============================

# Fix "node_modules is huge and I want to clean it"
nuke_modules() {
    find . -name "node_modules" -type d -prune -exec rm -rf {} +
    echo "All node_modules directories deleted"
}

# Fix "I need to reinstall everything clean"
pfresh() {
    command rm -rf node_modules pnpm-lock.yaml package-lock.json yarn.lock
    pnpm install
    echo "Fresh pnpm install completed"
}

# Legacy npm fresh install
nfresh() {
    command rm -rf node_modules package-lock.json
    npm install
    echo "Fresh npm install completed"
}

# Fix "I want to quickly check what's using space"
psize() {
    du -sh node_modules 2>/dev/null || echo "No node_modules found"
    echo "Package count: $(find node_modules -name package.json 2>/dev/null | wc -l)"
    if [[ -f pnpm-lock.yaml ]]; then
        echo "pnpm store location: $(pnpm store path)"
        echo "pnpm store size: $(du -sh $(pnpm store path) 2>/dev/null | cut -f1)"
    fi
}

# Fix "I want to audit and fix vulnerabilities quickly"
paudit() {
    pnpm audit
    echo "Run 'pnpm audit --fix' to attempt automatic fixes"
}

# Fix "I want to see outdated packages quickly"
pold() {
    pnpm outdated
}

# Fix "I want to clean pnpm store"
pclean() {
    pnpm store prune
    echo "pnpm store cleaned"
}

# Fix "I want to update all packages"
pupdate() {
    pnpm update --latest
    echo "All packages updated to latest"
}

# Fix "I want to see pnpm info"
pinfo() {
    echo "pnpm Information:"
    echo "==================="
    echo "pnpm version: $(pnpm --version)"
    echo "Store path: $(pnpm store path)"
    echo "Store size: $(du -sh $(pnpm store path) 2>/dev/null | cut -f1 || echo 'Unknown')"
    echo "Node version: $(node --version)"
    echo ""
    pnpm list --depth=0 2>/dev/null || echo "No packages installed"
}

# Fix "I want to create a new project with pnpm"
pcreate() {
    local template="$1"
    local name="$2"

    if [[ -z "$template" ]]; then
        echo "Available templates:"
        echo "  react, vue, svelte, vanilla, typescript"
        echo "Usage: pcreate <template> [project-name]"
        return 1
    fi

    if [[ -z "$name" ]]; then
        name="my-${template}-app"
    fi

    case "$template" in
        react)
            pnpm create react-app "$name"
            ;;
        vue)
            pnpm create vue@latest "$name"
            ;;
        svelte)
            pnpm create svelte@latest "$name"
            ;;
        typescript)
            mkdir "$name" && cd "$name"
            pnpm init
            pnpm add -D typescript @types/node
            pnpm exec tsc --init
            ;;
        vanilla)
            mkdir "$name" && cd "$name"
            pnpm init
            mkdir src
            echo "console.log('Hello World');" > src/index.js
            echo "node_modules/" > .gitignore
            ;;
        *)
            echo "Unknown template: $template"
            return 1
            ;;
    esac

    echo "Project '$name' created with $template template"
}

# Fix "I want to run scripts with fuzzy finder"
prun() {
    if command -v fzf &> /dev/null && [[ -f package.json ]]; then
        local script=$(jq -r '.scripts | keys[]' package.json 2>/dev/null | fzf --prompt="Select script: ")
        if [[ -n "$script" ]]; then
            pnpm run "$script"
        fi
    else
        pnpm run "$1"
    fi
}

# Fix "I want to manage pnpm workspaces easily"
pworkspace() {
    local action="$1"

    case "$action" in
        init)
            echo "packages:" > pnpm-workspace.yaml
            echo "  - 'packages/*'" >> pnpm-workspace.yaml
            mkdir -p packages
            echo "pnpm workspace initialized"
            ;;
        list)
            pnpm -r list --depth=0
            ;;
        clean)
            pnpm -r exec rm -rf node_modules
            command rm -rf node_modules
            echo "All node_modules cleaned from workspace"
            ;;
        install)
            pnpm install
            echo "Workspace dependencies installed"
            ;;
        *)
            echo "pnpm workspace commands:"
            echo "  init    - Initialize workspace"
            echo "  list    - List all packages"
            echo "  clean   - Clean all node_modules"
            echo "  install - Install all dependencies"
            ;;
    esac
}

# Fix "I want to quickly navigate between workspace packages"
pcd() {
    if [[ ! -f pnpm-workspace.yaml ]]; then
        echo "Not in a pnpm workspace"
        return 1
    fi

    if command -v fzf &> /dev/null; then
        local package_dir=$(find packages -name package.json -exec dirname {} \; | fzf --prompt="Select package: ")
        if [[ -n "$package_dir" ]]; then
            cd "$package_dir"
        fi
    else
        echo "Available packages:"
        find packages -name package.json -exec dirname {} \;
    fi
}
