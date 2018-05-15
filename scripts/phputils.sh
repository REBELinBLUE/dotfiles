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

brew-php-switcher 5.6 -s
pecl channel-update pecl.php.net
pecl install xdebug-2.5.5
cp $(brew --prefix php@5.6)/pecl/20131226/xdebug.so /tmp/php5.6-xdebug.so

brew-php-switcher 7.0 -s
pecl channel-update pecl.php.net
pecl uninstall xdebug
pecl install xdebug
cp $(brew --prefix php@7.0)/pecl/20151012/xdebug.so /tmp/php7.0-xdebug.so

brew-php-switcher 7.1 -s
pecl channel-update pecl.php.net
pecl uninstall xdebug
pecl install xdebug
cp $(brew --prefix php@7.1)/pecl/20160303/xdebug.so /tmp/php7.1-xdebug.so

brew-php-switcher 7.2 -s
pecl channel-update pecl.php.net
pecl uninstall xdebug
pecl install xdebug
cp $(brew --prefix php@7.2)/pecl/20170718/xdebug.so /tmp/php7.2-xdebug.so

cp /tmp/php5.6-xdebug.so $(brew --prefix php@5.6)/pecl/20131226/xdebug.so
cp /tmp/php7.0-xdebug.so $(brew --prefix php@7.0)/pecl/20151012/xdebug.so
cp /tmp/php7.1-xdebug.so $(brew --prefix php@7.1)/pecl/20160303/xdebug.so
cp /tmp/php7.2-xdebug.so $(brew --prefix php@7.2)/pecl/20170718/xdebug.so

brew-php-switcher 5.6 -s

e_arrow 'Downloading Melody'
curl -LsS http://get.sensiolabs.org/melody.phar -o /usr/local/bin/melody
chmod a+x /usr/local/bin/melody

e_arrow 'Downloading Psysh'
curl -LsS https://git.io/psysh -o /usr/local/bin/psysh
chmod a+x /usr/local/bin/psysh
mkdir -p ~/.local/share/psysh/
curl -LsS http://psysh.org/manual/en/php_manual.sqlite -o ~/.local/share/psysh/php_manual.sqlite

e_arrow 'Downloading Behat'
curl -LsS https://github.com/Behat/Behat/releases/download/v3.3.0/behat.phar -o /usr/local/bin/behat
chmod a+x /usr/local/bin/behat

e_arrow 'Downloading Couscous'
curl -LsS http://couscous.io/couscous.phar -o /usr/local/bin/couscous
chmod a+x /usr/local/bin/couscous

e_arrow 'Downloading Symfony Installer'
curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
chmod a+x /usr/local/bin/symfony

e_arrow 'Downloading PHP Code Sniffer'
curl -LsS https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /usr/local/bin/phpcs
chmod a+x /usr/local/bin/phpcs
/usr/local/bin/phpcs --config-set installed_paths $COMPOSER_HOME/vendor/escapestudios/symfony2-coding-standard/

e_arrow 'Downloading PHPCS Fixer'
curl -LsS https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.0.0/php-cs-fixer.phar -o /usr/local/bin/php-cs-fixer
chmod a+x /usr/local/bin/php-cs-fixer

e_arrow 'Downloading Faker'
curl -LsS https://github.com/bit3/faker-cli/releases/download/1.4/faker.phar -o /usr/local/bin/faker
chmod a+x /usr/local/bin/faker

e_arrow 'Downloading PHPDoc'
curl -LsS http://www.phpdoc.org/phpDocumentor.phar -o /usr/local/bin/phpdoc
chmod a+x /usr/local/bin/phpdoc

e_arrow 'Downloading PHPUnit'
curl -LsS https://phar.phpunit.de/phpunit.phar -o /usr/local/bin/phpunit
chmod a+x /usr/local/bin/phpunit

e_arrow 'Downloading PHPSpec'
curl -LsS https://github.com/phpspec/phpspec/releases/download/3.4.0/phpspec.phar -o /usr/local/bin/phpspec
chmod a+x /usr/local/bin/phpspec

e_arrow 'Downloading PHP Mess Detector'
curl -LsS http://static.phpmd.org/php/latest/phpmd.phar -o /usr/local/bin/phpmd
chmod a+x /usr/local/bin/phpmd

e_arrow 'Downloading Phing'
curl -LsS http://www.phing.info/get/phing-latest.phar -o /usr/local/bin/phing
chmod a+x /usr/local/bin/phing

e_arrow 'Downloading Box'
curl -LSs https://box-project.github.io/box2/installer.php | php
mv ./box.phar /usr/local/bin/box2
chmod a+x /usr/local/bin/box2

e_arrow 'Downloading PHPLoc'
curl -LsS https://phar.phpunit.de/phploc.phar -o /usr/local/bin/phploc
chmod a+x /usr/local/bin/phploc

e_arrow 'Downloading Codeception'
curl -LsS http://codeception.com/releases/2.2.11/codecept.phar -o /usr/local/bin/codecept
chmod a+x /usr/local/bin/codecept

e_arrow 'Downloading PHP Metrics'
curl -LsS  https://github.com/phpmetrics/PhpMetrics/raw/master/build/phpmetrics.phar -o /usr/local/bin/phpmetrics
chmod a+x /usr/local/bin/phpmetrics

e_arrow 'Downloading PHP Copy & Paste Detector'
curl -LsS https://phar.phpunit.de/phpcpd.phar -o /usr/local/bin/phpcpd
chmod a+x /usr/local/bin/phpcpd

e_arrow 'Installing PHP Parallel Lint'
cp $HOME/.dotfiles/bin/php-parallel-lint-0.9.2.phar /usr/local/bin/php-parallel-lint
chmod a+x /usr/local/bin/php-parallel-lint

e_arrow 'Installing PHPDoccheck'
cp $HOME/.dotfiles/bin/phpdoccheck-1.3.4.phar /usr/local/bin/phpdoccheck
chmod a+x /usr/local/bin/phpdoccheck

if [ ! -d $HOME/.config/composer/ ]; then
    mkdir -p $HOME/.config/composer/
fi

if [ ! -f $HOME/.config/composer/composer.json ]; then
    ln -s $HOME/.dotfiles/files/config/composer/composer.json $HOME/.config/composer/composer.json
    ln -s $HOME/.dotfiles/files/config/composer/composer.lock $HOME/.config/composer/composer.lock
fi

/usr/local/bin/composer global install

