# .profile

# ------------------------------------------------------------------------
#
# When a Login shell starts up, it reads the files in the following order,
# only reading the first one it encounters.
#
# [ ] /etc/profile
# [ ] ~/.bash_profile or
# [ ] ~/.bash_login or
# [X] ~/.profile          # Comes with clean install of Ubuntu.
#
# This file is not read by bash(1),
# if ~/.bash_profile or ~/.bash_login exists.
# See /usr/share/doc/bash/examples/startup-files for examples.
#
# This file is part of tomkyle/dotfiles
# <https://github.com/tomkyle/dotfiles>
#
# ------------------------------------------------------------------------


# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# ------------------------------------------------------------------------
# Dotfiles configuration
# ------------------------------------------------------------------------
DOTFILES_BASHRC="$HOME/.bashrc"


# ------------------------------------------------------------------------
# set PATH so it includes user's private bin if it exists
# ------------------------------------------------------------------------
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi


# ------------------------------------------------------------------------
# if running bash, include .bashrc if it exists
# ------------------------------------------------------------------------
if [ -n "$BASH_VERSION" ]; then
    [[ -f "$DOTFILES_BASHRC" ]] && source "$DOTFILES_BASHRC"
fi


# ------------------------------------------------------------------------
# Outro
# ------------------------------------------------------------------------
unset DOTFILES_BASHRC;
