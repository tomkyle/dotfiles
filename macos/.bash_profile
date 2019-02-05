# ========================================================================
#
# .bash_profile
#
# When a Login shell starts up, it reads the files in the following order,
# only reading the first one it encounters.
#
#
# [ ] /etc/profile
# [X] ~/.bash_profile OR   # Not present on clean Ubuntu (added by RVM...)
#                          # Comes with OSX
# [ ] ~/.bash_login OR     # not present on clean Ubuntu
# [ ] ~/.profile           # Comes with clean install of Ubuntu.
#
# This file is part of tomkyle/dotfiles
# <https://github.com/tomkyle/dotfiles>
#
# ========================================================================


# ------------------------------------------------------------------------
# Dotfiles configuration
# ------------------------------------------------------------------------
DOTFILES_PATHS="$HOME/.paths"
DOTFILES_ALIASES="$HOME/.aliases"
DOTFILES_BASH_PROMPT="$HOME/.bash_prompt"


# ------------------------------------------------------------------------
# Path configuration
# ------------------------------------------------------------------------
[[ -f "$DOTFILES_PATHS" ]] && source "$DOTFILES_PATHS"


# ------------------------------------------------------------------------
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.aliases, instead of adding them here directly.
# ------------------------------------------------------------------------
[[ -f "$DOTFILES_ALIASES" ]] && source "$DOTFILES_ALIASES"


# ------------------------------------------------------------------------
# Prompt configuration (bash only)
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

if [[ -f `brew --prefix`/etc/profile.d/bash_completion.sh ]]; then
 	. `brew --prefix`/etc/profile.d/bash_completion.sh
fi


# ------------------------------------------------------------------------
# Outro
# ------------------------------------------------------------------------
unset DOTFILES_BASH_PROMPT DOTFILES_ALIASES DOTFILES_PATHS;
