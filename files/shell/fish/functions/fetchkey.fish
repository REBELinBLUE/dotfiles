function fetchkey -d "fetches the public key from the URL on the card"
  gpg --card-status | grep "public key" | cut -d: -f2- | xargs curl | gpg --import
end

