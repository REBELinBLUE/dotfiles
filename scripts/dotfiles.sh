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

# Remove tvnamer config if not installed
if ! type_exists 'tvnamer'; then
    rm -f $HOME/.tvnamer.json
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

# Oh-my-fish
if [ ! -e $HOME/.config/starship.toml ]; then
    ln -s $HOME/.dotfiles/files/config/starship.toml $HOME/.config/starship.toml
fi

# Symlink the sshrc.d config
if [ ! -e $HOME/.config/sshrc/ ]; then
    ln -s $HOME/.dotfiles/files/config/sshrc $HOME/.config/sshrc
fi

# Symlink the neofetch config
if [ ! -e $HOME/.config/neofetch/ ]; then
    ln -s $HOME/.dotfiles/files/config/neofetch $HOME/.config/neofetch
fi

# Symlink Vagrantfile
# if [ ! -d $HOME/.local/share/vagrant/ ]; then
#     mkdir -p $HOME/.local/share/vagrant/
# fi

#if [ ! -e $HOME/.local/share/vagrant/Vagrantfile ]; then
#    ln -s $HOME/.dotfiles/files/config/Vagrantfile $HOME/.local/share/vagrant/Vagrantfile
#fi

# Symlink inputrc
if [ ! -d $HOME/.config/readline/ ]; then
    mkdir -p $HOME/.config/readline/
fi

if [ ! -e $HOME/.config/readline/inputrc ]; then
    ln -s $HOME/.dotfiles/files/config/inputrc $HOME/.config/readline/inputrc
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

# Set up extras config
if [ ! -f $HOME/.config/extras.bash ]; then
    echo -e "#!/usr/bin/env bash\n\n# Stick any extra functions, aliases and exports for bash in this file" > $HOME/.config/extras.bash
    $EDITOR $HOME/.config/extras.bash
fi

if [ ! -f $HOME/.config/extras.fish ]; then
    echo -e "#!/usr/bin/env fish\n\n# Stick any extra functions and exports for fish in this file" > $HOME/.config/extras.fish
    $EDITOR $HOME/.config/extras.fish
fi

source $HOME/.bashrc
