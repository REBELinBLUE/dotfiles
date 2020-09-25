function resetcard -d "resets the GPG card being used"
  rm -rf ~/.gnupg/private-keys-v1.d
  gpgconf --kill gpg-agent
  gpg --card-status
  #gpg --edit-key ???
end
