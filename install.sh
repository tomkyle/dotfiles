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
	"${DOTFILES_DIR}/.paths"
	"${DOTFILES_DIR}/.screenrc"
	"${DOTFILES_DIR}/.zshrc"
)

declare -a UBUNTU_DOTFILES=(
	"${DOTFILES_DIR_UBUNTU}/.bashrc"
	"${DOTFILES_DIR_UBUNTU}/.profile"
	"${DOTFILES_DIR_UBUNTU}/.selected_editor"
)

declare -a MACOS_DOTFILES=(
	"${DOTFILES_DIR_MACOS}/.bash_profile"
	"${DOTFILES_DIR_MACOS}/.bashrc"
	"${DOTFILES_DIR_MACOS}/.profile"
)

declare -a INSTALL_FILES=()





# --------------------------------------
# Functions
# --------------------------------------

function exit_err {
	echo >&2 "${@}"; exit 1;
}


function installSymlink() {
	LINK_BASENAME=$(basename ${1})
	LINKNAME="${HOME}/${LINK_BASENAME}"

	printf "\n%s " "${LINKNAME}"

	# Handle symlink, copying its target contents
	if [ -L "${LINKNAME}" ]; then
		printf " ... backup symlinked file ... "
		local link_target="$(readlink "${LINKNAME}")"
		cp "${link_target}" "${BACKUP_TMPDIR}/" && echo "Done."

	# Moving regular files
	elif [ -f "${LINKNAME}" ]; then
		printf " ... move regular file to backup: "
		mv "${LINKNAME}" "${BACKUP_TMPDIR}/" && echo "Done."
	fi

	# Create new symlink
	ln -sv "${1}" "${HOME}"
}


# ---------------------------------------------------------
# The main program
# ---------------------------------------------------------

function main() {

	# =============================================
	# Add OS-specific files
	# =============================================

	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		INSTALL_FILES=( "${COMMON_DOTFILES[@]}" "${UBUNTU_DOTFILES[@]}" )

	elif [[ "$OSTYPE" == "darwin"* ]]; then
		INSTALL_FILES=( "${COMMON_DOTFILES[@]}" "${MACOS_DOTFILES[@]}" )

	fi;


	# =============================================
	# Installation routine
	# =============================================

	# Go to Home directory; we'll change back when script finished.
	cd "${HOME}"

	printf "This moves existing files or symlinks to a backup directory. Proceed? (y/n) ";
	read DOTFILES_OVERWRITE;
	echo ""

	if [[ $DOTFILES_OVERWRITE =~ ^[Yy]$ ]]; then

		# Create symlinks
		for f in "${INSTALL_FILES[@]}"
		do
			installSymlink "${f}"
		done


		# Move backups from TMP to $HOME
		printf "\nMove backups to %s/%s ... " ${BACKUP_DIR} $(basename ${BACKUP_TMPDIR})

		mkdir -p "${BACKUP_DIR}" && \
		mv "${BACKUP_TMPDIR}" "${BACKUP_DIR}/" && \
		echo "Done."

		echo "It is recommended to log in again to apply dotfiles."


	else
		echo "Aborted."
	fi;

	cd $OLDPWD
	exit 0
}


main "${@}"

