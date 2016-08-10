function php-switch -d "Switches the symlinked PHP version"
    command brew-php-switcher "$argv" -s
    echo $argv > $XDG_DATA_HOME/php_version
end
