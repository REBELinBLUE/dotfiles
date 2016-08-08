set -x PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin

# Setup terminal, and turn on colors
set -x TERM xterm-256color

set -x LESS '--ignore-case --raw-control-chars'
set -x PAGER 'less'
set -x EDITOR 'nano'

set -x LANG en_GB.UTF-8
set -x LC_CTYPE "en_GB.UTF-8"
set -x LC_MESSAGES "en_GB.UTF-8"
set -x LC_COLLATE C

source /opt/fishmarks/marks.fish
