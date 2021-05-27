# Make sublime the default editor locally and nano when via SSH
if begin; test -z $SSH_CLIENT; and test -z $SSH_TTY; end
    set -xg EDITOR "subl -w"
else
    set -xg EDITOR "nano -w"
end

if begin; test -d /opt/homebrew; end
    set -xg HOMEBREW_INSTALL_HOME "/opt/homebrew"
else
    set -xg HOMEBREW_INSTALL_HOME "/usr/local"
end

# XDG directories
set -xg XDG_CONFIG_HOME $HOME/.config
set -xg XDG_CACHE_HOME $HOME/.cache
set -xg XDG_DATA_HOME $HOME/.local/share
set -xg XDG_RUNTIME_DIR $XDG_CACHE_HOME

set -xg WORKSPACE $HOME/Workspace

# Homebrew options
set -xg HOMEBREW_CASK_OPTS "--appdir=/Applications" # --caskroom=/opt/homebrew-cask/Caskroom"

# Setup terminal, and turn on colors
set -x TERM "xterm-256color"

# Prefer UK English and use UTF-8.
set -xg LANG "en_GB.UTF-8"
set -xg LC_CTYPE "en_GB.UTF-8"
set -xg LC_ALL "en_GB.UTF-8"
set -xg LC_MESSAGES "en_GB.UTF-8"
set -xg LC_COLLATE C

# Default log level for NPM
set -xg NPM_CONFIG_LOGLEVEL "error"

# Colour man pages
set -xg man_blink -o yellow
set -xg man_bold -o red
set -xg man_standout -b blue
set -xg man_underline -u green

# Set the session ssh-agent socket path (If it's not set)
#set -xg SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent
set -xg GPG_TTY (tty)
#set -xg SSH_AUTH_SOCK $HOME/.gnupg/S.gpg-agent.ssh

# Look for terminfo files under data
set -xg TERMINFO $XDG_RUNTIME_DIR/terminfo

# Set the composer home dir
set -xg COMPOSER_HOME $XDG_CONFIG_HOME/composer
set -xg COMPOSER_CACHE_DIR $XDG_CACHE_HOME/composer

##set RUBY_VERSION (ruby -e 'puts RbConfig::CONFIG["ruby_version"]')

# Other config files
#set -xg VAGRANT_HOME $XDG_DATA_HOME/vagrant
#set -xg VBOX_USER_HOME $XDG_CONFIG_HOME/virtualbox
set -xg GETIPLAYER_PROFILE $XDG_CONFIG_HOME/get_iplayer
set -xg INPUTRC $XDG_CONFIG_HOME/readline/inputrc
set -xg ACKRC $XDG_CONFIG_HOME/ack/ackrc
set -xg MYSQL_HISTFILE $XDG_CACHE_HOME/mysql_history
set -xg LESSHISTFILE $XDG_CACHE_HOME/less_history
set -xg SDIRS $XDG_CONFIG_HOME/marks
set -xg PGCLIRC $XDG_CONFIG_HOME/pgcli/config
set -xg MYCLIRC $XDG_CONFIG_HOME/mycli/config
set -xg HTTPIE_CONFIG_DIR $XDG_CONFIG_HOME/httpie
set -xg NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -xg SCREENRC $XDG_CONFIG_HOME/screen/screenrc
set -xg HGRCPATH $XDG_CONFIG_HOME/hg/hgrc
set -xg TIGRC_USER $XDG_CONFIG_HOME/tig/tigrc
set -xg BABEL_CACHE_PATH $XDG_CACHE_HOME/babel.json
set -xg GEMRC $XDG_CONFIG_HOME/gemrc/config
#set -xg GEM_HOME $HOME/.local/lib/ruby/gems/$RUBY_VERSION # FIXME: Why is this not working?
set -xg GEM_SPEC_CACHE $XDG_CACHE_HOME/gem/specs
set -xg DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -xg GRIPHOME $XDG_CONFIG_HOME/grip
set -xg VIMINIT 'let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
set -xg NVM_DIR $XDG_CONFIG_HOME/nvm

set -xg nvm_prefix $HOMEBREW_INSTALL_HOME/opt/nvm
set -xg FLUX_FORWARD_NAMESPACE flux

