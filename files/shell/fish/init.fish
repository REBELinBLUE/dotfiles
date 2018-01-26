# Load helper files
source $OMF_CONFIG/scripts/helpers.fish

# Load exports
source $OMF_CONFIG/scripts/exports.fish

# Load fishmarks
source $OMF_CONFIG/scripts/marks.fish

# Load any additional scripts
if test -e $HOME/.config/extras.fish
    source $HOME/.config/extras.fish
end

eval (direnv hook fish)

#touchbar
