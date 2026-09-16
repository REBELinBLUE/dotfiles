#!/usr/bin/env bash

set -euo pipefail

source "${HOME}/.dotfiles/scripts/utils/utils.sh" || exit 1

if ! is_os "darwin"; then
    e_error "The update script is only for OS X"
    exit 1
fi

# Remove stuff
packages_to_remove=(
    "openssl@1.1"
    "docker-completion"
)

for package in "${packages_to_remove[@]}"; do
    if brew list "$package" &>/dev/null; then
        e_arrow "Removing $package..."
        brew uninstall "$package"
    fi
done

e_success "Cleanup complete"

#source $HOME/.dotfiles/scripts/dotfiles.sh
