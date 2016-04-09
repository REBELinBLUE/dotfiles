#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

for file in .dotfiles/files/.{bashrc,bash_profile,editorconfig,inputrc,gitconfig,gitignore_global,nanorc,tvnamer.json}; do
    if [ -f "~/$file" ]; then
        rm "~/$file"
    fi

    ln -s ~/.dotfiles/files/$file ~/$file
done

source ~/.bashrc