#set -e RUBY_VERSION

set -xg GOPATH $HOME/.go

set -g fish_user_paths "$HOMEBREW_INSTALL_HOME/opt/openssl@1.1/bin" $fish_user_paths
set -gx LDFLAGS "-L$HOMEBREW_INSTALL_HOME/opt/openssl@1.1/lib"
set -gx CPPFLAGS "-I$HOMEBREW_INSTALL_HOME/opt/openssl@1.1/include"
set -gx PKG_CONFIG_PATH "$HOMEBREW_INSTALL_HOME/opt/openssl@1.1/lib/pkgconfig"

set -xg PATH /usr/local/MacGPG2/bin/ \
            /usr/local/sbin \
            /usr/local/bin \
            /usr/sbin \
            /usr/bin \
            /sbin \
            /bin \
            $HOME/.local/bin \
            $GEM_HOME/bin \
            $HOME/.krew/bin \
            $GOPATH/bin \
            $COMPOSER_HOME/vendor/bin

set -xgp PATH $HOMEBREW_INSTALL_HOME/opt/vim/bin \
        $HOMEBREW_INSTALL_HOME/opt/nano/bin \
        $HOMEBREW_INSTALL_HOME/opt/sqlite/bin \
        $HOMEBREW_INSTALL_HOME/bin \
        $HOMEBREW_INSTALL_HOME/sbin \
        $HOMEBREW_INSTALL_HOME/opt/gnu-sed/libexec/gnubin \
        $HOMEBREW_INSTALL_HOME/opt/findutils/libexec/gnubin \
        $HOMEBREW_INSTALL_HOME/opt/coreutils/libexec/gnubin \
        $HOMEBREW_INSTALL_HOME/opt/gnu-indent/libexec/gnubin \
        $HOMEBREW_INSTALL_HOME/opt/gnu-tar/libexec/gnubin \
        $HOMEBREW_INSTALL_HOME/opt/gnu-which/libexec/gnubin \
        $HOMEBREW_INSTALL_HOME/opt/make/libexec/gnubin \
        $HOMEBREW_INSTALL_HOME/opt/gnu-getopt/bin \
        $HOMEBREW_INSTALL_HOME/opt/grep/libexec/gnubin \
        $HOMEBREW_INSTALL_HOME/opt/mysql-client/bin

set -xg MANPATH $HOMEBREW_INSTALL_HOME/opt/findutils/libexec/gnuman \
                $HOMEBREW_INSTALL_HOME/opt/coreutils/share/man \
                $HOMEBREW_INSTALL_HOME/opt/gnu-tar/libexec/gnuman \
                $HOMEBREW_INSTALL_HOME/opt/gnu-which/libexec/gnuman \
                $HOMEBREW_INSTALL_HOME/opt/gnu-which/libexec/gnuman \
                $HOMEBREW_INSTALL_HOME/opt/gnu-sed/libexec/gnuman \
                $HOMEBREW_INSTALL_HOME/opt/make/libexec/gnuman \
                $HOMEBREW_INSTALL_HOME/opt/mysql-client/share/man \
                $HOMEBREW_INSTALL_HOME/opt/postgresql/share/man \
                /usr/local/MacGPG2/share/man \
                /usr/local/share/man \
                /usr/share/man

# # Set LS_COLORS
eval (dircolors -c $HOME/.dotfiles/files/shell/bash/dircolors | sed 's/>&\/dev\/null$//')

# Fix behat colours
set -xg BEHAT_PARAMS '{"formatters": {"pretty": {"output_styles": {"comment": ["blue"]}}}}'

#    set -l FORMATTING '{
#    "output_styles": {
#        "keyboard": [null, null, ["bold"]],
#        "stdout": [null, null, []],
#        "exception": ["red"],
#        "undefined": ["yellow"],
#        "pending": ["yellow"],
#        "pending_param": ["yellow", null, ["bold"]],
#        "failed": ["red"],
#        "failed_param": ["red", null, ["bold"]],
#        "passed": ["green"],
#        "passed_param": ["green", null, ["bold"]],
#        "skipped": ["cyan"],
#        "skipped_param": ["cyan", null, ["bold"]],
#        "comment":["blue"],
#        "tag": ["cyan"]
#    }
#}'
