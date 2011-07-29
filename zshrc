# -*- shell-script -*-

[ -z "$PS1" ] && return

#### OPTIONS
setopt incappendhistory histignorealldups histsavenodups noextendedhistory
setopt histignorespace
setopt autopushd
setopt extendedglob cshnullglob noflowcontrol nobgnice nohup nocheckjobs
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
            print -Pn "\e]0;%n@%m:%~\a" # xterm title
            if [ ! -z "$KONSOLE_DCOP" ]; then
                print -Pn "\e]30;%2~\a" # konsole tab
            fi
        }
        precmd
        ;;
esac

#### KEYS
autoload edit-command-line
zle -N edit-command-line

bindkey "\ef" emacs-forward-word
bindkey "\eF" emacs-forward-word
bindkey "\ee" edit-command-line
bindkey "^W" kill-region

#### DEFAULTS
export LESS=-FRSX
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=00:so=00:do=00:bd=00:cd=00:or=00:su=00:sg=00:tw=01;34:ow=01;34:st=01;34:ex=01;32:';
export GREP_COLORS="fn=1;32:ln=0;31:mt=0;43"

if [ "$EMACS" = "t" ]; then
    setopt no_zle
    export PAGER=ecat
    export GIT_PAGER=ecat
fi
if [ -n "$DISPLAY" -a $UID -ne 0 -a -z "$SSH_TTY" ]; then
    export EDITOR=emacsclient-c
else
    export EDITOR=emacs
fi

#### ALIAS
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d='dirs -v|head|tac'
alias r='fc -R'
alias spwd='pwd > ~/.spwd.txt'
alias rpwd='[ -f ~/.spwd.txt ] && { cd $(cat ~/.spwd.txt) && rm ~/.spwd.txt }'
alias mc='. /usr/share/mc/bin/mc-wrapper.sh -d'
alias mmv='noglob zmv -W'
alias mcp='noglob zmv -C -W'
alias mln='noglob zmv -L -W'

alias ls='ls --color=auto'
alias l='ls -l'
alias la='l -a'
alias df='df -h'
alias ka='killall'
alias p='ps -eo pid,user,args --sort user -H'
alias pg='pgrep -lf'
alias e='emacsclient-cf'
alias c='emacsclient-n'
alias se='sudo -e'
alias bc='bc -ql'
bci() {echo -e "ibase=$1\n$(echo $2 | tr '[:lower:]' '[:upper:]')" | bc; }
bco() {echo -e "obase=$1\n$(echo $2 | tr '[:lower:]' '[:upper:]')" | bc; }
alias cl='clisp -q'
alias sbcl='sbcl --noinform'
alias grep='grep --color=auto'
alias g='grep -nH'
alias gi='g -i'
alias gdb='gdb -q'
gdbat() {gdb --eval-command="att $@"; }
alias cci='cvs commit -m'
cdi() {cvs diff -uN "$@" | ECAT_PREFIX=diff ecat; }
alias cst='cvs -n update 2>&1 | grep "^[UPARMC?]"'
alias cmo='cst | grep -E "^(\?|M|A|C|R)"'

#### ZSH
zle -C complete-file complete-word _generic
zstyle ':completion:complete-file::::' completer _files
bindkey "\e^i" complete-file
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select=1
autoload -Uz compinit
compinit
autoload -U zmv

[ -f ~/.alias ] && source ~/.alias
[ -f ~/.zshrc_site ] && source ~/.zshrc_site
