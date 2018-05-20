export ZPLUG_HOME=~/.zplug
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
zplug "b4b4r07/emoji-cli"
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

zplug load

# ディレクトリ移動時いい感じに表示してキーで移動できるようになる
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history

autoload -U compinit; compinit
autoload -Uz colors; colors

# vimっぽいキーバインドにする
terminfo_down_sc=$terminfo[cud1]$terminfo[cuu1]$terminfo[sc]$terminfo[cud1]
function zle-line-init zle-keymap-select {
    VIM_NORMAL="%K{green}%F{black}%k%f%K{green}%F{189} % -- NORMAL -- %k%f%K{black}%F{green}%k%f"
    VIM_INSERT="%K{240}%F{black}%k%f%K{240}%F{189} % -- INSERT -- %k%f%K{black}%F{240}%k%f"
    PS1_2="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
    PS1="%{$terminfo_down_sc$PS1_2$terminfo[rc]$fg[green]%} > $ "
    zle reset-prompt
}
preexec () { print -rn -- $terminfo[el]; }
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
zle -N zle-line-init
zle -N zle-keymap-select

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# gitブランチを表示する
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{blue}%1v%f|)"

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

# コマンドラインでも # 以降をコメントと見なす
setopt INTERACTIVE_COMMENTS
# 曖昧な補完で、自動的に選択肢をリストアップ
setopt AUTO_LIST
setopt prompt_subst
setopt correct

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
