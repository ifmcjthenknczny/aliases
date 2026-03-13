# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH='$HOME/.oh-my-zsh'

# Set name of the theme to load --- if set to 'random', it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME='random'

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( 'robbyrussell' 'agnoster' )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE='true'

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE='true'

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS='true'

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS='true'

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE='true'

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION='true'

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS='%F{yellow}waiting...%f'
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS='true'

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY='true'

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# 'mm/dd/yyyy'|'dd.mm.yyyy'|'yyyy-mm-dd'
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS='mm/dd/yyyy'

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

git() {
  if ! command git rev-parse --git-dir &>/dev/null; then
    command git "$@" 2>/dev/null
    return $?
  fi
  if [[ "$1" == diff ]]; then
    command git "$@"
    return $?
  fi
  command git "$@"
}

# User configuration

# export MANPATH='/usr/local/man:$MANPATH'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS='-arch $(uname -m)'

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig='mate ~/.zshrc'
# alias ohmyzsh='mate ~/.oh-my-zsh'

# Actual aliases

unalias gba gm main gr grs gch gd gcount 2>/dev/null

work_directory='~/prog'

export NODE_ENV='local'

alias project='cd \"$work_directory\"'

# This file
alias ali='nano ~/.zshrc'
alias cpali='(cd ~ && cp ~/.zshrc ~/ali/zshrc_copy && echo Aliases copied!)'
alias aliases='(grep -oP "^\s*alias\s+\K\w+" ~/.zshrc && grep -E "^\s*[a-zA-Z_][a-zA-Z0-9_]*\(\)" ~/.zshrc) | sort'

# Git
alias ga='(cds && git add .)'
alias gauto='ga && git commit -m "autosave"'
alias gb='git branch'
alias gca='git gc --aggressive'
alias gcc='git rm -r --cached .'
alias gcd='git commit --no-edit'
alias gcl='git clean -df *'
alias gcne='ga && gcd && gp'
alias gd='git diff HEAD'
alias gf='git fetch --update-head-ok'
alias gfl='gf && git log HEAD..origin/main'
alias gmain='git remote show origin | awk "/HEAD branch/ {print \$NF}"'
alias gl='git log'
alias gp='git push'
alias gpl='git pull --no-ff'
alias grfl='git reflog'
alias grhlc='git reset --hard HEAD^' #grhlc = git reset hard last commit
alias grslc='git reset --soft HEAD^' #grslc = git reset soft last commit
alias grt='git restore .'
alias gs='git status'
alias gsw='git pull && git switch'

alias gkeep='git checkout --ours -- $(git diff --name-only --diff-filter=U)'
alias gtake='git checkout --theirs -- $(git diff --name-only --diff-filter=U)'

alias gdm='git diff $(gmain)...'
alias gcount='git diff HEAD --name-only | wc -l'


gba() {
  if [ -z "$1" ]; then
    git branch -a
  else
    cd ~/$work_directory/$1 && git branch -a
  fi
}

gch() {
  if [ -z "$1" ]; then
    echo 'Provide a branch name'
    return 0
  fi
  git checkout $1 2>/dev/null && yarn install && git status
  if [ $? -ne 0 ]; then
    echo 'Branch "$1" does not exist.'
    matching_branches=$(gba | grep $1)
    count=$(echo '$matching_branches' | wc -l)
    if [ -z '$matching_branches' ]; then
      echo 'And there are no matching branches. So sorry mate.'
    elif [ $count -eq 1 ]; then
      echo 'Only one matching branch found. Checking out to$matching_branches'.
      git checkout $(echo '$matching_branches' | awk '{print $1}') && git pull && yarn install && git status
    else
      echo 'Here are some branches matching:'
      echo '$matching_branches'
    fi
  fi
}

gfm() {
  main_branch=$(gmain)
  git fetch origin $main_branch:$main_branch
}

gm() {
  main_branch=$(gmain)
  git fetch origin $main_branch:$main_branch -u && git merge $main_branch --no-edit
}

gnb() {
  main && gnbs $1 && gm && yarn install && gs
}

gnbs() {
  git pull && git checkout -b $1 && git status
}

