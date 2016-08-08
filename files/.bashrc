# Load the shell dotfiles
for file in $HOME/.dotfiles/files/shell/bash/{colours,functions,exports,completions,aliases,bash_prompt}; do
    if [ -r "$file" ] && [ -f "$file" ]; then
        source "$file"
    fi
done

unset file

if [ -r $HOME/.extras ] && [ -f $HOME/.extras ]; then
    source $HOME/.extras
fi

source $HOME/.dotfiles/files/shell/bash/clear-colours
