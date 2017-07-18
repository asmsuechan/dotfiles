GOPATH=$HOME/go
PATH=/bin:/usr/bin:/usr/local/bin:$GOPATH/bin:${PATH}
export PATH

eval "$(direnv hook zsh)"

if $(command -v rbenv > /dev/null 2>&1);then
  eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/bin:$PATH"
fi

if $(command -v nodenv > /dev/null 2>&1);then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
fi

export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

export ANDROID_HOME=${HOME}/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

function choosable-rake () {
  RAKETASK=$(rake -D | grep '^rake ' | peco)
  if [ -n "$RAKETASK" ];then
    echo $RAKETASK
    bundle exec $RAKETASK
  fi
}

function clip_file () {
  cat $1 | pbcopy
}

function cdls () {
  \cd "$@" && ls -lah
}

function execIfCommandExists () {
  if type $1 2>/dev/null 1>/dev/null;then
    $1
  fi
}

function force-push () {
  CURRENTBRANCH=$(git rev-parse --abbrev-ref HEAD)
  if [[ $CURRENTBRANCH != 'develop' && $CURRENTBRANCH != 'master' ]];then
    git push -f origin HEAD
  else
    echo "your current branch is $CURRENTBRANCH, so you cannot force push by this command"
  fi
}

# 現在の変更を1つ前のコミットと結合する
function gcommit-and-fixup(){
  git commit --fixup=HEAD
  git rebase -i --autosquash HEAD^^
  execIfCommandExists tig
}

function git-grep-exept-long-line() {
  git grep -e $1 --and -e "^.\{0,80\}$"
}

# arg style: <REPO_NAME> <USER_NAME>:<BRANCH_NAME>
# Boostnote asmsuechan:Boostnote
function checkout-another-remote-branch() {
  REPONAME=ever2boost
  IFS=':'
  read -r NAME BRANCH <<< $2
  git remote add $NAME https://github.com/$NAME/$1.git
  git fetch $NAME
  git checkout $BRANCH
}

function history-peco() {
  print -z `history 1 | sed 's/^ *[0-9]* *//' | peco`
}

# rails系のalias
alias rake='bundle exec rake'
alias rails='bundle exec rails'
alias rr='bundle exec rake routes'
alias rT='bundle exec rake -T'
alias rials='rails'
alias rspec='bundle exec rspec'
alias rcon='rails console'
alias rake-tasks='choosable-rake'
alias annotate='bundle exec annotate -i'

# git系のalias
alias gcommit='git commit -m'
alias gco='git checkout'
alias checkout='git checkout'
alias pull='git pull'
alias pull-rebase='git pull --rebase'
alias rebase='git rebase'
alias stash='git stash'
alias branch='git branch'
alias commit='git commit'
alias comit='git commit'
alias blame='git blame'
alias fetch='git fetch'
alias merge='git merge'
alias revert='git revert'

alias fzf-vim='vim $(fzf)'
alias tailf='tail -f'
alias la='ls -lah'
alias ll='ls -lh'
alias cd='cdls'
alias emacs='vim'

alias docker-composer='docker-compose'
alias dc='docker-compose'
alias dcbashrails='docker-compose run rails bash'
alias dcrails='docker-compose run rails'
alias dcbuild='docker-compose build'
alias dcbashweb='docker-compose run web bash'
alias dcweb='docker-compose run web'
alias docker-kill-all='docker kill `docker ps -q`'
alias docker-rm-all='docker rmi -f `docker images -q`'
alias dcup='docker-compose up'

alias python='docker run -it -v `pwd`/:/src -w /src -e PYTHONPATH="/src/.pip" python python'
alias 'pip-install'='docker run -it -v `pwd`/:/src -w /src python pip install --target=/src/.pip'
