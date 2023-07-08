# ~/.bashrc: executed by bash(1) for non-login shells.

# Alias definitions
alias l="ls -la"
alias la='ls -A'
alias lc='ls -CF'
alias ll='ls -alF'

alias k="kubectl"
alias kx="kubectx"
alias kds="kubectl describe pod"
alias ke="kubectl edit pod"
alias kp="kubectl get pod --label-columns mode --sort-by=.metadata.name"
alias pod="kp"
alias opd="pod"
alias pdo="pod"

alias myip="curl ipinfo.io/ip"

alias y="yarn"
alias ya="yu && yf && yt"
alias yc="yu && yf"
alias yp="yarn prettify"
alias ymc="yarn migration:create"
alias yt="yarn test"
alias fix="yf && yu && yarn"
alias yft="yf && yt"
alias yr="rm -r node_modules && yarn"
alias yuft="yu && yf && yt"

alias nb="npm build"
alias ncc="npm cache clean --force"
alias nl="npx eslint --ext .ts . --fix"
alias ns="npm start"
alias nt="npm test"

alias fire="ga && git commit -m 'FIRE!!!!' && git push"
alias ga="git add ."
alias gauto="ga && git commit -m 'autosave'"
alias gb="git branch"
alias gcd="git add . && git commit --no-edit"
alias gch="git checkout"
alias gcl="git clean -df *"
alias gd="git diff HEAD"
alias gf="git fetch --update-head-ok"
alias gfm="git fetch origin master:master"
alias gl="git log"
alias gle="rm -f ./.git/index.lock"
alias gm="git fetch origin master:master && git merge master"
alias gp="git push"
alias gpf="git push --force"
alias gpl="git pull --no-ff"
alias grhlc="git reset --hard HEAD~1"
alias grslc="git reset --soft HEAD~1" # git reset soft last commit
alias grf="git reflog"
alias grt="git restore ."
alias gs="git status"
alias gsw="git switch"

alias aliases="(cd ~ && nano .bashrc)"
alias ali="(cd ~ && nano .bashrc)"
alias cpali="(cd ~ && cp .bashrc bashrc_copy && echo aliases copied!)"
alias alicp="cpali"
alias ffc="rm -rf ~/.cache/mozilla/firefox/* && echo \"Cleared firefox cache!\""
alias hm="cd ~"
alias refresh="rm -r ~/.cache/yarn/v6 && docker system prune --all"

# Alias functions
gbd() {
git branch -D $1
}

gnb() {
git checkout master && git fetch && git checkout -b $1 && git status
}

gr() {
if [ -z "$1" ]
then
git reset && git restore --staged . && git restore . && git clean -df .
else
git restore --staged $1 && git restore $1 && git clean -df $1
fi
}

grs() {
git reset --soft HEAD~$1
}

hf() {
git checkout release && git fetch && git checkout origin/release && git checkout -b hotfix-$1
}

his() {
history | grep $1
}

kd() {
for arg in "$@"; do
  kubectl delete pod -l app="$arg"
done
}

kdf() {
k delete pod $1 --grace-period=0 --force
}

kl() {
kubectl logs -f -l app=$1
}
