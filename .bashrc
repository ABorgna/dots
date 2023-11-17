#!/bin/bash

# Forked from Emmanuel Rouat's sample bashrc
# http://www.tldp.org/LDP/abs/html/sample-bashrc.html
#
# - ABorgna

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#               Source global definitions (if any)

if [ -f /etc/bashrc ]; then
      . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

if [ -f ~/.bash_alias ]; then
      . ~/.bash_alias   # --> Read .bash_alias, if present.
fi

#               Some settings

# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.

# Reset this
export PROMPT_COMMAND='printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

#               Greeting, motd etc.

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset
ALERT=${BWhite}${On_Red} # Bold White on red background

# Motd
if [ -x /usr/bin/fortune -o -x /usr/games/fortune ]; then
    #clear
    ftn
    echo
fi

# Z - jump around
if [ -f /usr/share/z/z.sh ]; then
    export _Z_NO_PROMPT_COMMAND=1
    export PROMPT_COMMAND="(_z --add \"$(command pwd -P 2>/dev/null)\" 2>/dev/null &) ${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
    . /usr/share/z/z.sh
fi

# function _exit()              # Function to run upon exit of shell.
# {
# }
# trap _exit EXIT

# Red prompt for root
if [ $(id -u) -eq 0 ];
then
    psColor=${BRed}
else
    psColor=${Green}
fi

# Git status functions
function __git_branch(){
    # Disable branch reporting in WSL
    #if grep -qi microsoft /proc/version; then
    #  true # WSL
    #else
    if [ $(git rev-parse --is-inside-work-tree 2> /dev/null) ];
    then
        psColor=$1
        if [ $(git status -s 2> /dev/null | wc -l) -eq 0 ];
        then
            branchColor=${White}
        else
            branchColor=${Red}
        fi
        echo -ne "(\001${branchColor}\002$(git branch --no-color 2> /dev/null | \
            sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' -e '${/^$/d}')${psColor})"
    fi
    #fi
}

PS1="\[${psColor}\]${HOSTNAME:0:1}${HOSTNAME//[a-z]} \w \$(__git_branch \"\[${psColor}\]\")> \[${NC}\]"

export PATH=/home/aborgna/.local/bin:/home/aborgna/.gem/ruby/2.3.0/bin:/usr/extbin:/home/aborgna/bin:$PATH
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTIGNORE="&:bg:fg:ll:h"
export HISTTIMEFORMAT="$(echo -e ${BCyan})[%d/%m %H:%M:%S]$(echo -e ${NC}) "
export HISTCONTROL=ignoredups
export HOSTFILE=$HOME/.hosts
export EDITOR='/usr/bin/nvim'
export GIT_EDITOR='/usr/bin/nvim'
export IRC_CLIENT='weechat'
export BROWSER='firefox'

# Extend PATH with stack's binaries
if [ -x /usr/bin/stack ]; then
  export PATH=$(stack path --compiler-bin):$PATH
fi

# Feel the rainbow
if [ "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

# HSTR configuration
export PROMPT_COMMAND="history -a; history -n${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
if [ -x /usr/bin/hstr ]; then
  alias hh=hstr                    # hh to be alias for hstr
  export HSTR_CONFIG=hicolor       # get more colors
  shopt -s histappend              # append new history items to .bash_history
  export HISTCONTROL=ignorespace   # leading space hides commands from history
  export HISTFILESIZE=10000        # increase history file size (default is 500)
  export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
  # ensure synchronization between bash memory and history file
  export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
  function hstrnotiocsti {
      { READLINE_LINE="$( { </dev/tty hstr ${READLINE_LINE}; } 2>&1 1>&3 3>&- )"; } 3>&1;
      READLINE_POINT=${#READLINE_LINE}
  }
  # if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
  if [[ $- =~ .*i.* ]]; then bind -x '"\C-r": "hstrnotiocsti"'; fi
  export HSTR_TIOCSTI=n
fi

#               Tailoring 'less'

alias more='less'
export PAGER=less

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[0;32m'""
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[00;42;30m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;30m'

# ssh agent
if [ -x /usr/bin/keychain ]; then
    eval $(keychain --eval --noask --quiet --timeout 5)
    # Remember to use "AddKeysToAgent yes" in your ssh config
fi

# hook up direnv
command -v "direnv" > /dev/null;
if [ $? -eq 0 ];
then
  eval "$(direnv hook bash)"
fi

# Setup vscode terminal integration
#[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path bash)"
export VSCODE_SUGGEST=1

# Used on alias
function runDefault() {
    CMD=$1
    DEFAULT=$2
    shift 2

    command -v "${CMD%% *}" > /dev/null;
    if [ $? -eq 0 ];
    then
        eval "$CMD $@";
    else
        eval "$DEFAULT $@";
    fi
}

source "$HOME/.cargo/env"

. "$HOME/.cargo/env"
