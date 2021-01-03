# tomkyle/dotfiles

[![Build Status](https://travis-ci.org/tomkyle/dotfiles.svg?branch=master)](https://travis-ci.org/tomkyle/dotfiles)

**Please note:** This repo is under heavy development for now, including BC breaks being possible. So if you like to use it for yor own, you may do so (cautious) and feel warned ;-)

## Dotfiles for your home directory

File | Purpose
:----| :-------
.ackrc | Obligatory parameters for [ack](http://beyondgrep.com/)
.aliases | Common shell shortcuts 
.bash_prompt | Git-ready prompt in solarized dark theme style
.editorconfig | Rules for certain filetypes, see [editorconfig.org](http://editorconfig.org/)
.gitconfig | Global Git [configuration](http://git-scm.com/docs/git-config)
.nanorc | Nano editor config file 
.nano/ | Syntax highlighting definitions 
.paths | Extensions for the `$PATH` variable
.screenrc | Screen session info in shell's bottom line
.zshrc | from [Oh My ZSH!](http://ohmyz.sh/), using the [risto theme](https://github.com/robbyrussell/oh-my-zsh/wiki/Themes#risto). 

## OS-specific dotfiles

### Ubuntu

The installer will put these files from the **ubuntu/** directory into your home folder:

- **.bashrc**
- **.profile**
- **.selected_editor**
- **Brewfile**

### MacOS

The installer will put these files from the **osx**/ directory into your home folder:

- **.bashrc**
- **.bash_profile**
- **.profile**
- **Brewfile** with latest *nano* 3.2



## Installation

You can clone the repository wherever you want. The `install.sh` script will symlink all dotfiles into your `$HOME` directory.

```bash
$ git clone https://github.com/tomkyle/dotfiles.git dotfiles
$ dotfiles/install.sh

# On MacOS, run after installation:
$ brew bundle install
```

This installation notes are heavily inspired by [Mathias Bynens' dotfiles repo.](https://github.com/mathiasbynens/dotfiles)



## Upgrading

Call the **upgrade.sh** script to update the local `dotfiles` repository and call the installer again:

```bash
$ ~/dotfiles/upgrade.sh
```



## Integrate with your system

### .aliases
This file contains some common shortcuts. You will want to have your own aliases; simply put them in a `~/.aliases.local`, they will be included automatically by both `.bashrc` and `.zshrc`. – [View source](./.aliases) 

### .gitconfig
Many people use `.gitconfig` for storing their username or email or credentials cache lifetime – nothing a config file to bother with. Instead, store them in a `.gitconfig.local`, it will be included automatically.  – [View source](./.gitconfig) 

### .gitignore_global
List of rules for ignoring files in every Git repository on your computer.
See the article [https://help.github.com/articles/ignoring-files/](https://help.github.com/articles/ignoring-files/) on GitHub Help.

### .lessrc

Some configuration for the *less* command, after Top Bug Net's article [“Make the less Command More Powerful”](https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/). – [View source](./.lessrc) 

### .nanorc

Nano editor configuration, with syntax hightlighting.
**N.B.** this file will not be installed as regular file rather than symlink.
[View source](./.nanorc) 

### .paths

This essentially adds typical bin directories like  `~/bin` and `/usr/local/bin` to the `$PATH` variable, if they exist. Both `.bashrc` and `.zshrc` will include this file. [View source](./.paths)

if you like to add more paths locally, store them in a file `~/.paths.local` which will then be included as well. **Example:**

```bash
# ~/.paths.local

# Prepend these to the $PATH, if they exist.
declare -a PREPEND_PATHS=(
	"$HOME/foo"
)

# Apppend these to the $PATH, if they exist.
declare -a APPEND_PATHS=(
	"$HOME/bar"
)

# Prepend Directories
for some_dir in "${PREPEND_PATHS[@]}"
do
	if [ -d "${some_dir}" ] && [[ ${PATH} != *"${some_dir}"* ]]; then
	    export PATH="${some_dir}:${PATH}"
	fi
done

# Append Directories
for some_dir in "${APPEND_PATHS[@]}"
do
	if [ -d "${some_dir}" ] && [[ ${PATH} != *"${some_dir}"* ]]; then
	    export PATH="${PATH}:${some_dir}"
	fi
done

# Outro
unset PREPEND_PATHS APPEND_PATHS some_dir;
```



### .zshrc
This essentially is the default `.zshrc` from [Oh My ZSH!](http://ohmyz.sh/). It additionally includes the `.paths` and `.aliases` to make them available both in bash and zsh. – [View source](./.zshrc) 



## Development

It is recommended to use **git-flow-avh**

```bash
# bash 
git clone https://github.com/tomkyle/dotfiles.git
cd dotfiles
git flow init -d

# should be now on branch 'develop'
```

