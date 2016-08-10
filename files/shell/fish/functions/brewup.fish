function brewup -d 'Updates homebrew'
    command brew update
    command brew upgrade --all
    command brew bundle --file="$HOME/.dotfiles/brewfiles/all"
    command brew cleanup
end
