#=============================================================================
# Path Configuration
#=============================================================================

# Homebrew - set path first (supports custom installation locations)
if [ -d "$HOME/homebrew" ]; then
  # Custom Homebrew location
  export PATH="$HOME/homebrew/bin:$HOME/homebrew/sbin:$PATH"
  export HOMEBREW_PREFIX="$HOME/homebrew"
elif [ -d "/opt/homebrew" ]; then
  # Apple Silicon default
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
  export HOMEBREW_PREFIX="/opt/homebrew"
elif [ -d "/usr/local/Homebrew" ]; then
  # Intel Mac default
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
  export HOMEBREW_PREFIX="/usr/local"
fi

# Go
export GOPATH=$HOME/go
export PATH=/usr/local/git/bin:/bin:/usr/local/bin:/usr/bin:$GOPATH/bin:${PATH}

# Go language
if [ -d "/usr/local/go/bin" ]; then
  export PATH=$PATH:/usr/local/go/bin
fi

# direnv
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# rbenv
if command -v rbenv >/dev/null 2>&1; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
elif [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  if [ -x "$HOME/.rbenv/bin/rbenv" ]; then
    eval "$(rbenv init -)"
  fi
fi

# nodenv
if command -v nodenv >/dev/null 2>&1; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  eval "$(nodenv init -)"
elif [ -d "$HOME/.nodenv" ]; then
  export PATH="$HOME/.nodenv/bin:$PATH"
  if [ -x "$HOME/.nodenv/bin/nodenv" ]; then
    eval "$(nodenv init -)"
  fi
fi

# Postgres.app
if [ -d "/Applications/Postgres.app/Contents/Versions/latest/bin" ]; then
  export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH
fi

# Android SDK
if [ -d "${HOME}/Library/Android/sdk" ]; then
  export ANDROID_HOME=${HOME}/Library/Android/sdk
  export PATH=${PATH}:${ANDROID_HOME}/tools
  export PATH=${PATH}:${ANDROID_HOME}/platform-tools
fi

# perl: warning: Setting locale failed.を回避するためにLANGを設定する。
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

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

# From https://github.com/sorin-ionescu/prezto/blob/master/modules/utility/functions/_cdls_popdls_pushdls
# 原因は不明だけどpreztoに依存する何かがあるおかげで突然ディレクトリのタブ補完が効かなくなった
function _cdls_popdls_pushdls () {
  _cd
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

#=============================================================================
# Modern CLI Tools Aliases
#=============================================================================

# exa (modern ls replacement) - already configured in .zshrc with cdls
# Kept here for direct ls usage
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons'
  alias l='eza -l --all --group-directories-first --git --icons'
  alias ll='eza -l --all --all --group-directories-first --git --icons'
  alias la='eza -la --group-directories-first --git --icons'
  alias lt='eza -T --git-ignore --level=2 --group-directories-first --icons'
  alias llt='eza -lT --git-ignore --level=2 --group-directories-first --icons'
  alias lT='eza -T --git-ignore --level=4 --group-directories-first --icons'
  alias tree='eza -T --icons'
elif command -v exa >/dev/null 2>&1; then
  alias ls='exa'
  alias l='exa -l --all --group-directories-first --git'
  alias ll='exa -l --all --all --group-directories-first --git'
  alias lt='exa -T --git-ignore --level=2 --group-directories-first'
  alias llt='exa -lT --git-ignore --level=2 --group-directories-first'
  alias lT='exa -T --git-ignore --level=4 --group-directories-first'
else
  alias l='ls -lah'
  alias ll='ls -alF'
  alias la='ls -A'
fi

# bat (modern cat with syntax highlighting)
if command -v bat >/dev/null 2>&1; then
  alias cat='bat --style=auto'
  alias bathelp='bat --plain --language=help'
  help() {
    "$@" --help 2>&1 | bathelp
  }
fi

# fd (modern find)
if command -v fd >/dev/null 2>&1; then
  alias find='fd'
fi

# ripgrep (modern grep)
if command -v rg >/dev/null 2>&1; then
  alias grep='rg'
fi

# delta (modern diff for git)
if command -v delta >/dev/null 2>&1; then
  export GIT_PAGER='delta'
fi

# Modern du alternative
if command -v dust >/dev/null 2>&1; then
  alias du='dust'
fi

# Modern top alternative
if command -v btop >/dev/null 2>&1; then
  alias top='btop'
elif command -v htop >/dev/null 2>&1; then
  alias top='htop'
fi

# rails系のalias
# alias rake='bundle exec rake'
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

# alias python='docker run -it -v `pwd`/:/src -w /src -e PYTHONPATH="/src/.pip" python python'
# alias 'pip-install'='docker run -it -v `pwd`/:/src -w /src python pip install --target=/src/.pip'

# pyenv
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
elif [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  if [ -x "$PYENV_ROOT/bin/pyenv" ]; then
    eval "$(pyenv init -)"
  fi
fi

# Rust/Cargo
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

export TERM='xterm-256color'

# Yarn global bin
if command -v yarn >/dev/null 2>&1; then
  YARN_GLOBAL_BIN="$(yarn global bin 2>/dev/null)"
  if [ -n "$YARN_GLOBAL_BIN" ]; then
    export PATH="$PATH:$YARN_GLOBAL_BIN"
  fi
fi
