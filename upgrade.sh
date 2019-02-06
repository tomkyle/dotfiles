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

declare DOTFILES_DIR
declare OLD_PWD

# Absolute path to this script.
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Where we are right now
OLD_PWD="${PWD}"


# --------------------------------------
# Business
# --------------------------------------

cd "${DOTFILES_DIR}" && git pull && ./install.sh && cd "${OLD_PWD}"

# Outro
unset DOTFILES_DIR OLD_PWD;



