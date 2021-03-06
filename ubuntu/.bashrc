# .bashrc

# ------------------------------------------------------------------------
#
# Executed by bash for Non-login shells.
# Comes with clean install of Ubuntu.
# See /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
#
# Included by
# - .bash_profile
# - .zshrc
#
# This file is part of tomkyle/dotfiles
# <https://github.com/tomkyle/dotfiles>
#
# ------------------------------------------------------------------------


# If not running interactively, don't do anything
case $- in
	*i*) ;;
		*) return;;
esac

# ------------------------------------------------------------------------
# Dotfiles configuration
# ------------------------------------------------------------------------
DOTFILES_PATHS="$HOME/.paths"
DOTFILES_ALIASES="$HOME/.aliases"
DOTFILES_LESS="$HOME/.lessrc"
DOTFILES_BASH_PROMPT="$HOME/.bash_prompt"
# ------------------------------------------------------------------------


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000



# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize



# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar



# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"



# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
		debian_chroot=$(cat /etc/debian_chroot)
fi





# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'






# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi



# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi




# ------------------------------------------------------------------------
# tomkyle/dotfiles Path Configuration.
# ------------------------------------------------------------------------

[[ -f "$DOTFILES_PATHS" ]] && source "$DOTFILES_PATHS"


# ------------------------------------------------------------------------
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
# ------------------------------------------------------------------------

[[ -f "$DOTFILES_ALIASES" ]] && source "$DOTFILES_ALIASES"

# ------------------------------------------------------------------------
# LESS pager config
# ------------------------------------------------------------------------
[[ -f "${DOTFILES_LESS}" ]] && source "${DOTFILES_LESS}"


# ------------------------------------------------------------------------
# Prompt configuration (bash only).
# ------------------------------------------------------------------------

if [ -n "$BASH_VERSION" ]; then
	[[ -f "$DOTFILES_BASH_PROMPT" ]] && source "$DOTFILES_BASH_PROMPT"
fi


# ------------------------------------------------------------------------
# List screen sessions
# ------------------------------------------------------------------------
# screen -ls


# ------------------------------------------------------------------------
# Bash git completion
# https://github.com/petervanderdoes/git-flow-completion/wiki/Install-Bash-git-completion
# ------------------------------------------------------------------------

[[ -f "~/.git-flow-completion.bash" ]] && source ~/.git-flow-completion.bash

# ------------------------------------------------------------------------
# Outro
# ------------------------------------------------------------------------
unset DOTFILES_BASH_PROMPT DOTFILES_ALIASES DOTFILES_PATHS;




