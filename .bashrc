################################################################
# James Flohr

################################
# Manual Path
# Add python 3.10 to path (I'm not reading any more of the archlinux wiki to figure out
#                          how to request a specific version, very frustrating)
# This doesn't work in this shell, probably because it's python for windows
#export PATH="$PATH:/c/UserPrograms/python3.10.5"

################################
# Tmux & Bill Gate's Crap
# Delete the old tmp socket when starting tmux
#  ! We really should try and kill any running tmux procs
alias tm='rm /tmp/tmux-$(id -u)/default; tmux new'

################################################################
# Behavior
################################################################
# Vi mode inputs
set -o vi

# If not running interactively, exit.
# IE: Don't load this conf for remote stuff, corrupting transfers...
#case $- in
#    *i*) ;;
#      *) return;;
#esac

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar
################################################################

################################################################
# HISTORY
################################################################
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
################################################################

################################################################
# Pipes? Visual? Output?
################################################################
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

################################################################

################################################################
# Aliases
################################################################
alias ls='ls --color=auto'
alias ll='ls -la'
alias lt='ls -lta'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
## TODO build libnotify-send from arch
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
################################################################


################################################################
# Prompt
################################################################
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# We have color support; assume it's compliant with Ecma-48
# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# a case would tend to support setf rather than setaf.)
color_prompt=yes
    else
color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
################################################################

################################################################
# Hide Bill Gate's crap...
#  http://superuser.com/questions/650322/ignore-ntuser-dat-files-when-ls-on-git-bash
#  Don't hide things from ls outside home dir
# ! ls_filter.bat '/usr/bin/ls_filter.bat'
# alias ls=ls_filter.bat $*
#
# Just use MYSYS2 - UCRT64
# Git-Bash devs are completely opposed to using it for anything
#  but version control...
################################################################

################################################################
# Cargo Cult Holdover Configs
################################################################

