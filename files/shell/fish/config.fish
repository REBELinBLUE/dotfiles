# Load exports
source $HOME/.dotfiles/files/shell/fish/scripts/exports.fish

set -g fish_complete_path $fish_complete_path /opt/homebrew/share/fish/completions/
set -g fish_function_path $fish_function_path /opt/homebrew/share/fish/functions/

if not set -q __INTELLIJ_COMMAND_HISTFILE__
    if type -q starship
        starship init fish | source
    end

    if type -q direnv
        direnv hook fish | source
    end

    source $HOME/.dotfiles/files/shell/fish/scripts/helpers.fish
    source $HOME/.dotfiles/files/shell/fish/scripts/marks.fish
end

# Load any additional scripts
if test -e $HOME/.config/extras.fish
    source $HOME/.config/extras.fish
end

# if type -q gpgconf
#     gpgconf --launch gpg-agent
# end

if test -e $HOME/.config/op/plugins.sh
    source $HOME/.config/op/plugins.sh
end
