# ~/.p10k.zsh - Enhanced Powerlevel10k Configuration
# To customize prompt, run `p10k configure` or edit this file.

# Instant prompt configuration
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Main configuration function
function prompt_my_custom_segment() {
  # Custom segment example - you can add your own here
  p10k segment -t "🚀"
}

# Configuration
() {
  emulate -L zsh -o extended_glob

  # Unset all configuration options (safely)
  if [[ -n ${(M)${(k)parameters}:#POWERLEVEL9K_*} ]]; then
    unset ${(M)${(k)parameters}:#POWERLEVEL9K_*}
  fi

  # Zsh >= 5.1 is required
  [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

  # ===== PROMPT STYLE =====
  typeset -g POWERLEVEL9K_MODE='nerdfont-complete'
  
  # Left prompt segments
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # os_icon                 # OS identifier
    dir                     # Current directory
    vcs                     # Git status
    newline                 # Line break
    prompt_char            # Prompt character
  )
  
  # Right prompt segments  
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status                  # Exit code of the last command
    command_execution_time  # Duration of the last command
    background_jobs        # Background jobs
    direnv                 # Direnv status
    asdf                   # Tool versions (node, python, etc)
    virtualenv             # Python virtual environment
    anaconda               # Conda environment
    pyenv                  # Python version
    goenv                  # Go version
    nodenv                 # Node version
    nvm                    # Node version manager
    nodeenv                # Node environment
    rbenv                  # Ruby version
    rvm                    # Ruby version manager
    fvm                    # Flutter version
    luaenv                 # Lua version
    jenv                   # Java version
    plenv                  # Perl version
    phpenv                 # PHP version
    scalaenv               # Scala version
    haskell_stack          # Haskell stack
    kubecontext            # Kubernetes context
    terraform              # Terraform workspace
    aws                    # AWS profile
    aws_eb_env            # AWS Elastic Beanstalk
    azure                  # Azure account
    gcloud                 # Google Cloud
    google_app_cred       # Google application credentials
    context                # User@hostname
    nordvpn               # NordVPN connection
    ranger                # Ranger shell
    nnn                   # nnn shell
    vim_shell             # Vim shell
    midnight_commander    # Midnight Commander shell
    nix_shell             # Nix shell
    battery               # Battery level
    wifi                  # WiFi speed
    ram                   # RAM usage
    swap                  # Swap usage
    disk_usage           # Disk usage
    load                 # System load
    todo                 # Todo items
    timewarrior          # Timewarrior tracking
    taskwarrior          # Taskwarrior
    time                 # Current time
    ip                   # IP address
    public_ip           # Public IP address
    proxy               # Proxy
    # my_custom_segment   # Custom segment example
  )

  # ===== BASIC STYLING =====
  typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR='%246F\uE0B1'  # grey arrow
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=         # no separators
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION='${P9K_VISUAL_IDENTIFIER// }'  # remove spaces

  # ===== COLORS & ICONS =====
  # OS identification
  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=232
  typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=7
  
  # Prompt character styling
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=76
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=196
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='Ⅴ'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=

  # ===== DIRECTORY =====
  typeset -g POWERLEVEL9K_DIR_BACKGROUND=4
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=254
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=250
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=255
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  
  # Directory icons
  typeset -g POWERLEVEL9K_DIR_CLASSES=(
    '~/Documents(|/*)'  DOCUMENTS
    '~/Downloads(|/*)'  DOWNLOADS  
    '~/Desktop(|/*)'    DESKTOP
    '~/Projects(|/*)'   PROJECTS
    '~/.config(|/*)'    CONFIG
    '/etc(|/*)'         ETC
    '/var/log(|/*)'     LOG
  )
  
  typeset -g POWERLEVEL9K_DIR_DOCUMENTS_VISUAL_IDENTIFIER_EXPANSION='📄'
  typeset -g POWERLEVEL9K_DIR_DOWNLOADS_VISUAL_IDENTIFIER_EXPANSION='📥'
  typeset -g POWERLEVEL9K_DIR_DESKTOP_VISUAL_IDENTIFIER_EXPANSION='🖥️'
  typeset -g POWERLEVEL9K_DIR_PROJECTS_VISUAL_IDENTIFIER_EXPANSION='💼'
  typeset -g POWERLEVEL9K_DIR_CONFIG_VISUAL_IDENTIFIER_EXPANSION='⚙️'
  typeset -g POWERLEVEL9K_DIR_ETC_VISUAL_IDENTIFIER_EXPANSION='⚙️'
  typeset -g POWERLEVEL9K_DIR_LOG_VISUAL_IDENTIFIER_EXPANSION='📋'

  # ===== GIT (VCS) =====
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=2
  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=0
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=3
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=0
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=1
  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=0
  
  # Git icons
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
  typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON='!'
  typeset -g POWERLEVEL9K_VCS_STAGED_ICON='+'
  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='⇣'
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='⇡'
  typeset -g POWERLEVEL9K_VCS_STASH_ICON='*'
  typeset -g POWERLEVEL9K_VCS_TAG_ICON='🏷️ '
  typeset -g POWERLEVEL9K_VCS_COMMITS_AHEAD_ICON='⇡'
  typeset -g POWERLEVEL9K_VCS_COMMITS_BEHIND_ICON='⇣'

  # ===== COMMAND EXECUTION TIME =====
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION='⏱️'

  # ===== STATUS =====
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=2
  typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND=0
  typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION='✅'
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=1
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=0
  typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='❌'

  # ===== KUBERNETES =====
  typeset -g POWERLEVEL9K_KUBECONTEXT_FOREGROUND=7
  typeset -g POWERLEVEL9K_KUBECONTEXT_BACKGROUND=5
  typeset -g POWERLEVEL9K_KUBECONTEXT_VISUAL_IDENTIFIER_EXPANSION='☸️'
  
  # ===== DOCKER =====
  typeset -g POWERLEVEL9K_DOCKER_MACHINE_FOREGROUND=7
  typeset -g POWERLEVEL9K_DOCKER_MACHINE_BACKGROUND=6
  typeset -g POWERLEVEL9K_DOCKER_MACHINE_VISUAL_IDENTIFIER_EXPANSION='🐳'

  # ===== NODE VERSION =====
  typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND=7
  typeset -g POWERLEVEL9K_NODE_VERSION_BACKGROUND=2
  typeset -g POWERLEVEL9K_NODE_VERSION_VISUAL_IDENTIFIER_EXPANSION='⬢'

  # ===== PYTHON VIRTUAL ENV =====
  typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=0
  typeset -g POWERLEVEL9K_VIRTUALENV_BACKGROUND=3
  typeset -g POWERLEVEL9K_VIRTUALENV_VISUAL_IDENTIFIER_EXPANSION='🐍'

  # ===== AWS =====
  typeset -g POWERLEVEL9K_AWS_FOREGROUND=7
  typeset -g POWERLEVEL9K_AWS_BACKGROUND=1
  typeset -g POWERLEVEL9K_AWS_VISUAL_IDENTIFIER_EXPANSION='☁️'

  # ===== TIME =====
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=0
  typeset -g POWERLEVEL9K_TIME_BACKGROUND=7
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
  typeset -g POWERLEVEL9K_TIME_VISUAL_IDENTIFIER_EXPANSION='🕐'

  # ===== BATTERY =====
  typeset -g POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
  typeset -g POWERLEVEL9K_BATTERY_LOW_FOREGROUND=1
  typeset -g POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND=3
  typeset -g POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND=2
  typeset -g POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=7
  
  # Battery icons
  typeset -g POWERLEVEL9K_BATTERY_STAGES=(
    '%K{1}▁' '%K{3}▂' '%K{3}▃' '%K{3}▄' '%K{3}▅'
    '%K{2}▆' '%K{2}▇' '%K{2}█'
  )

  # ===== WIFI =====
  typeset -g POWERLEVEL9K_WIFI_FOREGROUND=0
  typeset -g POWERLEVEL9K_WIFI_BACKGROUND=4
  typeset -g POWERLEVEL9K_WIFI_VISUAL_IDENTIFIER_EXPANSION='📶'

  # ===== RAM =====
  typeset -g POWERLEVEL9K_RAM_FOREGROUND=0
  typeset -g POWERLEVEL9K_RAM_BACKGROUND=3
  typeset -g POWERLEVEL9K_RAM_VISUAL_IDENTIFIER_EXPANSION='🧠'

  # ===== CONTEXT (USER@HOST) =====
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=7
  typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND=0
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
  typeset -g POWERLEVEL9K_CONTEXT_VISUAL_IDENTIFIER_EXPANSION='👤'

  # ===== ADVANCED FEATURES =====
  # Transient prompt (previous commands become minimal)
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir
  
  # Show on command line only
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
  
  # Multiline
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=

  # ===== CUSTOM SEGMENTS =====
  # Example: Show current Git repository URL
  function prompt_git_remote() {
    local remote_url=$(git remote get-url origin 2>/dev/null)
    if [[ -n $remote_url ]]; then
      p10k segment -b 5 -f 7 -t "🔗 ${remote_url##*/}"
    fi
  }

  # Example: Show Docker status
  function prompt_docker_status() {
    if command -v docker &> /dev/null && docker info &> /dev/null; then
      local containers=$(docker ps -q | wc -l | tr -d ' ')
      p10k segment -b 6 -f 7 -t "🐳 $containers"
    fi
  }

  # ===== CONDITIONAL SEGMENTS =====
  # Only show certain segments in specific directories
  typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern'
  typeset -g POWERLEVEL9K_TERRAFORM_SHOW_ON_COMMAND='terraform|tf'

}

# Initialize Powerlevel10k
(( ! ${+functions[p10k]} )) || p10k reload
