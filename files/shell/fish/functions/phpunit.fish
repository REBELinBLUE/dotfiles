function phpunit -d "Runs PHPUnit"
    php $(which phpunit) $@
    RESULT=$?

    if [[ $RESULT = 0 ]]; then
        TITLE="Success"
        MESSAGE="Tests ran succesfully"
        IMAGE="$HOME/.dotfiles/files/icons/Success.icns"
        SOUND="Glass"
    elif [[ $RESULT = 1 || $RESULT = 2 ]]; then
        TITLE="Failed"
        MESSAGE="Tests are broken"
        IMAGE="$HOME/.dotfiles/files/icons/Failed.icns"
        SOUND="Basso"
    else
        return $RESULT
    fi

    $(brew --prefix terminal-notifier)/bin/terminal-notifier -activate "com.googlecode.iTerm2" \
                                                             -contentImage "$IMAGE" \
                                                             -title "PHPUnit"\
                                                             -subtitle "$TITLE" \
                                                             -sound "$SOUND" \
                                                             -message "$MESSAGE"
end
