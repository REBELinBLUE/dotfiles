#!/usr/bin/env bash

# Hacked together from https://github.com/DataDog/yubikey & https://github.com/drduh/YubiKey-Guide/tree/1ad37577db92726eadde4dc302a6f982ba7e82dc#create-temporary-working-directory-for-gpg

ykman info

gpg --card-status
ykman openpgp reset -f

# Turning off YubiKey OTP, HSM and OATH
ykman config usb --disable OATH -f
ykman config usb --disable HSMAUTH -f
ykman config usb --disable OTP -f

export GNUPGHOME=$(mktemp -d) ; echo $GNUPGHOME
cat << EOF > $GNUPGHOME/gpg.conf
use-agent
personal-cipher-preferences AES256 AES192 AES
personal-digest-preferences SHA512 SHA384 SHA256
default-preference-list SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed
cert-digest-algo SHA512
s2k-digest-algo SHA512
s2k-cipher-algo AES256
charset utf-8
fixed-list-mode
no-comments
no-emit-version
no-greating
keyid-format 0xlong
list-options show-uid-validity
verify-options show-uid-validity
with-fingerprint
with-fingerprint
EOF

gpg --expert --full-generate-key

# 8
# s - turn off signing
# e - turn off encryption
# a - turn off authentication
# 4096
# 10y

#KEYID=$(gpg --list-secret-keys --keyid-format long | grep sec | cut -d' ' -f 4 |  tr -d ' ' | sed 's#.*/##')

gpg --edit-key $KEYID

# adduid
# trust
# primary

gpg --expert --edit-key $KEYID

# addkey
# 8 - RSA set own
# s - turn on signing
# e - turn off encryption
# a - turn off authentication
# 4096
# 10y

# addkey
# 8 - RSA set own
# s - turn off signing
# e - turn on encryption
# a - turn off authentication
# 4096
# 10y

# addkey
# 8 - RSA set own
# s - turn off signing
# e - turn off encryption
# a - turn on authentication
# 4069
# 10y

gpg --gen-revoke $KEYID > revocation-certificate.asc

gpg --armor --export $KEYID > public-key.asc

gpg --armor --export-secret-keys $KEYID > master-with-subkeys.asc

gpg --armor --export-secret-subkeys $KEYID > subkeys.asc

sudo cp -avi $GNUPGHOME ~/Scratch

# Now generating your GPG keys on the YubiKey itself
gpg --card-edit

# admin
# passwd
# 1
# Pin 123456
# New $PIN
# 3
# Admin PIN: 12345678
# Admin PIN: $PUK
# name
# lang
# login
# salutation
# url
# quit

gpg --edit-key $KEYID

# toggle
# key 1
# keytocard
# 1 - Signature key

# key 1
# key 2
# keytocard
# 2 - Encryption key

# key 2
# key 3
# keytocard
# 3 - Authentication key

rm -rf $GNUPGHOME
unset $GNUPGHOME
gpgconf --kill all

gpg --import < ~/Scratch/**/public-key.asc
#curl https://keybase.io/rebelinblue/pgp_keys.asc | gpg --import

# Turn on touch for SIGNATURES.
ykman openpgp keys set-touch sig on -f
# $PUK

# Turn on touch for AUTHENTICATION.
ykman openpgp keys set-touch aut cached -f
# $PUK

# Turn on touch for ENCRYPTION.
ykman openpgp keys set-touch enc on -f
# $PUK

#KEYID=$(gpg --card-status | grep 'Signature key' | cut -f2 -d: | tr -d ' ')

# gpg-connect-agent 'keyinfo --list' /bye
# gpg-connect-agent 'scd serialno' 'learn --force' /bye
