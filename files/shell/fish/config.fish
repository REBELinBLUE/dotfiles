# Load exports
source $HOME/.dotfiles/files/shell/fish/scripts/exports.fish

if test -z "$__INTELLIJ_COMMAND_HISTFILE__"
    starship init fish | source
    direnv hook fish | source

    # Load helper files
    source $HOME/.dotfiles/files/shell/fish/scripts/helpers.fish
end

if test -z "$__INTELLIJ_COMMAND_HISTFILE__"
    # Load fishmarks
    source $HOME/.dotfiles/files/shell/fish/scripts/marks.fish
end

# Load any additional scripts
if test -e $HOME/.config/extras.fish
    source $HOME/.config/extras.fish
end

#gpgconf --launch gpg-agent
if test -e $HOME/.config/op/plugins.sh
    source $HOME/.config/op/plugins.sh
end
