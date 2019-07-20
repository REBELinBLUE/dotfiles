#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Remove stuff
sudo rm /usr/local/bin/melody /usr/local/bin/behat /usr/local/bin/couscous /usr/local/bin/symfony \
        /usr/local/bin/phpcs /usr/local/bin/php-cs-fixer /usr/local/bin/phpdoc /usr/local/bin/phpunit \
        /usr/local/bin/phpspec /usr/local/bin/phpmd /usr/local/bin/phing /usr/local/bin/box2 \
        /usr/local/bin/phploc /usr/local/bin/codecept /usr/local/bin/phpmetrics /usr/local/bin/phpcpd \
        /usr/local/bin/php-parallel-lint /usr/local/bin/phpstan /usr/local/bin/phpdoccheck

#source $HOME/.dotfiles/scripts/dotfiles.sh
