function phpunit -d "Runs PHPUnit"
    php (which phpunit) "$argv"

    if [ $status -eq 0 ]
        set TITLE "Success"
        set MESSAGE "Tests ran succesfully"
        set IMAGE "$HOME/.dotfiles/files/icons/Success.icns"
        set SOUND "Glass"
    else if [ $status -eq 1 ]; or [ $status -eq 2 ]
        set TITLE "Failed"
        set MESSAGE "Tests are broken"
        set IMAGE "$HOME/.dotfiles/files/icons/Failed.icns"
        set SOUND "Basso"
    else
        return $status
    end

    set -l PREFIX (brew --prefix terminal-notifier)

    eval $PREFIX/bin/terminal-notifier -activate "com.googlecode.iTerm2" \
                                       -contentImage "$IMAGE" \
                                       -title P"HPUnit" \
                                       -subtitle "$TITLE" \
                                       -sound "$SOUND" \
                                       -message "$MESSAGE"
end
