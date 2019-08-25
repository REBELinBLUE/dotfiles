function update -d "Updates all software"
    sudo mas upgrade
    sudo softwareupdate -i -a
    command composer self-update
    command composer global install
    brewup
    npm install npm -g; and npm update -g
    #sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U -q
end
