if test -z "$INTELLIJ_ENVIRONMENT_READER"
    eval (starship init fish)

    # Load helper files
    source $HOME/.dotfiles/files/shell/fish/scripts/helpers.fish

    # # Load exports
    source $HOME/.dotfiles/files/shell/fish/scripts/exports.fish

    # # Load fishmarks
    source $HOME/.dotfiles/files/shell/fish/scripts/marks.fish

    # # Load any additional scripts
    if test -e $HOME/.config/extras.fish
        source $HOME/.config/extras.fish
    end

    eval (direnv hook fish)
end
