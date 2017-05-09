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


function exit_err {
	echo >&2 "${@}"; exit 1;
}



# ---------------------------------------------------------
# The main program
# ---------------------------------------------------------
function main() {




	# Absolute path to this script.
	DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


	# Where to find the OS-related scripts
	DOTFILES_DIR_UBUNTU="${DOTFILES_DIR}/ubuntu"
	DOTFILES_DIR_MACOS="${DOTFILES_DIR}/macos"

	BACKUP_TMPDIR=$(mktemp -d "${TMPDIR:-/tmp/}$(basename 0).XXXXXXXXXXXX")  || { exit_err "Failed to create temp directory."; }
	BACKUP_DIR="${DOTFILES_DIR}/dotfiles-backups"




	function installSymlink() {
		LINK_BASENAME=$(basename ${1})
		LINKNAME="${HOME}/${LINK_BASENAME}"

		printf "\n%s " "${LINKNAME}"

		# Move existing original to backup directory
		if [ -f "${LINKNAME}" -o  -L "${LINKNAME}" ]; then
			printf " ... move to backup: "
			mv "${LINKNAME}" "${BACKUP_TMPDIR}/" && echo "Done."
		fi

		# Create new symlink
		ln -sv "${1}" "${HOME}"
	}


	# =============================================
	# Installation routine
	# =============================================

	# Go to Home directory; we'll change back when script finished.
	cd "${HOME}"

	printf "This moves existing files or symlinks to a backup directory. Proceed? (y/n) ";
	read DOTFILES_OVERWRITE;
	echo ""


	if [[ $DOTFILES_OVERWRITE =~ ^[Yy]$ ]]; then


		# ---------------------------------------------
		# Create symlinks
		# ---------------------------------------------
		installSymlink "${DOTFILES_DIR}/.ackrc"
		installSymlink "${DOTFILES_DIR}/.bash_aliases"
		installSymlink "${DOTFILES_DIR}/.bash_prompt"
		installSymlink "${DOTFILES_DIR}/.editorconfig"
		installSymlink "${DOTFILES_DIR}/.gitconfig"
		installSymlink "${DOTFILES_DIR}/.gitignore_global"
		installSymlink "${DOTFILES_DIR}/.paths"
		installSymlink "${DOTFILES_DIR}/.screenrc"
		installSymlink "${DOTFILES_DIR}/.zshrc"


		# ---------------------------------------------
		# Install files according to OS type
		# ---------------------------------------------
		if [[ "$OSTYPE" == "linux-gnu" ]]; then

			installSymlink "${DOTFILES_DIR_UBUNTU}/.bashrc"
			installSymlink "${DOTFILES_DIR_UBUNTU}/.profile"
			installSymlink "${DOTFILES_DIR_UBUNTU}/.selected_editor"
			#[[ -f "$HOME/.bashrc" ]] && source "$HOME/.bashrc"

		elif [[ "$OSTYPE" == "darwin"* ]]; then

			installSymlink "${DOTFILES_DIR_MACOS}/.bash_profile"
			installSymlink "${DOTFILES_DIR_MACOS}/.bashrc"
			installSymlink "${DOTFILES_DIR_MACOS}/.profile"
			#[[ -f "$HOME/.bash_profile" ]] && source "$HOME/.bash_profile"

		fi;


		# ---------------------------------------------
		# Move backups from TMP to $HOME
		# ---------------------------------------------
		printf "\nMove backups to %s/%s ... " ${BACKUP_DIR} $(basename ${BACKUP_TMPDIR})
		mkdir -p "${BACKUP_DIR}"
		mv "${BACKUP_TMPDIR}" "${BACKUP_DIR}/" && echo "Done."

	else
		echo "Aborted."
	fi;

	cd $OLDPWD
	exit 0
}


main ${@}

