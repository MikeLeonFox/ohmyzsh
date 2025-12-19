# ~/.oh-my-zsh/custom/110-functions-development.zsh
# Development utilities and helper functions

# ===============================
# PROJECT SCAFFOLDING
# ===============================

# Fix "I want to quickly start a project"
quickstart() {
    local name="$1"
    local type="${2:-node}"

    if [[ -z "$name" ]]; then
        echo "Usage: quickstart <project-name> [node|python|go]"
        return 1
    fi

    mkdir "$name" && cd "$name"

    case "$type" in
        node)
            pnpm init
            echo "console.log('Hello World');" > index.js
            echo "node_modules/" > .gitignore
            echo "dist/" >> .gitignore
            ;;
        python)
            echo "print('Hello World')" > main.py
            echo "venv/" > .gitignore
            echo "__pycache__/" >> .gitignore
            echo "*.pyc" >> .gitignore
            ;;
        go)
            command go mod init "$name"
            echo 'package main

import "fmt"

func main() {
    fmt.Println("Hello World")
}' > main.go
            ;;
    esac

    git init
    git add .
    git commit -m "Initial commit"
    echo "Project '$name' created and initialized with $type"
}

# ===============================
# HTTP & API TESTING
# ===============================

# Fix "I want to quickly test an HTTP endpoint"
httptest() {
    local url="$1"
    local method="${2:-GET}"

    echo "Testing $method $url"
    echo "========================"
    curl -w "Status: %{http_code}\nTime: %{time_total}s\nSize: %{size_download} bytes\n" \
         -X "$method" \
         -s \
         -o /dev/null \
         "$url"
}

# ===============================
# LOCAL PORT SCANNING
# ===============================

# Fix "I want to see what ports are open on localhost"
scanlocal() {
    echo "Scanning common local ports..."
    for port in 80 443 3000 3001 8000 8080 5000 4200 8888 9000 5432 3306 6379 27017; do
        if nc -z localhost $port 2>/dev/null; then
            echo "Port $port: OPEN"
        fi
    done
}

# ===============================
# TEST DATA GENERATION
# ===============================

# Fix "I want to quickly generate test data"
testdata() {
    local type="${1:-json}"
    local count="${2:-10}"

    case "$type" in
        json)
            echo "["
            for i in $(seq 1 $count); do
                echo "  {\"id\": $i, \"name\": \"Item $i\", \"value\": $((RANDOM % 100))}"
                [[ $i -lt $count ]] && echo ","
            done
            echo "]"
            ;;
        csv)
            echo "id,name,value"
            for i in $(seq 1 $count); do
                echo "$i,Item $i,$((RANDOM % 100))"
            done
            ;;
        *)
            echo "Usage: testdata [json|csv] [count]"
            ;;
    esac
}

# ===============================
# DEVELOPMENT UTILITIES
# ===============================

# Package.json helpers
deps() {
    if [[ -f package.json ]]; then
        cat package.json | jq -r '.dependencies | keys[]' | sort
    else
        echo "No package.json found"
    fi
}

devdeps() {
    if [[ -f package.json ]]; then
        cat package.json | jq -r '.devDependencies | keys[]' | sort
    else
        echo "No package.json found"
    fi
}

scripts() {
    if [[ -f package.json ]]; then
        cat package.json | jq -r '.scripts'
    else
        echo "No package.json found"
    fi
}

# Code statistics
loc() {
    find . -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" | xargs wc -l | tail -1
}

# Find TODOs in code
todos() {
    grep -r "TODO\|FIXME\|XXX\|HACK" --include="*.js" --include="*.ts" --include="*.jsx" --include="*.tsx" --include="*.py" --include="*.rb" --include="*.go" . | head -20
}

# Test specific functions
testfile() {
    if [[ -f package.json ]]; then
        npm test -- "$1"
    else
        echo "No package.json found"
    fi
}

# Code formatting
format() {
    if command -v prettier &> /dev/null; then
        prettier --write .
    elif [[ -f package.json ]]; then
        npm run format
    else
        echo "No formatter found"
    fi
}
