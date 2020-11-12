# exports
export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:$PATH"

export LC_ALL=sv_SE.utf-8
export LANG=sv_SE.utf-8
export LC_CTYPE=sv_SE.utf-8

export PATH="/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH"

export VISUAL=vim
export EDITOR="$VISUAL"

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

C_DEF="\[\e[m\]"
C_RED="\[\e[0;31m\]"
C_GREEN="\[\e[0;32m\]"
C_ORANGE="\[\e[0;33m\]"
C_BLUE="\[\e[0;34m\]"
C_PURPLE="\[\e[0;35m\]"
C_CYAN="\[\e[0;36m\]"
C_WHITE="\[\e[0;37m\]"
N_JOBS='`[ \j -gt 0 ] && echo " (\j)"`'

export PS1="$C_ORANGE\u$C_DEF@\h$C_RED:$C_GREEN\w $C_RED\$$C_DEF$C_PURPLE$N_JOBS$C_DEF "

# aliases
alias ls='ls -hN --color=auto --group-directories-first'
alias dunnet='emacs -batch -l dunnet'


