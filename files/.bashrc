# Load the shell dotfiles
for file in $HOME/.dotfiles/files/shell/bash/{colours,functions,exports,completions,aliases,bash_prompt}; do
    if [ -r "$file" ] && [ -f "$file" ]; then
        source "$file"
    fi
done

unset file

if [ -r $HOME/.config/extras.bash ] && [ -f $HOME/.config/extras.bash ]; then
    source $HOME/.config/extras.bash
fi

source $HOME/.dotfiles/files/shell/bash/clear-colours

# added by travis gem
[ -f /Users/stephen.ball/.travis/travis.sh ] && source /Users/stephen.ball/.travis/travis.sh
