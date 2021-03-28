#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

# Symlink sublime settings files
if is_os "darwin"; then
    for path in ${HOME}/.dotfiles/files/sublimetext/*.sublime-settings; do
        if [ -f "${path}" ]; then
            name=$(basename "${path}")

            if [ -f "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/${name}" ]; then
                rm "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/${name}"
            fi

            ln -s "${path}" "${HOME}/Library/Application Support/Sublime Text 3/Packages/User/${name}"
        fi
    done
fi

#Symlink any files except those listed above
for path in $HOME/.dotfiles/files/.*; do
    if [ -f $path ]; then
        name=$(basename $path)

        if [ -f $HOME/$name ]; then
            rm $HOME/$name
        fi

        ln -s $path $HOME/$name
    fi
done

#  Setup initial git config
if [ ! -d $HOME/.config/git ]; then
    mkdir -p $HOME/.config/git
fi

if [ ! -f $HOME/.config/git/config ]; then
    echo -e "[include]\n    path = $HOME/.dotfiles/files/config/git/config" > $HOME/.config/git/config
fi

# Symlink the ssh config files
if [ ! -e $HOME/.ssh/config.d ]; then
    ln -s $HOME/.dotfiles/files/.ssh/config.d/ $HOME/.ssh/config.d
fi

# Make ~/.config directory if missing
if [ ! -d $HOME/.config ]; then
    mkdir $HOME/.config
fi

# Make ~/.local directory if missing
if [ ! -d $HOME/.local ]; then
    mkdir -p $HOME/.local/share/
fi

# Starship
if [ ! -e $HOME/.config/starship.toml ]; then
    ln -s $HOME/.dotfiles/files/config/starship.toml $HOME/.config/starship.toml
fi

# Topgrade
if [ ! -e $HOME/.config/topgrade.toml ]; then
    ln -s $HOME/.dotfiles/files/config/topgrade.toml $HOME/.config/topgrade.toml
fi

# Symlink inputrc
if [ ! -d $HOME/.config/readline/ ]; then
    mkdir -p $HOME/.config/readline/
fi

if [ ! -e $HOME/.config/readline/inputrc ]; then
    ln -s $HOME/.dotfiles/files/config/inputrc $HOME/.config/readline/inputrc
fi

if [ ! -d $HOME/.config/tvnamer/ ]; then
    mkdir -p $HOME/.config/tvnamer/
fi


if [ ! -e $HOME/.config/tvnamer/tvnamer.json ]; then
    ln -s $HOME/.dotfiles/files/config/tvnamer/tvnamer.json $HOME/.config/tvnamer/tvnamer.json
fi



# Symlink vimrc
if [ ! -d $HOME/.config/vim/ ]; then
    mkdir -p $HOME/.config/vim/
fi

if [ ! -e $HOME/.config/vim/vimrc ]; then
    ln -s $HOME/.dotfiles/files/config/vimrc $HOME/.config/vim/vimrc
fi

if [ ! -d $HOME/.cache/vim ]; then
    mkdir -p $HOME/.cache/vim
fi

# Symlink npmrc
if [ ! -d $HOME/.config/npm/ ]; then
    mkdir -p $HOME/.config/npm/
fi

if [ ! -e $HOME/.config/npm/npmrc ]; then
    ln -s $HOME/.dotfiles/files/config/npmrc $HOME/.config/npm/npmrc
fi

# Symlink gnupg
if [ ! -f $HOME/.gnupg/gpg-agent.conf ]; then
    ln -s $HOME/.dotfiles/files/config/gpg-agent.conf $HOME/.gnupg/gpg-agent.conf
fi

if [ ! -f $HOME/.gnupg/gpg.conf ]; then
    ln -s $HOME/.dotfiles/files/config/gpg.conf $HOME/.gnupg/gpg.conf
fi

/usr/local/MacGPG2/bin/gpgconf --kill all

if [ ! -f $HOME/.config/extras.fish ]; then
    echo -e "#!/usr/bin/env fish\n\n# Stick any extra functions and exports for fish in this file" > $HOME/.config/extras.fish
    $EDITOR $HOME/.config/extras.fish
fi

if [ ! -e $HOME/.wakeup ]; then
    ln -s $HOME/.dotfiles/files/.wakeup $HOME/.wakeup
fi

if [ ! -e $HOME/.sleep ]; then
    ln -s $HOME/.dotfiles/files/.sleep $HOME/.sleep
fi
