export PATH="/opt/homebrew/bin:$PATH"
work_directory="work"

# This file
alias ali="text ~/.zshrc"
alias cpali="(cd ~ && cp .zshrc zshrc_copy && echo Aliases copied!)"

# Git
alias ga="(cds && git add .)"
alias gas="gauto && git checkout"
alias gauto="ga && git commit -m 'autosave'"
alias gb="git branch"
alias gca="git gc --aggressive"
alias gcd="git commit --no-edit"
alias gcl="git clean -df *"
alias gcne="ga && gcd && gp"
alias gd="git diff HEAD"
alias gf="git fetch --update-head-ok"
alias gmain=echo $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
alias gl="git log"
alias gp="git push"
alias gpl="git pull --no-ff"
alias grfl="git reflog"
alias grhlc="git reset --hard HEAD^" #grhlc = git reset hard last commit
alias grslc="git reset --soft HEAD^" #grslc = git reset soft last commit
alias grt="git restore ."
alias gs="git status"
alias gsw="git switch"

gba() {
if [ -z "$1" ]
then
git branch -a
else
cd ~/$work_directory/$1 && git branch -a
fi
}

gch() {
if [ -z "$1" ]
then
echo "Provide a branch name"
return 0
fi
git checkout $1 2>/dev/null
if [ $? -ne 0 ]; then
  echo "Branch '$1' does not exist."
  matching_branches=$(gba | grep $1)
  if [ -z "$matching_branches" ]; then
    echo "And there are no matching branches. So sorry mate."
  else
    echo "Here are some branches matching:"
    echo "$matching_branches"
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
if [ -z "$1" ]
then
echo "Provide a new branch name"
return 0
fi
main && gnbs $1 && gm && gs
}

gnbs() {
git pull && git checkout -b $1 && git status
}

gr() {
if [ -z "$1" ]
then
echo "Are you sure you want to reset (y/N)?"
read response
if [[ $response != y && $response != Y ]]; then
  echo "Aborted by user request"
  return
fi
git restore --staged . && git restore . && git clean -df .
else
git restore --staged $1 && git restore $1 && git clean -df $1
fi
}


grs() {
if [ -z "$1" ]
then
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
alias y="yarn"
alias ya="yarn add"
alias yad="yarn add --dev"
alias ybs="yarn run buildAndStart"
alias yf="yarn run lint --fix"
alias yl="(cds && cd ./deployment && y && cd ../lambda-app && y)"
alias yu="yarn upgrade --frozen-lockfile"
alias yz="yf && ybs"

yr() {
if [ -z "$1" ]
then
rm -rf node_modules && sudo rm yarn.lock && yarn
else
(cds $1 && rm -rf node_modules && sudo rm yarn.lock && yarn)
fi
}

yrf() {
if [ -z "$1" ]
then
rm -rf node_modules && sudo rm yarn.lock && sudo rm -rf dist && yarn
else
(cds $1 && rm -rf node_modules && sudo rm yarn.lock && sudo rm -rf dist && yarn)
fi
}

# Filesystem
alias hm="cd ~"
alias l="ls -la"
alias rmd="sudo rm -rf"
alias text="open -a TextEdit"

cds() {
if [ -z "$1" ]
then
main_project_folder=$(pwd | tr '/' '\n' | grep -A 1 $work_directory | tail -n 1)
if [ "$main_project_folder" = "$work_directory" ]
then
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
alias k="kubectl"
alias kds="kubectl describe pod"
alias ke="kubectl edit pod"
alias kp="kubectl get pod --label-columns mode --sort-by=.metadata.name"
alias kx="kubectx"
alias pod="kp"

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

# compctl -D -f
# compctl -/ -W ~/$work_directory cds