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



# --------------------------------------
# Directories to work with
# --------------------------------------

# Absolute path to this script.
declare DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Where to find the OS-related scripts
declare DOTFILES_DIR_UBUNTU="${DOTFILES_DIR}/ubuntu"
declare DOTFILES_DIR_MACOS="${DOTFILES_DIR}/macos"


declare BACKUP_TMPDIR=$(mktemp -d "${TMPDIR:-/tmp/}$(basename 0).XXXXXXXXXXXX")  || { exit_err "Failed to create temp directory."; }
declare BACKUP_DIR="${DOTFILES_DIR}/backups"
declare NANO_DIR="${HOME}/.nano/"

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
	"${DOTFILES_DIR}/.lessrc"
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

declare -a COMMON_REALFILES=(
	"${DOTFILES_DIR}/.nanorc"
)



# --------------------------------------
# Functions
# --------------------------------------

function exit_err {
	echo >&2 "${@}"; exit 1;
}

function createBackup() {
	local file_basename
	local dotfile

	file_basename=$(basename ${1})
	dotfile="${HOME}/${file_basename}"

	printf "\n%s " "${dotfile}"

	# Symlinks
	if [ -L "${dotfile}" ]; then
		local link_target
		printf " ... backup symlink ... "
		link_target="$(readlink "${dotfile}")"
		cp "${link_target}" "${BACKUP_TMPDIR}/" && rm "${dotfile}" && echo "Done."

	# Regular files
	elif [ -f "${dotfile}" ]; then
		printf " ... backup regular file ... "
		mv "${dotfile}" "${BACKUP_TMPDIR}/" && echo "Done."
	fi
}


function installRealFile() {
	createBackup "${1}"
	cp "${1}" "${HOME}"
}

function installSymlink() {
	createBackup "${1}"
	ln -sv "${1}" "${HOME}"
}


# =========================================================
# The main program
# =========================================================

function main() {


	# Go to Dotfiles directory; we'll change back when script finished.
	cd "${DOTFILES_DIR}"

	# ---------------------------------------------
	# Load and update Git submodules
	# ---------------------------------------------

	printf "Install submodules ... ";
	git submodule init && git submodule update --remote  && echo "Done."
	echo ""

	# ---------------------------------------------
	# Add OS-specific files
	# ---------------------------------------------

	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		INSTALL_FILES=( "${COMMON_DOTFILES[@]}" "${UBUNTU_DOTFILES[@]}" )

	elif [[ "$OSTYPE" == "darwin"* ]]; then
		INSTALL_FILES=( "${COMMON_DOTFILES[@]}" "${MACOS_DOTFILES[@]}" )

	else
		exit_err "Could not determine OS type"
	fi;


	# ---------------------------------------------
	# Installation routine
	# ---------------------------------------------

	# Go to Home directory; we'll change back when script finished.
	cd "${HOME}"

	printf "This moves existing files or symlinks to a backup directory. Proceed? (y/n) ";
	read DOTFILES_OVERWRITE;
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
		# Copy "real" files
		# ---------------------------------------------
		for f in "${COMMON_REALFILES[@]}"
		do
			installRealFile "${f}"
		done


		# ---------------------------------------------
		# Move backups from TMP to $HOME
		# ---------------------------------------------
		printf "\nMove backups to %s/%s ... " "${BACKUP_DIR}" $(basename ${BACKUP_TMPDIR})

		mkdir -p "${BACKUP_DIR}" && \
		mv "${BACKUP_TMPDIR}" "${BACKUP_DIR}/" && \
		echo "Done."


		# ---------------------------------------------
		# Nano Syntax Highlighting
		# ---------------------------------------------

 		mkdir -p "${NANO_DIR}"
 		if [[ -f ${DOTFILES_DIR}/.nano/*nanorc ]]; then
 			cp ${DOTFILES_DIR}/.nano/*nanorc "${NANO_DIR}/"
 		fi

		### Install Anthony Scopatz's "Improved Nano Syntax Highlighting Files"
		### https://github.com/scopatz/nanorc
		curl "https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh" | sh 2>&1 > /dev/null



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

