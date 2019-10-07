if test -z "$INTELLIJ_ENVIRONMENT_READER"
    eval (starship init fish)

    # Load helper files
    source $HOME/.dotfiles/files/shell/fish/scripts/helpers.fish
end

# Load exports
source $HOME/.dotfiles/files/shell/fish/scripts/exports.fish

if test -z "$INTELLIJ_ENVIRONMENT_READER"
    # # Load fishmarks
    source $HOME/.dotfiles/files/shell/fish/scripts/marks.fish

    eval (direnv hook fish)
end

# # Load any additional scripts
if test -e $HOME/.config/extras.fish
    source $HOME/.config/extras.fish
end
