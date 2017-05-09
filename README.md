# tomkyle/dotfiles

**Please note:** This repo is under heavy development for now, including BC breaks being possible. So if you like to use it for yor own, you may do so (cautious) and feel warned ;-)

##Dotfiles for your home directory

File | Purpose
:----| :-------
`.ackrc` | Obligatory parameters for [ack](http://beyondgrep.com/)
`.bash_aliases` | Common shell shortcuts 
`.bash_prompt` | Git-ready prompt in solarized dark theme style
`.editorconfig` | Rules for certain filetypes, see [editorconfig.org](http://editorconfig.org/)
`.gitconfig` | Global Git [configuration](http://git-scm.com/docs/git-config)
`.paths` | Extensions for the `$PATH` variable
`.screenrc` | Screen session info in shell's bottom line
`.zshrc` | from [Oh My ZSH!](http://ohmyz.sh/), using the [risto theme](https://github.com/robbyrussell/oh-my-zsh/wiki/Themes#risto). 

##Dotfiles for Ubuntu

The installer will put these files from the **ubuntu/** directory into your home folder:

- `.bashrc`
- `.profile`
- `.selected_editor`

##Dotfiles for Mac OSX

The installer will put these files from the **osx** directory into your home folder:

- `.bashrc`
- `.bash_profile`



##Installation

You can clone the repository wherever you want. The `install.sh` script will symlink all dotfiles into your `$HOME` directory.

```bash
$ git clone https://github.com/tomkyle/dotfiles.git dotfiles
$ dotfiles/install.sh
```

This installation notes are heavily inspired by [Mathias Bynens' dotfiles repo.](https://github.com/mathiasbynens/dotfiles)



##Integrate with your system

###.bash_aliases
This file contains some common shortcuts. You will want to have your own aliases; simply put them in a `~/.bash_aliases.local`, they will be included automatically by both `.bashrc` and `.zshrc`.

###.gitconfig
Many people use `.gitconfig` for storing their username or email or credentials cache lifetime – nothing a config file to bother with. Instead, store them in a `.gitconfig.local`, it will be included automatically.

### .gitignore_global
List of rules for ignoring files in every Git repository on your computer.
See the article [https://help.github.com/articles/ignoring-files/](https://help.github.com/articles/ignoring-files/) on GitHub Help.

###.paths
This essentially adds `~/bin` and `~/.composer/vendor/bin` to the `$PATH` variable, if they exist. Both `.bashrc` and `.zshrc` will include this file ; if you like to add more paths locally, store them in a file `~/.paths.local` which will then be included as well.

###.zshrc
This essentially is the default `.zshrc` from [Oh My ZSH!](http://ohmyz.sh/). It additionally includes the `.paths` and `.bash_aliases` to make them available both in bash and zsh.




##Updating

To update, update your local `dotfiles` repository and call installer:

```bash
$ git pull
$ ./install.sh
```
