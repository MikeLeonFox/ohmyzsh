# ~/.oh-my-zsh/custom/60-package-managers.zsh
# Package manager aliases (pnpm, npm, yarn, python)

# ===============================
# PNPM ALIASES (PRIMARY PACKAGE MANAGER)
# ===============================
alias p='pnpm'
alias pi='pnpm install'
alias pa='pnpm add'
alias pad='pnpm add --save-dev'
alias pag='pnpm add --global'
alias pr='pnpm run'
alias pstart='pnpm start'
alias pt='pnpm test'
alias pb='pnpm build'
alias pwatch='pnpm run watch'
alias pdev='pnpm run dev'
alias plint='pnpm run lint'
alias pf='pnpm run format'
alias pup='pnpm update'
alias pout='pnpm outdated'
alias prm='pnpm remove'

# pnpm shortcuts
alias px='pnpm exec'
alias pdlx='pnpm dlx'
alias pls='pnpm list'
alias pwhy='pnpm why'

# pnpm workspace shortcuts
alias pw='pnpm -w'
alias pwa='pnpm -w add'
alias pwr='pnpm -w run'
alias pwls='pnpm -r list'
alias pwrun='pnpm -r run'

# ===============================
# LEGACY NPM/YARN (for non-pnpm projects)
# ===============================
alias n='npm'
alias ni='npm install'
alias nr='npm run'
alias nt='npm test'
alias nb='npm run build'
alias ndev='npm run dev'

alias y='yarn'
alias ya='yarn add'
alias yr='yarn run'
alias ys='yarn start'
alias yt='yarn test'
alias yb='yarn build'

# ===============================
# PYTHON/PIP ALIASES
# ===============================
alias py='python3'
alias pip='pip3'
alias pipi='pip3 install'
alias pipu='pip3 install --upgrade'
alias pipf='pip3 freeze'
alias pipr='pip3 install -r requirements.txt'
alias venv='python3 -m venv'
alias venvon='source venv/bin/activate'
alias venvoff='deactivate'
