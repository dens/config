# -*- shell-script -*-

[ -z "$PS1" ] && return
[ -d "$HOME/bin" ] && PATH=$HOME/bin:$PATH
[ -d "$HOME/env" ] && PATH=$HOME/env:$PATH

# setopt share_history hist_ignore_all_dups
setopt inc_append_history hist_ignore_all_dups hist_save_no_dups no_extended_history
setopt hist_ignore_space
setopt autopushd #pushd_ignore_dups
setopt extended_glob csh_null_glob no_flow_control no_bg_nice no_hup no_check_jobs
setopt rmstarsilent

#### WORDCHARS
export DEFAULTWORDCHARS="$WORDCHARS"
export WORDCHARS=""
transpose-words () {
    local WORDCHARS=$DEFAULTWORDCHARS
    builtin zle .transpose-words
}
zle -N transpose-words
copy-prev-word () {
    local WORDCHARS=$DEFAULTWORDCHARS
    builtin zle .copy-prev-word
}
zle -N copy-prev-word

#### HISTORY
export SAVEHIST=100000
export HISTSIZE=$SAVEHIST
export HISTFILE=~/.history
[ -e ~/.static_history ] && fc -R ~/.static_history

#### PROMPT
export PROMPT='%(!.%B%n@%m%b.%n@%m):%2~%(!.#.>) '
precmd () {}
case "$TERM" in
    xterm|rxvt-unicode)
        precmd () {
            print -Pn "\e]0;%n@%m:%~\a"    # xterm title
#            print -Pn "\e]30;%2~\a"        # konsole tab
        }
        precmd
        ;;
esac

#### EMACS
if [ "$EMACS" = "t" ]; then
    setopt no_zle
    export PAGER=@ecat
fi
if [ -n "$DISPLAY" -a $UID -ne 0 -a -z "$SSH_TTY" ]; then
    export EDITOR='emacsclient -c'
else
    export EDITOR=emacs
fi

export LESS=-SRXF

#### KEYS
autoload edit-command-line
zle -N edit-command-line

bindkey "\ef" emacs-forward-word
bindkey "\eF" emacs-forward-word
bindkey "\ee" edit-command-line
bindkey "^W" kill-region

#### runbox
. runbox.zshrc

#### ALIAS
. @.env

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d='dirs -v|head|tac'
alias r='fc -R'
alias spwd='pwd > ~/.spwd.txt'
alias rpwd='[ -f ~/.spwd.txt ] && { cd $(cat ~/.spwd.txt) && rm ~/.spwd.txt }'
alias mmv='noglob zmv -W'
alias mcp='noglob zmv -C -W'
alias mln='noglob zmv -L -W'
alias cst='cvs -n update 2>/dev/null'
alias cmo="cst|grep -E '^(\?|M|A|C|R)'"
alias cdi='cvs diff -uN|ECAT_PREFIX=diff ecat'
alias ccm='cvs commit -m'
alias gst='git status'
alias gcm='git commit -am'
if [ "$EMACS" = "t" ]; then
    alias gdi='git diff | ECAT_PREFIX=diff ecat' 
    alias gdic='git diff --cached | ECAT_PREFIX=diff ecat' 
else
    alias gdi='git diff --color'
    alias gdic='git diff --color --cached'
fi

[ -f ~/.zshrc_site ] && source ~/.zshrc_site

#### ZSH
zle -C complete-file complete-word _generic
zstyle ':completion:complete-file::::' completer _files
bindkey "\e^i" complete-file
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=1
autoload -Uz compinit
compinit
autoload -U zmv

    # precmd() {
    #     emacsclient -e \
    #         "(with-current-buffer (window-buffer (selected-window)) \
    #            (shell-cd \"$PWD\"))" >/dev/null
    # }

# alias 1='ls -1'
# alias t='tree -A'
# alias mc='. /usr/share/mc/bin/mc-wrapper.sh -d'
# tv () {wmctrld tv mplayer -geometry +1440+123 -fs "$@" >/dev/null 2>&1 }

# alias cmo="cvs status 2>&1|grep -v '^cvs status: Examining' | g -E '^(\?|.*((Locally (Modified|Added|Removed))|(Needs Merge)))'"
# alias cst="cvs status 2>&1|grep -Ev '^((cvs status: Examining)|(.*Up-to-date))' | g -E '^(\?|.*Status:)'"

# [ -n "$SSH_TTY" -o $UID -eq 0 ] && export CWDPROMPT="%n@%m:$CWDPROMPT"
# [ -n "$SSH_TTY" ] && local phost="%n@%m:"
# export PROMPT=$'%(!.%{\e[1;31m%}root%{\e[0m%} .)%{\e[1;39m%}'$phost$'%~%{\e[0m%} %(!.#.$) '
        # precmd () {print -Pn "\e]30;$CWDPROMPT\a"; } # konsole tab
# bindkey "^[^[[A" cd-up          # alt-up (rxvt)
# bindkey "^[^[[D" cd-pop         # alt-left (rxvt)

# cd-up () {
#     pushd .. > /dev/null
#     precmd
#     zle reset-prompt
# }
# zle -N cd-up
# cd-pop () {
#     popd > /dev/null
#     precmd
#     zle reset-prompt
# }
# zle -N cd-pop
# bindkey "\e[1;3A" cd-up         # alt-up (konsole)
# bindkey "\e[1;3D" cd-pop        # alt-left (konsole)
