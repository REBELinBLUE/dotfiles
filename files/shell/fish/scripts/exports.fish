# Make sublime the default editor locally and nano when via SSH
if begin; test -z $SSH_CLIENT; and test -z $SSH_TTY; end
    set -xg EDITOR "code -w"
    set -xg KUBE_EDITOR "subl -w"
else
    set -xg EDITOR "nano -w"
end

# Homebrew options from brew shellenv
set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
#set -xg HOMEBREW_CASK_OPTS "--appdir=/Applications" # --caskroom=/opt/homebrew-cask/Caskroom"

# XDG directories
set -xg XDG_CONFIG_HOME $HOME/.config
set -xg XDG_CACHE_HOME $HOME/.cache
set -xg XDG_DATA_HOME $HOME/.local/share
set -xg XDG_RUNTIME_DIR $XDG_CACHE_HOME

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

# Set the session ssh-agent socket path
#set -xg GPG_TTY (tty)
set -xg SSH_AUTH_SOCK $XDG_RUNTIME_DIR/1password/agent.sock

# Look for terminfo files under data
set -xg TERMINFO $XDG_RUNTIME_DIR/terminfo

# Set the composer home dir
set -xg COMPOSER_HOME $XDG_CONFIG_HOME/composer
set -xg COMPOSER_CACHE_DIR $XDG_CACHE_HOME/composer

# Other config files
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
#set -xg DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -xg GRIPHOME $XDG_CONFIG_HOME/grip
set -xg VIMINIT 'let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
set -xg NVM_DIR $XDG_CONFIG_HOME/nvm
set -xg OP_TOKENS_FILE $HOME/.dotfiles/files/.tokens.env

set -xg nvm_prefix $HOMEBREW_PREFIX/opt/nvm

set -gx QUOTING_STYLE literal

set -xg GOPATH $HOME/.go

set -gx LDFLAGS "-L$HOMEBREW_PREFIX/opt/openssl@1.1/lib"
set -gx CPPFLAGS "-I$HOMEBREW_PREFIX/opt/openssl@1.1/include"
set -gx PKG_CONFIG_PATH "$HOMEBREW_PREFIX/opt/openssl@1.1/lib/pkgconfig"

set -xg PATH /usr/local/MacGPG2/bin \
            /Applications/PhpStorm.app/Contents/MacOS \
            /Applications/DataGrip.app/Contents/MacOS \
            /Applications/IntelliJ\ IDEA.app/Contents/MacOS \
            /Applications/GoLand.app/Contents/MacOS \
            /usr/local/sbin \
            /usr/local/bin \
            /usr/sbin \
            /usr/bin \
            /sbin \
            /bin \
            $HOME/.local/bin \
            #$GEM_HOME/bin \
            $HOME/.krew/bin \
            $GOPATH/bin \
            $COMPOSER_HOME/vendor/bin \
            $HOME/.cargo/bin \
            $HOME/Library/Python/3.9/bin \
            $HOME/Library/Python/3.10/bin \
            $HOME/Library/Python/3.11/bin

set -xgp PATH $HOMEBREW_PREFIX/opt/vim/bin \
        $HOMEBREW_PREFIX/opt/nano/bin \
        $HOMEBREW_PREFIX/opt/sqlite/bin \
        $HOMEBREW_PREFIX/bin \
        $HOMEBREW_PREFIX/sbin \
        $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin \
        $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin \
        $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin \
        $HOMEBREW_PREFIX/opt/gnu-indent/libexec/gnubin \
        $HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin \
        $HOMEBREW_PREFIX/opt/gnu-which/libexec/gnubin \
        $HOMEBREW_PREFIX/opt/make/libexec/gnubin \
        $HOMEBREW_PREFIX/opt/gnu-getopt/bin \
        $HOMEBREW_PREFIX/opt/grep/libexec/gnubin \
        $HOMEBREW_PREFIX/opt/mysql-client@8.0/bin \
        $HOMEBREW_PREFIX/opt/postgresql@16/bin \
        $HOMEBREW_PREFIX/opt/openssl@1.1/bin

set -xg MANPATH $HOMEBREW_PREFIX/opt/findutils/libexec/gnuman \
                $HOMEBREW_PREFIX/opt/coreutils/share/man \
                $HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnuman \
                $HOMEBREW_PREFIX/opt/gnu-which/libexec/gnuman \
                $HOMEBREW_PREFIX/opt/gnu-which/libexec/gnuman \
                $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnuman \
                $HOMEBREW_PREFIX/opt/make/libexec/gnuman \
                $HOMEBREW_PREFIX/opt/mysql-client@8.0/share/man \
                $HOMEBREW_PREFIX/opt/postgresql@16/share/man \
                $HOMEBREW_PREFIX/share/man \
                /usr/local/MacGPG2/share/man \
                /usr/local/share/man \
                /usr/share/man

set -gx INFOPATH $HOMEBREW_PREFIX/share/info \
                 $INFOPATH

# # Set LS_COLORS
eval (dircolors -c $HOME/.dotfiles/files/shell/fish/dircolors | sed 's/>&\/dev\/null$//')

# Fix behat colours
set -xg BEHAT_PARAMS '{"formatters": {"pretty": {"output_styles": {"comment": ["blue"]}}}}'

# {
#     "output_styles": {
#         "keyboard": [null, null, ["bold"]],
#         "stdout": [null, null, []],
#         "exception": ["red"],
#         "undefined": ["yellow"],
#         "pending": ["yellow"],
#         "pending_param": ["yellow", null, ["bold"]],
#         "failed": ["red"],
#         "failed_param": ["red", null, ["bold"]],
#         "passed": ["green"],
#         "passed_param": ["green", null, ["bold"]],
#         "skipped": ["cyan"],
#         "skipped_param": ["cyan", null, ["bold"]],
#         "comment":["blue"],
#         "tag": ["cyan"]
#     }
# }
