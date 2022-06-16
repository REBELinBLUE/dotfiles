#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils/utils.sh

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

# brew-php-switcher 7.3 -s
# pecl channel-update pecl.php.net
# pecl uninstall xdebug
# pecl install xdebug
# cp $(brew --prefix php@7.3)/pecl/20180731/xdebug.so /tmp/php7.3-xdebug.so
# pecl uninstall pcov
# pecl install pcov
# cp $(brew --prefix php@7.3)/pecl/20180731/pcov.so /tmp/php7.3-pcov.so

brew-php-switcher 7.4 -s
pecl channel-update pecl.php.net
pecl uninstall xdebug
pecl install xdebug
cp $(brew --prefix php@7.4)/pecl/20190902/xdebug.so /tmp/php7.4-xdebug.so
ln -s $(brew --prefix pcre2)/include/pcre2.h $(brew --prefix php@7.4)/include/php/ext/pcre/pcre2.h
pecl uninstall pcov
pecl install pcov
cp $(brew --prefix php@7.4)/pecl/20190902/pcov.so /tmp/php7.4-pcov.so

brew-php-switcher 8.0 -s
pecl channel-update pecl.php.net
pecl uninstall xdebug
pecl install xdebug
cp $(brew --prefix php@8.0)/pecl/20200930/xdebug.so /tmp/php8.0-xdebug.so
ln -s $(brew --prefix pcre2)/include/pcre2.h $(brew --prefix php@8.0)/include/php/ext/pcre/pcre2.h
pecl uninstall pcov
pecl install pcov
cp $(brew --prefix php@8.0)/pecl/20200930/pcov.so /tmp/php8.0-pcov.so

brew-php-switcher 8.1 -s
pecl channel-update pecl.php.net
pecl uninstall xdebug
pecl install xdebug
cp $(brew --prefix php@8.1)/pecl/20210902/xdebug.so /tmp/php8.1-xdebug.so
ln -s $(brew --prefix pcre2)/include/pcre2.h $(brew --prefix php@8.1)/include/php/ext/pcre/pcre2.h
pecl uninstall pcov
pecl install pcov
cp $(brew --prefix php@8.1)/pecl/20210902/pcov.so /tmp/php8.1-pcov.so

#cp /tmp/php7.3-xdebug.so $(brew --prefix php@7.3)/pecl/20180731/xdebug.so
cp /tmp/php7.4-xdebug.so $(brew --prefix php@7.4)/pecl/20190902/xdebug.so
cp /tmp/php8.0-xdebug.so $(brew --prefix php@8.0)/pecl/20200930/xdebug.so
cp /tmp/php8.1-xdebug.so $(brew --prefix php@8.0)/pecl/20210902/xdebug.so

#cp /tmp/php7.3-pcov.so $(brew --prefix php@7.3)/pecl/20180731/pcov.so
cp /tmp/php7.4-pcov.so $(brew --prefix php@7.4)/pecl/20190902/pcov.so
cp /tmp/php8.0-pcov.so $(brew --prefix php@8.0)/pecl/20200930/pcov.so
cp /tmp/php8.1-pcov.so $(brew --prefix php@8.0)/pecl/20210902/pcov.so

brew-php-switcher 8.0 -s

e_arrow 'Downloading Psysh'
curl -LsS https://psysh.org/psysh -o /usr/local/bin/psysh
chmod a+x /usr/local/bin/psysh
mkdir -p ~/.local/share/psysh/
curl -LsS http://psysh.org/manual/en/php_manual.sqlite -o ~/.local/share/psysh/php_manual.sqlite

# e_arrow 'Downloading PHP Code Sniffer'
# curl -LsS https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /usr/local/bin/phpcs
# curl -LsS https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar -o /usr/local/bin/phpcbf
# chmod a+x /usr/local/bin/phpcs /usr/local/bin/phpcbf

# e_arrow 'Downloading PHPCS Fixer'
# curl -LsS https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v3.6.0/php-cs-fixer.phar -o /usr/local/bin/php-cs-fixer
# chmod a+x /usr/local/bin/php-cs-fixer

# e_arrow 'Downloading PHPStan'
# curl -LsS https://github.com/phpstan/phpstan/releases/download/1.4.8/phpstan.phar -o /usr/local/bin/phpstan
# chmod a+x /usr/local/bin/phpstan

# e_arrow 'Downloading PHPUnit'
# curl -LsS https://phar.phpunit.de/phpunit.phar -o /usr/local/bin/phpunit
# chmod a+x /usr/local/bin/phpunit

if [ ! -d $HOME/.config/composer/ ]; then
	mkdir -p $HOME/.config/composer/
fi

if [ ! -f $HOME/.config/composer/composer.json ]; then
	ln -s $HOME/.dotfiles/files/config/composer/composer.json $HOME/.config/composer/composer.json
	ln -s $HOME/.dotfiles/files/config/composer/composer.lock $HOME/.config/composer/composer.lock
fi

/usr/local/bin/composer global install
