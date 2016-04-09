# dotfiles

This repository contains my system configuration

## Installation

```bash
$ git clone git@github.com:REBELinBLUE/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./setup.sh
```

Google Chrome must be installed by hand, remaining apps can be installed with `scripts/mac-apps.sh`

### Add custom commands

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

```bash
# Git credentials
export GIT_AUTHOR_NAME="Stephen Ball"
export GIT_AUTHOR_EMAIL="stephen@rebelinblue.com"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
```
