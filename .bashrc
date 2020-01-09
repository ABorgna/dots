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
}

PS1="\[${psColor}\]${HOSTNAME:0:1}${HOSTNAME//[a-z]} \w \$(__git_branch \"\[${psColor}\]\")> \[${NC}\]"

export PATH=/home/z/.gem/ruby/2.3.0/bin:/usr/extbin:/home/z/bin:$PATH
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTIGNORE="&:bg:fg:ll:h"
export HISTTIMEFORMAT="$(echo -e ${BCyan})[%d/%m %H:%M:%S]$(echo -e ${NC}) "
export HISTCONTROL=ignoredups
export HOSTFILE=$HOME/.hosts
export EDITOR='/usr/bin/nvim'
export GIT_EDITOR='/usr/bin/nvim'
export IRC_CLIENT='weechat'

# Extend PATH with stack's binaries
if [ -x /usr/bin/stack ]; then
  export PATH=$(stack path --compiler-bin):$PATH
fi

# Feel the rainbow
if [ "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
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


#               File & strings related functions:

function swap() { # Swap 2 filenames around, if they exist (from Uzi's bashrc).
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function extract() {    # Handy Extract Program
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}


# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

function wt() {  # weather
    echo -n "Weather in Bs. As.: "
    curl -skL 'http://xml.weather.yahoo.com/forecastrss?w=468739&u=c' \
    | sed -n 's/.*yweather:condition.*text="\([^"]*\)".*temp="\([^"]*\)".*/\1 \2C/p'
}

function ii() { # Get current host related info.
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; mydf / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; my_ip; my_ip_wlan
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}

function repeat() {     # Repeat n times command.
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}

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
