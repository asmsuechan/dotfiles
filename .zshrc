#=============================================================================
# Plugin Manager (zplug) - Modern ZSH plugins
#=============================================================================
# Set ZPLUG_HOME (check Homebrew first, then default location)
if [[ -d "/usr/local/opt/zplug" ]]; then
  # Homebrew on Intel Mac
  export ZPLUG_HOME="/usr/local/opt/zplug"
elif [[ -d "$HOME/homebrew/opt/zplug" ]]; then
  # Homebrew in custom location
  export ZPLUG_HOME="$HOME/homebrew/opt/zplug"
elif [[ -d "/opt/homebrew/opt/zplug" ]]; then
  # Homebrew on Apple Silicon
  export ZPLUG_HOME="/opt/homebrew/opt/zplug"
elif [[ -d "$HOME/.zplug" ]]; then
  # Manual installation
  export ZPLUG_HOME="$HOME/.zplug"
else
  # Not installed - will auto-install
  export ZPLUG_HOME="$HOME/.zplug"
  if [[ ! -d $ZPLUG_HOME ]]; then
    echo "Installing zplug..."
    git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
  fi
fi

# Source zplug
if [[ -f "$ZPLUG_HOME/init.zsh" ]]; then
  source "$ZPLUG_HOME/init.zsh"
else
  echo "Warning: zplug not found at $ZPLUG_HOME"
fi

# Syntax highlighting (must be loaded before autosuggestions)
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3

# Better completions
zplug "zsh-users/zsh-completions"

# Auto-suggestions with better styling
zplug "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Enhanced cd (enhancd)
zplug "b4b4r07/enhancd", use:init.sh

# fzf integration
zplug "junegunn/fzf", use:"shell/*.zsh", defer:2

# Docker aliases
zplug "tcnksm/docker-alias", use:zshrc, as:plugin

# Git utilities
zplug "plugins/git", from:oh-my-zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install missing plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# ディレクトリ移動時いい感じに表示してキーで移動できるようになる
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history

# 補完
#
# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

autoload -U compinit; compinit
autoload -Uz colors; colors

#=============================================================================
# Prompt Configuration - Starship (Modern, fast, customizable prompt)
#=============================================================================
# Initialize Starship if available, otherwise fallback to custom prompt
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
else
  echo "Tip: Install Starship for a better prompt experience: brew install starship"

  # Fallback: Original custom prompt (maintained for compatibility)
  function rprompt-git-current-branch {
    local branch_name st branch_status

    if [ ! -e  ".git" ]; then
      return
    fi
    branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
      branch_status="%F{green}"
    elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
      branch_status="%F{red}?"
    elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
      branch_status="%F{red}+"
    elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
      branch_status="%F{yellow}!"
    elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
      echo "%F{red}!(no branch)"
      return
    else
      branch_status="%F{blue}"
    fi
    echo "${branch_status}[$branch_name]"
  }

  setopt prompt_subst
  PROMPT="%{${fg[yellow]}%}%~ %F{red}>%f "
  RPROMPT='`rprompt-git-current-branch`'
  PROMPT2="%{${fg[yellow]}%} %_ > %{${reset_color}%}"
  SPROMPT="%{${fg[red]}%}correct: %R -> %r ? [n,y,a,e] %{${reset_color}%}"
fi

#=============================================================================
# Vi Mode Keybindings (Preserved from original config)
#=============================================================================
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode

# Show vi mode indicator if not using Starship
if ! command -v starship &> /dev/null; then
  terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
  function zle-line-init zle-keymap-select {
      VIM_NORMAL="%K{green}%F{black}%k%f%K{green}%F{black} % -- NORMAL -- %k%f%K{black}%F{green}%k%f"
      VIM_INSERT="%K{240}%F{black}%k%f%K{240}%F{189} % -- INSERT -- %k%f%K{black}%F{240}%k%f"
      PS1_2="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
      PS1="%{$terminfo_down_sc$PS1_2$terminfo[rc]$fg[cyan]%}%{${fg[yellow]}%}%~ %F{red}>%f "
      RPS1='`rprompt-git-current-branch`'
      zle reset-prompt
  }
  preexec () { print -rn -- $terminfo[el]; }
  zle -N zle-line-init
  zle -N zle-keymap-select
fi

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Note: Prompt configuration moved to Starship section above

# history周り
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
# 入力途中の履歴補完
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
setopt share_history

# コマンドラインでも # 以降をコメントと見なす
setopt INTERACTIVE_COMMENTS
# 曖昧な補完で、自動的に選択肢をリストアップ
setopt AUTO_LIST
setopt prompt_subst
setopt correct

# cd -<tab>で以前移動したディレクトリを表示
setopt auto_pushd
# auto_pushdで重複するディレクトリは記録しない
setopt pushd_ignore_dups

# 履歴を複数の端末で共有する
setopt share_history

# 直前と同じコマンドの場合は履歴に追加しない
setopt hist_ignore_dups

# 先頭がスペースで始まる場合は履歴に追加しない
setopt hist_ignore_space

# 補完に関するオプション
# http://voidy21.hatenablog.jp/entry/20090902/1251918174
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる

setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt list_packed # 補完候補を詰めて表示する
setopt hist_expand

setopt print_eight_bit  #日本語ファイル名等8ビットを通す
# setopt extended_glob  # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt globdots # 明確なドットの指定なしで.から始まるファイルをマッチ
bindkey "^I" menu-complete   # 展開する前に補完候補を出させる(Ctrl-iで補完するようにする)

# ls
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# lsがカラー表示になるようエイリアスを設定
case "${OSTYPE}" in
darwin*)
  # Mac
  alias ls="ls -GF"
  ;;
linux*)
  # Linux
  alias ls='ls -F --color'
  ;;
esac

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# 読み込み順番の問題で色がつかなかったので.zprofileから移動
# cdしたら自動的にlsを実行
function cdls () {
  \cd "$@" && {
    if command -v eza &> /dev/null; then
      eza -l --all --group-directories-first --git --icons
    elif command -v exa &> /dev/null; then
      exa -l --all --group-directories-first --git
    else
      ls -lah
    fi
  }
}
alias cd='cdls'

# Override auto-title when static titles are desired ($ title My new title)
title() { export TITLE_OVERRIDDEN=1; echo -en "\e]0;$*\a"}
# Turn off static titles ($ autotitle)
autotitle() { export TITLE_OVERRIDDEN=0 }; autotitle
# Condition checking if title is overridden
overridden() { [[ $TITLE_OVERRIDDEN == 1 ]]; }
# Echo asterisk if git state is dirty
gitDirty() { [[ $(git status 2> /dev/null | grep -o '\w\+' | tail -n1) != ("clean"|"") ]] && echo "*" }

# Show cwd when shell prompts for input.
precmd() {
   if overridden; then return; fi
   cwd=${$(pwd)##*/} # Extract current working dir only
   print -Pn "\e]0;$cwd$(gitDirty)\a" # Replace with $pwd to show full path
}

# Prepend command (w/o arguments) to cwd while waiting for command to complete.
preexec() {
   if overridden; then return; fi
   printf "\033]0;%s\a" "${1%% *} | $cwd$(gitDirty)" # Omit construct from $1 to show args
}

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/asmsuechan/src/morioka-lab/newtype_website/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/asmsuechan/src/morioka-lab/newtype_website/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/asmsuechan/src/morioka-lab/newtype_website/node_modules/tabtab/.completions/sls.zsh ]] && . /home/asmsuechan/src/morioka-lab/newtype_website/node_modules/tabtab/.completions/sls.zsh

source ~/.zprofile
