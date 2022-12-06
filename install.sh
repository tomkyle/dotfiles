#!/usr/bin/env bash

#
# This file is part of tomkyle/dotfiles.
# https://github.com/tomkyle/dotfiles
#
# Installation routine inspired by Mathias Bynen's dotfiles repo:
# https://github.com/mathiasbynens/dotfiles
#






# ---------------------------------------------------------
# Runtime Environment
# ---------------------------------------------------------

# Exit if any statement returns a non-true return value.
set -o errexit
# Exit if trying to use an uninitialised variable
set -o nounset
set -o pipefail
# set -o xtrace


# Formatting stuff
readonly C_RED='\033[0;31m'
readonly C_GREEN='\033[0;32m'
readonly C_ORANGE=$(tput setaf 3)
readonly NC='\033[0m' # No Color



# Just a note: Useful characters: ✔ ✘
# Error message and error exit, redirecting stdout to stderr

function e_error {
	echo -e >&2 "${C_RED}Error: ${*}${NC}";
	exit 1;
}

function e_warning {
  echo -e "${C_ORANGE}• Warning: ${*}${NC}"
}

function e_success () {
  printf "${C_GREEN}✔ %s${NC}\n" "${*-}"
}



# --------------------------------------
# Directories to work with
# --------------------------------------

# Absolute path to this script.
declare DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Where to find the OS-related scripts
declare DOTFILES_DIR_UBUNTU
DOTFILES_DIR_UBUNTU="${DOTFILES_DIR}/ubuntu"

declare DOTFILES_DIR_MACOS
DOTFILES_DIR_MACOS="${DOTFILES_DIR}/macos"


declare BACKUP_TMPDIR
BACKUP_TMPDIR=$(mktemp -d "${TMPDIR:-/tmp/}$(basename 0).XXXXXXXXXXXX")  || e_error "Failed to create temp directory."

declare BACKUP_DIR
BACKUP_DIR="${DOTFILES_DIR}/backups"


# --------------------------------------
# Files to install
# --------------------------------------
declare -a COMMON_DOTFILES=(
	"${DOTFILES_DIR}/.ackrc"
	"${DOTFILES_DIR}/.aliases"
	"${DOTFILES_DIR}/.bash_prompt"
	"${DOTFILES_DIR}/.editorconfig"
	"${DOTFILES_DIR}/.gitconfig"
	"${DOTFILES_DIR}/.gitignore_global"
	"${DOTFILES_DIR}/.git-flow-completion.bash"
	"${DOTFILES_DIR}/.git-flow-completion.zsh"
	"${DOTFILES_DIR}/.hyper.js"
	"${DOTFILES_DIR}/.lessrc"
	"${DOTFILES_DIR}/.nanorc"
	"${DOTFILES_DIR}/.nano"
	"${DOTFILES_DIR}/.paths"
	"${DOTFILES_DIR}/.screenrc"
	"${DOTFILES_DIR}/.zshrc"
)

declare -a UBUNTU_DOTFILES=(
	"${DOTFILES_DIR_UBUNTU}/.bashrc"
	"${DOTFILES_DIR_UBUNTU}/.profile"
	"${DOTFILES_DIR_UBUNTU}/.selected_editor"
	"${DOTFILES_DIR_UBUNTU}/Brewfile"
)

declare -a MACOS_DOTFILES=(
	"${DOTFILES_DIR_MACOS}/.bash_profile"
	"${DOTFILES_DIR_MACOS}/.bashrc"
	"${DOTFILES_DIR_MACOS}/.profile"
	"${DOTFILES_DIR_MACOS}/Brewfile"
)

declare -a INSTALL_FILES=()



# --------------------------------------
# Functions
# --------------------------------------

function exit_err {
	echo >&2 "${@}"; exit 1;
}

function createBackup() {
	local dotfile
	dotfile="${1}"

	# Symlinks
	if [ -L "${dotfile}" ]; then
		local link_target
		link_target="$(readlink "${dotfile}")"
		cp -R "${link_target}" "${BACKUP_TMPDIR}/" && rm -Rf "${dotfile}"

	# Regular files
	elif [ -f "${dotfile}" ]; then
		mv "${dotfile}" "${BACKUP_TMPDIR}/"
	fi
}

function installSymlink() {
	local file_basename
	local dotfile

	file_basename="$(basename "${1}")"
	dotfile="${HOME}/${file_basename}"
	printf "%s " "${dotfile}"

	createBackup "${dotfile}" && \
	ln -s "${1}" "${HOME}" && \
	e_success ""

}


# =========================================================
# The main program
# =========================================================

function main() {


	# ---------------------------------------------
	# Load and update Git submodules
	# ---------------------------------------------

	cd "${DOTFILES_DIR}"
	printf "Install submodules ... ";
	git submodule init && git submodule update --remote && e_success ""
	echo ""


	# ---------------------------------------------
	# Add OS-specific files
	# ---------------------------------------------

	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		INSTALL_FILES=( "${COMMON_DOTFILES[@]}" "${UBUNTU_DOTFILES[@]}" )

	elif [[ "$OSTYPE" == "darwin"* ]]; then
		INSTALL_FILES=( "${COMMON_DOTFILES[@]}" "${MACOS_DOTFILES[@]}" )

	else
		e_error "Could not determine OS type"
	fi;


	# ---------------------------------------------
	# Installation routine
	# ---------------------------------------------

	# Go to Home directory; we'll change back when script finished.
	cd "${HOME}"
	printf "This moves existing files or symlinks to a backup directory. Proceed? (y/n) ";
	read -r DOTFILES_OVERWRITE;
	echo ""

	if [[ "${DOTFILES_OVERWRITE}" =~ ^[Yy]$ ]]; then

		# ---------------------------------------------
		# Create symlinks
		# ---------------------------------------------
		for f in "${INSTALL_FILES[@]}"
		do
			installSymlink "${f}"
		done


		# ---------------------------------------------
		# Move backups from TMP to $HOME
		# ---------------------------------------------

		echo ""
		mkdir -p "${BACKUP_DIR}" && \
		mv "${BACKUP_TMPDIR}" "${BACKUP_DIR}/" && \
		e_success "$(printf "Backups in %s/%s\n" "${BACKUP_DIR}" "$(basename "${BACKUP_TMPDIR}")")"

		# ---------------------------------------------
		# Happy End
		# ---------------------------------------------

		echo ""
		echo "• You may want to install homebrew/linuxbrew formulae."
		echo "  Go to your home directory and run 'brew bundle install'"
		echo ""
		echo "• It is recommended to log in again to apply dotfiles."

	else
		echo "Aborted."
	fi;

	cd "${OLDPWD}"
	exit 0
}


main "${@}"

