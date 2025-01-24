#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

# Ask for the administrator password upfront
#sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
#while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# brew-php-switcher 8.0 -s
# pecl channel-update pecl.php.net
# pecl uninstall xdebug
# pecl install xdebug
# cp $(brew --prefix php@8.0)/pecl/20200930/xdebug.so /tmp/php8.0-xdebug.so
# ln -s $(brew --prefix pcre2)/include/pcre2.h $(brew --prefix php@8.0)/include/php/ext/pcre/pcre2.h
# pecl uninstall pcov
# pecl install pcov
# cp $(brew --prefix php@8.0)/pecl/20200930/pcov.so /tmp/php8.0-pcov.so

brew-php-switcher 8.1 -s
pecl channel-update pecl.php.net
pecl uninstall xdebug
pecl install xdebug
cp $(brew --prefix php@8.1)/pecl/20210902/xdebug.so /tmp/php8.1-xdebug.so
ln -s $(brew --prefix pcre2)/include/pcre2.h $(brew --prefix php@8.1)/include/php/ext/pcre/pcre2.h
pecl uninstall pcov
pecl install pcov
cp $(brew --prefix php@8.1)/pecl/20210902/pcov.so /tmp/php8.1-pcov.so

brew-php-switcher 8.2 -s
pecl channel-update pecl.php.net
pecl uninstall xdebug
pecl install xdebug
cp $(brew --prefix php@8.2)/pecl/20220829/xdebug.so /tmp/php8.2-xdebug.so
ln -s $(brew --prefix pcre2)/include/pcre2.h $(brew --prefix php@8.2)/include/php/ext/pcre/pcre2.h
pecl uninstall pcov
pecl install pcov
cp $(brew --prefix php@8.2)/pecl/20220829/pcov.so /tmp/php8.2-pcov.so

brew-php-switcher 8.3 -s
pecl channel-update pecl.php.net
pecl uninstall xdebug
pecl install xdebug
cp $(brew --prefix php@8.3)/pecl/20230831/xdebug.so /tmp/php8.3-xdebug.so
ln -s $(brew --prefix pcre2)/include/pcre2.h $(brew --prefix php@8.3)/include/php/ext/pcre/pcre2.h
pecl uninstall pcov
pecl install pcov
cp $(brew --prefix php@8.3)/pecl/20230831/pcov.so /tmp/php8.3-pcov.so

brew-php-switcher 8.4 -s
pecl channel-update pecl.php.net
pecl uninstall xdebug
pecl install xdebug
cp $(brew --prefix php)/pecl/20230831/xdebug.so /tmp/php8.3-xdebug.so
ln -s $(brew --prefix pcre2)/include/pcre2.h $(brew --prefix php)/include/php/ext/pcre/pcre2.h
pecl uninstall pcov
pecl install pcov
cp $(brew --prefix php)/pecl/20230831/pcov.so /tmp/php8.3-pcov.so

# cp /tmp/php8.0-xdebug.so $(brew --prefix php@8.0)/pecl/20200930/xdebug.so
cp /tmp/php8.1-xdebug.so $(brew --prefix php@8.1)/pecl/20210902/xdebug.so
cp /tmp/php8.2-xdebug.so $(brew --prefix php@8.2)/pecl/20220829/xdebug.so
cp /tmp/php8.3-xdebug.so $(brew --prefix php@8.3)/pecl/20230831/xdebug.so
cp /tmp/php8.4-xdebug.so $(brew --prefix php)/pecl/20230831/xdebug.so


# cp /tmp/php8.0-pcov.so $(brew --prefix php@8.0)/pecl/20200930/pcov.so
cp /tmp/php8.1-pcov.so $(brew --prefix php@8.1)/pecl/20210902/pcov.so
cp /tmp/php8.2-pcov.so $(brew --prefix php@8.2)/pecl/20220829/pcov.so
cp /tmp/php8.3-pcov.so $(brew --prefix php)/pecl/20230831/pcov.so

brew-php-switcher 8.1 -s

e_arrow 'Downloading PHP Manual for Psysh'
mkdir -p ~/.local/share/psysh/
curl -LsS http://psysh.org/manual/en/php_manual.sqlite -o ~/.local/share/psysh/php_manual.sqlite

if [ ! -d $HOME/.config/composer/ ]; then
    mkdir -p $HOME/.config/composer/
fi

if [ ! -f $HOME/.config/composer/composer.json ]; then
    ln -s $HOME/.dotfiles/files/config/composer/composer.json $HOME/.config/composer/composer.json
    ln -s $HOME/.dotfiles/files/config/composer/composer.lock $HOME/.config/composer/composer.lock
fi

$(brew --prefix composer)/bin/composer global install
