# Make sublime the default editor locally and nano when via SSH
if begin; test -z $SSH_CLIENT; and test -z $SSH_TTY; end
    set -xg EDITOR 'subl -w'
else
    set -xg EDITOR 'nano -w'
end

set -xg HOMEBREW_CASK_OPTS '--appdir=/Applications --caskroom=/opt/homebrew-cask/Caskroom'

# Add more paths
set -xg PATH ~/.composer/vendor/bin (brew --prefix findutils)/bin \
            (brew --prefix coreutils)/libexec/gnubin /usr/local/bin /usr/bin /bin /usr/local/sbin \
            /usr/sbin /sbin /Applications/VirtualBox.app/Contents/MacOS

# Setup terminal, and turn on colors
set -x TERM xterm-256color


# Set LS_COLORS
eval (dircolors -c $HOME/.dotfiles/files/shell/bash/dircolors | sed 's/>&\/dev\/null$//')

# Prefer UK English and use UTF-8.
set -xg LANG 'en_GB.UTF-8'
set -xg LC_CTYPE 'en_GB.UTF-8'
set -xg LC_ALL 'en_GB.UTF-8'
set -xg LC_MESSAGES 'en_GB.UTF-8'
set -xg LC_COLLATE C

# Enable colours for cheat command
set -xg CHEATCOLORS true

# Default log level for NPM
set -xg NPM_CONFIG_LOGLEVEL 'error'

# Load additional scripts
source /opt/fishmarks/marks.fish

# Load any additional scripts
if test -e ~/.extras.fish
    source ~/.extras.fish
end

source $OMF_CONFIG/helpers.fish

# TODO
#
# Missing history config
# Missing man path
# Missing additional paths
# Add PHPUnit function
# Fix SSHRC
# Add remaining helper functions
