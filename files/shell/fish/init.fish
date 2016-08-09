# Load helper files
source $OMF_CONFIG/helpers.fish

# Load exports
source $OMF_CONFIG/exports.fish

# Load fishmarks
source /opt/fishmarks/marks.fish

# Load any additional scripts
if test -e ~/.extras.fish
    source ~/.extras.fish
end

# TODO
#
# Missing history config
# Add PHPUnit function
