function php-switch -d "Switches the symlinked PHP version"
    command brew-php-switcher "$argv" -s
    echo $argv > $XDG_CACHE_HOME/php_version
end
