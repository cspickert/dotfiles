#!/usr/bin/env bash

# Path

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

# History

export HISTSIZE=100000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignorespace:erasedups

_history() {
    _history_sync
    builtin history "$@"
}

_history_sync() {
    builtin history -a
    HISTFILESIZE=$HISTFILESIZE
    builtin history -c
    builtin history -r
}

# Editor

export EDITOR=`which emacs`

# Prompt

export PS1="$ "
export PROMPT_COMMAND=_promptcmd

_promptcmd() {
    _history_sync
    echo -e "$(tput setaf 8)$(pwd | sed "s,$HOME,~,")$(tput sgr0)"
}

# Options

export CLICOLOR=1

# Unset shopts (-u)
shopt -u huponexit      # nohup by default

# Set shopts (-s)
shopt -s histappend     # append instead of rewrite history file
shopt -s globstar       # enable **
shopt -s cmdhist        # multi-line cmds in history
shopt -s lithist        # save newline chars for multiline cmds
shopt -s dirspell       # dirname autocorrection
shopt -s cdspell        # autocorrect cd spelling errors
shopt -s nocaseglob     # case-insensitive completion
shopt -s histverify     # don't immediately parse history items
shopt -s checkjobs      # check for running jobs before exiting
shopt -s checkwinsize   # check window size
shopt -s extglob        # extended pattern matching

# Aliases

# misc
alias reload="source ~/.bashrc"
alias history=_history
alias psearch="ps aux | grep -v grep | grep "

# cd
alias ..="cd .."

# ls
alias ls="ls -F"
alias l="ls -lAh"
alias ll="ls -l"
alias la="ls -A"

# git
alias gl="git pull"
alias gp="git push"
alias gd="git diff"
alias gc="git commit"
alias gca="git commit -a"
alias gco="git checkout"
alias gb="git branch"
alias gst="git status"
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"

# Local

if [[ -f ~/.localrc ]]
then
    source ~/.localrc
fi
