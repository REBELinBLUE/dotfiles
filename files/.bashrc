# Load the shell dotfiles
for file in $HOME/.dotfiles/files/.{bash_prompt,completions,exports,aliases}; do
    if [ -r "$file" ] && [ -f "$file" ]; then
        source "$file"
    fi
done

unset file

if [ -r $HOME/.extras ] && [ -f $HOME/.extras ]; then
    source $HOME/.extras
fi
