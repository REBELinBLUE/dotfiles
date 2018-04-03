#!/usr/bin/env bash

source $HOME/.dotfiles/scripts/utils.sh

if ! is_os "darwin"; then
    e_error "The setup script is only for OS X"
    exit 1
fi

# Install vagrant plugins
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-notify
vagrant plugin install vagrant-reload
vagrant plugin install vagrant-cachier
vagrant plugin install vagrant-bindfs
vagrant plugin install vagrant-hostsupdater
vagrant plugin install vagrant-triggers
vagrant plugin install vagrant-rebuild
vagrant plugin install vagrant-clean
vagrant plugin install vagrant-nuke

# For some reason 0.6.1 which is in homebrew causes problems with vagrant
curl https://raw.githubusercontent.com/Russell91/sshrc/0.6/sshrc --silent -o /usr/local/bin/vagrant-sshrc
chmod +x /usr/local/bin/vagrant-sshrc

if [ ! -d /etc/sudoers.d/ ]; then
    sudo mkdir /etc/sudoers.d/
fi

# The path to tee now hard coded in vagrant 1.9.7 instead of replying on $PATH
cat > /tmp/vagrant << EOF
# Allow Vagrant to manage NFS exports.
Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
Cmnd_Alias VAGRANT_NFSD = $(which nfsd) restart
Cmnd_Alias VAGRANT_EXPORTS_REMOVE = $(which sed) -E -e /*/ d -ibak /etc/exports

# Allow Vagant to manage hosts file.
Cmnd_Alias VAGRANT_HOSTS_ADD = $(which sh) -c echo "*" >> /etc/hosts
Cmnd_Alias VAGRANT_HOSTS_REMOVE = $(which sed) -i -e /*/ d /etc/hosts

%admin ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD, VAGRANT_EXPORTS_REMOVE, VAGRANT_HOSTS_ADD, VAGRANT_HOSTS_REMOVE
EOF

sudo mv /tmp/vagrant /etc/sudoers.d/vagrant
sudo chown root:wheel /private/etc/sudoers.d/vagrant
sudo chmod 644 /private/etc/sudoers.d/vagrant

# Download debian and ubuntu boxes
#vagrant box add --provider virtualbox debian/jessie64
#vagrant box add --provider virtualbox ubuntu/trusty64

if [ ! -d $HOME/Vagrant/ ]; then
    mkdir $HOME/Vagrant/
fi

ln -s $HOME/.dotfiles/bin/notify-send /usr/local/bin/notify-send
chmod +x /usr/local/bin/notify-send

mkdir -p ~/.local/share/vagrant
mkdir -p ~/.cache/vagrant
ln -s ~/.cache/vagrant ~/.local/share/vagrant/cache
