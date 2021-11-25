function swapcard -d "resets the smartcard being used"
  # rm -rf ~/.gnupg/private-keys-v1.d
  # gpgconf --kill gpg-agent
  # gpg --card-status
  # #gpg --edit-key ???
  gpg-connect-agent "scd serialno" "learn --force" /bye
end
