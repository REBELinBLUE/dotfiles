#!/usr/bin/env bash

# Hacked together from https://github.com/DataDog/yubikey & https://github.com/drduh/YubiKey-Guide/tree/1ad37577db92726eadde4dc302a6f982ba7e82dc#create-temporary-working-directory-for-gpg

ykman info

gpg --card-status
ykman openpgp reset

# Turning off YubiKey OTP
ykman mode "FIDO+CCID"

export GNUPGHOME=$(mktemp -d) ; echo $GNUPGHOME
cat << EOF > $GNUPGHOME/gpg.conf
use-agent
personal-cipher-preferences AES256 AES192 AES CAST5
personal-digest-preferences SHA512 SHA384 SHA256 SHA224
default-preference-list SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed
cert-digest-algo SHA512
s2k-digest-algo SHA512
s2k-cipher-algo AES256
charset utf-8
fixed-list-mode
no-comments
no-emit-version
keyid-format 0xlong
list-options show-uid-validity
verify-options show-uid-validity
with-fingerprint
EOF

gpg --full-generate-key

# 4
# 4096
# 10y

KEYID=????

gpg --edit-key $KEYID

# adduid

gpg --expert --edit-key $KEYID

# addkey
# 4 - RSA signing key
# 4096
# 10y

# addkey
# 6 - RSA encryption
# 4096
# 10y

# addkey
# 8 - RSA set own
# s - turn off signing
# e - turn off encryption
# a - turn on authentication
# q
# 4069
# 10y



gpg --armor --export $KEYID > pubkey.asc

gpg --export $KEYID | hokey lint

gpg --armor --export-secret-keys $KEYID > $GNUPGHOME/mastersub.asc

gpg --armor --export-secret-subkeys $KEYID > $GNUPGHOME/sub.asc

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
# 3 - Authentication key

rm -rf $GNUPGHOME
unset $GNUPGHOME
gpgconf --kill all

gpg --import < ~/Scratch/????/pubkey.asc

# Turn on touch for SIGNATURES.
ykman openpgp set-touch sig cached
# $PUK

# Turn on touch for AUTHENTICATION.
ykman openpgp set-touch aut on
# $PUK

# Turn on touch for ENCRYPTION.
ykman openpgp set-touch enc on
# $PUK

hkt export-pubkeys ???? --keyring ~/.gnupg/pubring.gpg | hokey lint

#KEYID=$(gpg --card-status | grep 'Signature key' | cut -f2 -d: | tr -d ' ')

# gpg-connect-agent 'keyinfo --list' /bye
# gpg-connect-agent 'scd serialno' 'learn --force' /bye
