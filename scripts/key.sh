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


gpg --armor --export-secret-keys $KEYID > $GNUPGHOME/master.key

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

gpg --armor --export-secret-keys $KEYID > $GNUPGHOME/mastersub.key

gpg --armor --export-secret-subkeys $KEYID > $GNUPGHOME/sub.key

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

gpg --import < ~/Scratch/tmp.KYulRI1xDa/pubkey.txt

# Turn on touch for SIGNATURES.
ykman openpgp set-touch sig cached
# $PUK

# Turn on touch for AUTHENTICATION.
ykman openpgp set-touch aut on
# $PUK

# Turn on touch for ENCRYPTION.
ykman openpgp set-touch enc on
# $PUK

#KEYID=$(gpg --card-status | grep 'Signature key' | cut -f2 -d: | tr -d ' ')




#BIN_GPG_PUBKEY=$KEYID.gpg.pub.bin
#ASC_GPG_PUBKEY=$KEYID.gpg.pub.asc
#
#gpg --export "$KEYID" > ~/Desktop/$BIN_GPG_PUBKEY
#gpg --armor --export "$KEYID" > ~/Desktop/$ASC_GPG_PUBKEY
#cp ~/.gnupg/openpgp-revocs.d/$KEYID.rev ~/Desktop/$KEYID.rev
#rm ~/.gnupg/openpgp-revocs.d/$KEYID.rev
#
#/usr/local/MacGPG2/bin/gpgconf --kill all
#
#git config --global user.signingkey "$KEYID"
