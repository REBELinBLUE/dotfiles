function php-switch -d "Switches the symlinked PHP version"
    brew-php-switcher "$argv" -s
    echo "$argv" > $HOME/.php_version
end
