# ========================================================================
#
# .bash_aliases
#
# Included by
# - .bash_profile
# - .zshrc
#
# This file is part of tomkyle/dotfiles
# <https://github.com/tomkyle/dotfiles>
#
# ========================================================================



# ------------------------------------------------------------------------
# Dotfiles configuration
# ------------------------------------------------------------------------
DOTFILES_ALIASES_LOCAL="${HOME}/.bash_aliases.local"



# ------------------------------------------------------------------------
# OS Determination
# ------------------------------------------------------------------------
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	DOTFILES_OS="ubuntu"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	DOTFILES_OS="osx"
else
	DOTFILES_OS="unknown"
fi


# ------------------------------------------------------------------------
# Aliases for MacOS
# ------------------------------------------------------------------------
if [[ "$DOTFILES_OS" == "osx" ]]; then

	# Open current directory in new Finder window
	alias t='open -R ${PWD}'

	# Reveal+select specified file in new Finder window
	alias f='open -R'

	# Open specified files in Sublime Text
	alias s='open -a "Sublime Text"'

	# Open specified files in Sublime Text
	alias m='open -a "MacDown"'

fi


# ------------------------------------------------------------------------
# System-related
# ------------------------------------------------------------------------

# Show cronlog
test -d "/var/log/syslog" && alias cronlog="grep CRON /var/log/syslog"

# Show WAN IP
alias wanip="curl -s http://checkip.dyndns.org/ | grep -o '[[:digit:].]\+'"


# ------------------------------------------------------------------------
# Quicker navigation
# ------------------------------------------------------------------------
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."


# ------------------------------------------------------------------------
# Directory Listing
# ------------------------------------------------------------------------
alias lss='ls -lA1'
alias lla='ls -la'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# List all dotfiles in current directory with -la
alias ldots='ls -laA -d .*'


# Shortcut for combining mkdir and cd
mkd()
{
	mkdir -p $1 && cd $1
}
export mkd


# ------------------------------------------------------------------------
# ACK-GREP (and Silver searcher replacement )
# ------------------------------------------------------------------------
if [[ "$DOTFILES_OS" == "ubuntu" ]]; then
	alias af="ack-grep --literal"
	alias aff="ack-grep --literal --files-with-matches"
	alias afr="ack-grep --match"
	alias afw="ack-grep --word-regexp"

elif [[ "$DOTFILES_OS" == "osx" ]]; then
	alias afl="ack --literal"
	alias agl="ag --literal"

	alias aff="ack --literal --files-with-matches"
	alias agf="ag --literal --files-with-matches"

	alias afr="ack --match"
	alias agr="ag --match"

	alias afw="ack --word-regexp"
	alias agw="ag --word-regexp"

fi



# ------------------------------------------------------------------------
# Homebrew
# ------------------------------------------------------------------------

if [[ "$DOTFILES_OS" == "osx" ]]; then
	alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
	alias buu='brew update; brew update; brew upgrade;'
fi

# ------------------------------------------------------------------------
# Vagrant
# ------------------------------------------------------------------------

alias v="vagrant"
alias va="vagrant box add"
alias vai="vagrant init"
alias vu="vagrant up"
alias vupv="vagrant up --provider virtualbox"
alias vh="vagrant halt"
alias vs="vagrant ssh"
alias vgs="vagrant global-status"


# ------------------------------------------------------------------------
# Composer
# ------------------------------------------------------------------------

alias cu="composer update"
alias cuo="composer update --optimize-autoloader"
alias cda="composer dump-autoload"
alias cdao="composer dump-autoload --optimize"

# ------------------------------------------------------------------------
# PhpUnit
# ------------------------------------------------------------------------

alias pu="phpunit"


# ------------------------------------------------------------------------
# Git
# ------------------------------------------------------------------------

alias ga="git add"
alias gs="git status"
alias gd="git diff"
alias gcm="git commit -m"
alias gcam="git commit -a -m"
alias gpom="git push origin master"
alias gpod="git push origin develop"
alias pushom="git push origin master"
alias pushod="git push origin develop"
alias pullom="git pull origin master"
alias pullod="git pull origin develop"


# ------------------------------------------------------------------------
# Git Flow
# ------------------------------------------------------------------------

alias gffs="git flow feature start"
alias gfff="git flow feature finish"
alias gfrs="git flow release start"
alias gfrf="git flow release finish -p"


# ------------------------------------------------------------------------
# Local and private aliases not being provided by this dotfiles repo
# ------------------------------------------------------------------------

[[ -f "$DOTFILES_ALIASES_LOCAL" ]] && source "$DOTFILES_ALIASES_LOCAL"


# ------------------------------------------------------------------------
# Outro
# ------------------------------------------------------------------------
unset DOTFILES_ALIASES_LOCAL DOTFILES_OS;
