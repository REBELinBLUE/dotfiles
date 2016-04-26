#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

brew remove 'ed'
brew remove 'wdiff'

# pip show apiary2postman | grep Requires | sed 's/Requires: //g; s/,//g'
# pip show boto  | grep Requires | sed 's/Requires: //g; s/,//g'
# pip show cheat  | grep Requires | sed 's/Requires: //g; s/,//g'
# pip show enum34 | grep Requires | sed 's/Requires: //g; s/,//g'
# pip show httpie  | grep Requires | sed 's/Requires: //g; s/,//g'
# pip show httpie-jwt-auth | grep Requires | sed 's/Requires: //g; s/,//g'
# pip show pip  | grep Requires | sed 's/Requires: //g; s/,//g'
# pip show ply  | grep Requires | sed 's/Requires: //g; s/,//g'
# pip show Pygments | grep Requires | sed 's/Requires: //g; s/,//g'
# pip show setuptools  | grep Requires | sed 's/Requires: //g; s/,//g'
# pip show vboxapi | grep Requires | sed 's/Requires: //g; s/,//g'
# pip show wheel | grep Requires | sed 's/Requires: //g; s/,//g'
# pip show yara-python | grep Requires | sed 's/Requires: //g; s/,//g'

# Remove glances
pip uninstall -y bottle pysnmp pysmi pyasn1 pycrypto zeroconf netifaces six python-dateutil requests pytz enum-compat influxdb statsd numpy pytz python-dateutil cycler pyparsing pystache matplotlib py-cpuinfo psutil glances

source $HOME/.dotfiles/scripts/dotfiles.sh

exec $SHELL -l
