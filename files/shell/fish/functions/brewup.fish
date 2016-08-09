function brewup -d 'Updates homebrew'
    brew update
    brew upgrade --all
    brew bundle --file="$HOME/.dotfiles/brewfiles/all"
    brew cleanup
end
