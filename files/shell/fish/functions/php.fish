function php
    set -l PHP_VERSION (command cat $HOME/.php_version)
    set -l XDEBUG (brew --prefix php$PHP_VERSION-xdebug)

    command php -dzend_extension=$XDEBUG/xdebug.so $argv
end
