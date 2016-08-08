set -x PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin

# Setup terminal, and turn on colors
set -x TERM xterm-256color
#set -xU LS_COLORS "di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34:su=0:sg=0:tw=0:ow=0:"

set -x LESS '--ignore-case --raw-control-chars'
set -x PAGER 'less'
set -x EDITOR 'nano'

set -x LANG en_GB.UTF-8
set -x LC_CTYPE "en_GB.UTF-8"
set -x LC_MESSAGES "en_GB.UTF-8"
set -x LC_COLLATE C
