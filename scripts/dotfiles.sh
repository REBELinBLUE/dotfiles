#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

# Symlink sublime settings files
for path in ${HOME}/.dotfiles/files/sublimetext/*.sublime-settings; do
    if [ -f "${path}" ]; then
        name=$(basename "${path}")

        if [ -f "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/${name}" ]; then
            rm "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/${name}"
        fi

        ln -s "${path}" "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/${name}"
    fi
done

skip=".gitconfig .bash_prompt .exports .completions .aliases .functions .colours"

# Symlink any files except those listed above
for path in $HOME/.dotfiles/files/.*; do
    if [ -f $path ]; then
        name=$(basename $path)

        # If file is in list to skip continue
        if [[ $skip =~ $name ]]; then
            continue
        fi

        if [ -f $HOME/$name ]; then
            rm $HOME/$name
        fi

        ln -s $path $HOME/$name
    fi
done

#  Setup initial git config
if [ ! -f $HOME/.gitconfig ]; then
    echo -e "[include]\n    path = $HOME/.dotfiles/files/.gitconfig" > $HOME/.gitconfig
fi

# Remove tvnamer config if not installed
if ! type_exists 'tvnamer'; then
    rm -f $HOME/.tvnamer.json
fi

# Symlink the ssh config files
if [ ! -e $HOME/.ssh/config.d ]; then
    ln -s $HOME/.dotfiles/files/.ssh/config.d/ $HOME/.ssh/config.d
fi

# Symlink Vagrantfile
if [ -d $HOME/.vagrant.d/ ]; then
    if [ -f $HOME/.vagrant.d/Vagrantfile ]; then
        rm -f $HOME/.vagrant.d/Vagrantfile
    fi

    ln -s $HOME/.dotfiles/files/.vagrant.d/Vagrantfile $HOME/.vagrant.d/Vagrantfile
fi

# Set up extras config
if [ ! -f $HOME/.extras ]; then
    echo -e "# Stick any extra functions, aliases and exports in this file" > $HOME/.extras
    $EDITOR $HOME/.extras
fi

source $HOME/.bashrc
