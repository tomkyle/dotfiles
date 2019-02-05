# ========================================================================
#
# .zshrc
#
# This file is part of tomkyle/dotfiles
# <https://github.com/tomkyle/dotfiles>
#
# ========================================================================

# ------------------------------------------------------------------------
# tomkyle/dotfiles configuration
# ------------------------------------------------------------------------
DOTFILES_PATHS="$HOME/.paths"
DOTFILES_ALIASES="$HOME/.aliases"


# ------------------------------------------------------------------------
# Begin of original .zshrc
# ------------------------------------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

#ZSH_THEME="robbyrussell"
ZSH_THEME="risto"
#ZSH_THEME="geoffgarside"
#ZSH_THEME="maran"


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"


# Edit CW:
# Taken from Repo README:
# If you would like oh-my-zsh to automatically upgrade itself without prompting you, set the following in your ~/.zshrc:
# DISABLE_UPDATE_PROMPT=true



# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-flow-avh osx)

# User configuration



source $ZSH/oh-my-zsh.sh


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ------------------------------------------------------------------------
# ^^^ End of original .zshrc
# ------------------------------------------------------------------------




# ------------------------------------------------------------------------
# tomkyle/dotfiles
# ------------------------------------------------------------------------

# Path configuration
[[ -f "$DOTFILES_PATHS" ]] && source $DOTFILES_PATHS

#  Alias definitions.
[[ -f "$DOTFILES_ALIASES" ]] && source $DOTFILES_ALIASES

# Outro
unset DOTFILES_PATHS DOTFILES_ALIASES;





fpath=(/usr/local/share/zsh-completions $fpath)



# ==> opencolorio
# OpenColorIO requires several environment variables to be set.
# You can source the following script in your shell-startup to do that:
#
#     /usr/local/share/ocio/setup_ocio.sh
#
# Alternatively the documentation describes what env-variables need set:
#
#     http://opencolorio.org/installation.html#environment-variables
#
# You will require a config for OCIO to be useful. Sample configuration files
# and reference images can be found at:
#
#     http://opencolorio.org/downloads.html

[[ -f "/usr/local/share/ocio/setup_ocio.sh" ]] && source /usr/local/share/ocio/setup_ocio.sh
