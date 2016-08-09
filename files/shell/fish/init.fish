# Load helper files
source $OMF_CONFIG/scripts/helpers.fish

# Load exports
source $OMF_CONFIG/scripts/exports.fish

# Load fishmarks
source $OMF_CONFIG/scripts/marks.fish

# Load any additional scripts
if test -e ~/.extras.fish
    source ~/.extras.fish
end

# TODO

# Missing history config
# Add PHPUnit function
