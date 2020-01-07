#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if ! type_exists 'composer'; then
    e_arrow 'Downloading Composer'
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
    chmod a+x /usr/local/bin/composer
else
    /usr/local/bin/composer self-update
fi

brew-php-switcher 7.2 -s
pecl channel-update pecl.php.net
pecl uninstall xdebug
pecl install xdebug
cp $(brew --prefix php@7.2)/pecl/20170718/xdebug.so /tmp/php7.2-xdebug.so

brew-php-switcher 7.3 -s
pecl channel-update pecl.php.net
pecl uninstall xdebug
pecl install xdebug
cp $(brew --prefix php@7.3)/pecl/20180731/xdebug.so /tmp/php7.3-xdebug.so

brew-php-switcher 7.4 -s
pecl channel-update pecl.php.net
pecl uninstall xdebug
pecl install xdebug
cp $(brew --prefix php@7.4)/pecl/20190902/xdebug.so /tmp/php7.4-xdebug.so

cp /tmp/php7.2-xdebug.so $(brew --prefix php@7.2)/pecl/20170718/xdebug.so
cp /tmp/php7.3-xdebug.so $(brew --prefix php@7.3)/pecl/20180731/xdebug.so
cp /tmp/php7.4-xdebug.so $(brew --prefix php@7.4)/pecl/20190902/xdebug.so

brew-php-switcher 7.4 -s

e_arrow 'Downloading Psysh'
curl -LsS https://psysh.org/psysh -o /usr/local/bin/psysh
chmod a+x /usr/local/bin/psysh
mkdir -p ~/.local/share/psysh/
curl -LsS http://psysh.org/manual/en/php_manual.sqlite -o ~/.local/share/psysh/php_manual.sqlite

e_arrow 'Downloading PHP Code Sniffer'
curl -LsS https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /usr/local/bin/phpcs
chmod a+x /usr/local/bin/phpcs

e_arrow 'Downloading PHPCS Fixer'
curl -LsS https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.15.1/php-cs-fixer.phar -o /usr/local/bin/php-cs-fixer
chmod a+x /usr/local/bin/php-cs-fixer

e_arrow 'Downloading PHP Mess Detector'
curl -LsS https://github.com/phpmd/phpmd/releases/download/2.6.1/phpmd.phar -o /usr/local/bin/phpmd
chmod a+x /usr/local/bin/phpmd

rm -f /usr/local/bin/pstorm
ln -s $HOME/.dotfiles/bin/pstorm /usr/local/bin/pstorm
chmod +x /usr/local/bin/pstorm

if [ ! -d $HOME/.config/composer/ ]; then
    mkdir -p $HOME/.config/composer/
fi

if [ ! -f $HOME/.config/composer/composer.json ]; then
    ln -s $HOME/.dotfiles/files/config/composer/composer.json $HOME/.config/composer/composer.json
    ln -s $HOME/.dotfiles/files/config/composer/composer.lock $HOME/.config/composer/composer.lock
fi

/usr/local/bin/composer global install

