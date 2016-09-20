export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "junegunn/dotfiles", at:d3a93d8, as:command, use:bin/vimcat
zplug "tcnksm/docker-alias", use:zshrc, as:plugin
zplug "k4rthik/git-cal", as:command, frozen:1
zplug "plugins/git", from:oh-my-zsh
zplug "tj/n", hook-build:"make install"
zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", at:4c23cb60
zplug "b4b4r07/79ee61f7c140c63d2786", \
    from:gist, \
    as:command, \
    use:get_last_pane_path.sh
zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    rename-to:fzf

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

# ディレクトリ移動時いい感じに表示してキーで移動できるようになる
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history

# vimっぽいキーバインドにする
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
function zle-line-init zle-keymap-select {
  VIM_NORMAL="%K{green}%F{black}%k%f%K{green}%F{189} % NORMAL %k%f%K{black}%F{green}%k%f"
  VIM_INSERT="%K{240}%F{black}%k%f%K{240}%F{189} % INSERT %k%f%K{black}%F{240}%k%f"
  RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
  RPS2=$RPS1
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# history周り
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# 入力途中の履歴補完
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
setopt share_history

autoload -U compinit; compinit
autoload -Uz colors; colors
PROMPT='%{${fg[green]}%}[ %C %T ]%# '
# コマンドラインでも # 以降をコメントと見なす
setopt INTERACTIVE_COMMENTS
# 曖昧な補完で、自動的に選択肢をリストアップ
setopt AUTO_LIST
setopt prompt_subst
setopt correct
