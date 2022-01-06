# .zshrc


# ------------------------------------------------------------------------
#
# This file is part of tomkyle/dotfiles
# <https://github.com/tomkyle/dotfiles>
#
# ------------------------------------------------------------------------

# ------------------------------------------------------------------------
# tomkyle/dotfiles configuration
# ------------------------------------------------------------------------
DOTFILES_PATHS="$HOME/.paths"
DOTFILES_LESS="$HOME/.lessrc"
DOTFILES_ALIASES="$HOME/.aliases"
DOTFILES_GITFLOW_COMPLETION="$HOME/.git-flow-completion.zsh"




# ========================================================================
# Begin of original Oh-my-zsh's .zshrc
# https://github.com/robbyrussell/oh-my-zsh/blob/master/templates/zshrc.zsh-template
# ========================================================================

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)






# ------------------------------------------------------------------------
# BEGIN tomkyle/dotfiles snippet:
# ------------------------------------------------------------------------

# Override
ZSH_THEME="risto"
export UPDATE_ZSH_DAYS=13


# Add certain plugins:
# https://project-awesome.org/unixorn/awesome-zsh-plugins
#
# https://github.com/zpm-zsh/colorize
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copydir
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/copyfile
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/jsontools
# https://github.com/walesmd/caniuse.plugin.zsh
#
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/macos
#
if [ ! -d "$ZSH/custom/plugins/caniuse" ]; then
	git clone https://github.com/walesmd/caniuse.plugin.zsh "$ZSH/custom/plugins/caniuse"
fi

plugins+=(git-flow-avh colorize copydir copyfile web-search jsontools caniuse)

if [[ "${OSTYPE}" == "darwin"* ]]; then
	plugins+=(macos)
fi


echo;
echo "Loaded ZSH plugins: ${plugins}"
echo;


### Jump word-wise
# https://stackoverflow.com/questions/12382499/looking-for-altleftarrowkey-solution-in-zsh

# Disabled on 30.01.2021
# as word-wise jumping can be set in terminal app

# bindkey "^[[1;3C" forward-word
# bindkey "^[[1;3D" backward-word



### Disabled causing problems at login...
# AG_ZSH_COMPLETION="/home/linuxbrew/.linuxbrew/share/zsh/site-functions/_the_silver_searcher"
#
# if [[ -f "${AG_ZSH_COMPLETION}" ]]; then
#     source "${AG_ZSH_COMPLETION}"
# fi


### Fix an issue with oh-my-zsh:
# Message: "Insecure completion-dependent directories detected"
#
# Issue:    https://github.com/ohmyzsh/ohmyzsh/issues/6835
# Solution: https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-390216875
ZSH_DISABLE_COMPFIX=true


# NVM is not officially supported with Homebrew by manufacturer.
#
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# GH completiomns for zsh
# https://cli.github.com/manual/gh_completion
autoload -U compinit
compinit -i


# ------------------------------------------------------------------------
# ^ END tomkyle/dotfiles snippet.
# Below the rest of the original .zshrc
# ------------------------------------------------------------------------








source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ========================================================================
# ^^^ End of original .zshrc
# ========================================================================



# ------------------------------------------------------------------------
# tomkyle/dotfiles
# ------------------------------------------------------------------------


# Path configuration
[[ -f "${DOTFILES_PATHS}" ]] && source "${DOTFILES_PATHS}"

# Alias definitions.
[[ -f "${DOTFILES_ALIASES}" ]] && source "${DOTFILES_ALIASES}"

# LESS pager config
[[ -f "${DOTFILES_LESS}" ]] && source "${DOTFILES_LESS}"

# Git flow completion:
# https://github.com/petervanderdoes/git-flow-completion
[[ -f "${DOTFILES_GITFLOW_COMPLETION}" ]] && source "${DOTFILES_GITFLOW_COMPLETION}"


# Outro
unset DOTFILES_PATHS DOTFILES_LESS DOTFILES_ALIASES DOTFILES_GITFLOW_COMPLETION;