gr() {
  local target="$1"
  if [ -z "$1" ]; then
    echo 'Are you sure you want to reset everything in the current directory (Y/N)?'
    read response
    if [[ $response != y && $response != Y ]]; then
      echo 'Aborted by user request'
      return
    fi
      target='.'
      (cds && git restore --staged '$target' && git restore '$target' && git clean -df '$target')
    else
      git restore --staged '$target' && git restore '$target' && git clean -df '$target'
  fi
}

grs() {
  if [ -z "$1" ]; then
    git reset --soft HEAD^
  else
    git reset --soft HEAD~$1
  fi
}

main() {
  main_branch=$(gmain)
  gch $main_branch
}

# Yarn
alias y='yarn'
alias ya='yarn add'
alias yad='yarn add --dev'
alias ybs='yarn run buildAndStart'
alias yf='yarn run lint --fix'
alias yl='(cds && cd ./deployment && y && cd ../lambda-app && y)'
alias yrm='yarn remove'
alias yu='yarn upgrade --frozen-lockfile'
alias yz='yf && ybs'

yr() {
  if [ -z "$1" ]; then
    rm -rf node_modules && sudo rm yarn.lock && yarn
  else
    (cds $1 && rm -rf node_modules && sudo rm yarn.lock && yarn)
  fi
}

yrf() {
  if [ -z "$1" ]; then
    rm -rf node_modules && sudo rm yarn.lock && sudo rm -rf dist && yarn
  else
    (cds $1 && rm -rf node_modules && sudo rm yarn.lock && sudo rm -rf dist && yarn)
  fi
}

# Filesystem
alias c='clear'
alias cp='cp -i'
alias count='ls -1 | wc -l'
alias h='history'
alias hm='cd ~'
alias l='ls -la'
alias mv='mv -i'
alias rm='rm -i'
alias rmd='sudo rm -rf'
alias text='open -a TextEdit'

cds() {
  if [ -z "$1" ]; then
    main_project_folder=$(pwd | tr '/' '\n' | grep -A 1 $work_directory | tail -n 1)
      if [ '$main_project_folder' = '$work_directory' ]; then
        return
      else
        cd ~/$work_directory/$main_project_folder || return
      fi
    else
      cd ~/$work_directory/$1 && gs
  fi
}

# Terminal
his() {
  history | grep $1
}

# K8s
alias k='kubectl'
alias kds='kubectl describe pod'
alias ke='kubectl edit pod'
alias kp='kubectl get pod --label-columns mode --sort-by=.metadata.name'
alias kx='kubectx'
alias pod='kp'

kd() {
  for arg in '$@'; do
    kubectl delete pod -l app='$arg'
  done
}

kdf() {
  k delete pod $1 --grace-period=0 --force
}

kl() {
  kubectl logs -f -l app=$1
}

# compctl -D -f
# compctl -/ -W ~/$work_directory cds

# UV
alias uvc='(rm -rf .venv && uv cache clean)'

# Helm
helm_check() {
  if [ -z "$1" ]; then
    echo 'Podaj ścieżkę do folderu z helm template'
    return 1
  fi
  helm template my-rel $1 -f $1/values-dev.yaml --debug
}

# Random
randstr() {
  local len=${1:-16}
  LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c '$len'
  echo
}

uuidv4() {
  local count=${1:-1}
  for ((i=0; i<count; i++)); do
    local b
    b=($(od -An -N16 -tu1 /dev/urandom))
    printf '%02x%02x%02x%02x-' '${b[0]}' '${b[1]}' '${b[2]}' '${b[3]}'
    printf '%02x%02x-' '${b[4]}' '${b[5]}'
    printf '%02x%02x-' '$(( (b[6] & 0x0f) | 0x40 ))' '${b[7]}'
    printf '%02x%02x-' '$(( (b[8] & 0x3f) | 0x80 ))' '${b[9]}'
    printf '%02x%02x%02x%02x%02x%02x\n' '${b[10]}' '${b[11]}' '${b[12]}' '${b[13]}' '${b[14]}' '${b[15]}'
  done
}

killport() {
  sudo kill -9 $(lsof -t -i:$1)
}
