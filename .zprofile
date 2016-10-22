GOPATH=$HOME/go
PATH=/bin:/usr/bin:/usr/local/bin:$GOPATH/bin:${PATH}
export PATH

if $(command -v rbenv > /dev/null 2>&1);then
  eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/bin:$PATH"
fi

if $(command -v dinghy > /dev/null 2>&1);then
  eval $(dinghy env)
fi

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
  git add .
  git commit --fixup=HEAD
  git rebase -i --autosquash HEAD^^
  execIfCommandExists tig
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
alias gpo='git push -u origin'
alias gco='git checkout'
alias gche='git checkout'
alias checkout='git checkout'
alias pull='git pull'
alias pull-rebase='git pull --rebase'
alias rebase='git rebase'
alias stash='git stash'
alias push-f='git push -f origin'
alias branch='git branch'
alias commit='git commit'
alias blame='git blame'
alias force-push-to-my-repo='git push -f origin HEAD'

alias fzf-vim='vim $(fzf)'
alias tailf='tail -f'
alias la='ls -lah'
alias ll='ls -lh'
alias cd='cdls'
alias emacs='vim'
