# dotfiles

This repository contains my system configuration

## Installation

```bash
$ git clone https://github.com/REBELinBLUE/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./setup.sh
```

### Add custom commands

If `~/.extras` exists, it will be sourced along with the other files. You can use this to add a few custom commands, or to add commands you don’t want to commit to a public repository.

For example

```bash
# Git credentials
export GIT_AUTHOR_NAME="Stephen Ball"
export GIT_AUTHOR_EMAIL="stephen@rebelinblue.com"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

## Addtional Apps

The following apps need to be installed manually

* Firefox - Needs to be installed manually so 1password will run
* Google Chrome - Needs to be installed manually so 1password will run
* MetaX
* Moneywiz 2
* Tuneskit
* Things - Out of date version in cask
* WD Access & TPLink PLC Device Scan

Mac appstore apps can be installed with `scripts/mac-appstore.sh`

## Final steps

Run the following commands to authenticate with various services

```bash
$ composer config --global github-oauth.github.com OAUTH_TOKEN
$ gist --login
$ ngrok authtoken OAUTH_TOKEN
$ asciinema auth
```
