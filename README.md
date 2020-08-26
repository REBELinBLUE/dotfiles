# dotfiles

This repository contains my system configuration

## Installation

```bash
$ git clone https://github.com/REBELinBLUE/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./setup.sh
```

### Add custom commands

If `~/.config/extras.fish` exists, it will be sourced along with the other files. You can use this to add a few custom commands, or to add commands you don’t want to commit to a public repository.

For example

```bash
# Git credentials
git config --global user.name "Stephen Ball"
git config --global user.email "stephen@rebelinblue.com"
```

## Final steps

Run the following commands to authenticate with various services

```bash
$ composer config --global github-oauth.github.com OAUTH_TOKEN
$ gist --login
$ ngrok authtoken OAUTH_TOKEN
$ asciinema auth
$ hub browse
```
