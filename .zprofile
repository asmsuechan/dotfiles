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

# rails系のalias
alias rake='bundle exec rake'
alias rails='bundle exec rails'
alias rr='bundle exec rake routes'
alias rT='bundle exec rake -T'
alias rials='rails'
alias rspec='bundle exec rspec'
alias rcon='rails console'
alias rake-tasks='choosable-rake'

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
alias force-push='git push -f origin HEAD'

alias fzf-vim='vim $(fzf)'
alias tailf='tail -f'
alias la='ls -lah'
alias ll='ls -lh'
alias cd='cdls'
