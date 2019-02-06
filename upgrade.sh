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

OLD_PWD="${PWD}"

cd "${DOTFILES_DIR}" && git pull && ./install.sh

cd "${OLD_PWD}"




