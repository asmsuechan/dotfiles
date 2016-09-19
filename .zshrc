source ~/.zplug/zplug

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"

zplug "junegunn/dotfiles", as:command, of:bin/vimcat

zplug "tcnksm/docker-alias", of:zshrc, as:plugin

zplug "k4rthik/git-cal", as:command, frozen:1

zplug "junegunn/fzf-bin", \
    as:command, \
    from:gh-r, \
    file:fzf

zplug "plugins/git", from:oh-my-zsh

zplug "tj/n", do:"make install"

zplug "b4b4r07/enhancd", at:v1
zplug "mollifier/anyframe", commit:4c23cb60

zplug "hchbaw/opp.zsh", if:"(( ${ZSH_VERSION%%.*} < 5 ))"

zplug "b4b4r07/79ee61f7c140c63d2786", \
    from:gist, \
    as:command, \
    of:get_last_pane_path.sh

zplug "stedolan/jq", \
    as:command, \
    file:jq, \
    from:gh-r \
    | zplug "b4b4r07/emoji-cli"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

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

autoload -U compinit; compinit
autoload -Uz colors
colors
PROMPT='%{${fg[green]}%}[ %C %T ]%# '
setopt prompt_subst
setopt correct
