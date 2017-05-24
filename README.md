# dotfiles

This repository contains my system configuration

## Installation

```bash
$ git clone https://github.com/REBELinBLUE/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./setup.sh
```

### Add custom commands

If `~/.config/extras.bash` or `~/.config/extras.fish` exists, it will be sourced along with the other files. You can use this to add a few custom commands, or to add commands you don’t want to commit to a public repository.

For example

```bash
# Git credentials
git config --global user.name "Stephen Ball"
git config --global user.email "stephen@rebelinblue.com"
```

## Addtional Apps

The following apps need to be installed manually

* Firefox - Needs to be installed manually so 1password will run
* Google Chrome - Needs to be installed manually so 1password will run
* MetaX
* Moneywiz 2
* Tuneskit
* TPLink PLC Device Scan

Mac appstore apps can be installed with `scripts/mac-appstore.sh`

## Final steps

Run the following commands to authenticate with various services

```bash
$ composer config --global github-oauth.github.com OAUTH_TOKEN
$ gist --login
$ ngrok authtoken OAUTH_TOKEN
$ asciinema auth
$ hub browse
```
