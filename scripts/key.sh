#!/usr/bin/env bash

# Hacked together from https://github.com/DataDog/yubikey

PIN=$(python -S -c "import random; print(random.SystemRandom().randrange(10**7,10**8))")
PUK=$(python -S -c "import random; print(random.SystemRandom().randrange(10**7,10**8))")
SERIAL=$(ykman info | grep 'Serial number:' | cut -f2 -d: | tr -d ' ')

YUBIKEY_FIPS=false
KEY_LENGTH=4096
TOUCH_POLICY=cached

ykman info

gpg --card-status
ykman openpgp reset


# Turning off YubiKey OTP
ykman mode "FIDO+CCID"

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
# q

# Set desired key attributes.
# key-attr
# - Signature key
# 1
# $KEY_LENGTH
# $PUK
# - Encryption key
# 1
# $KEY_LENGTH
# $PUK
# - Authnetication key
# 1
# $KEY_LENGTH
# $PUK

# generate
# n
# $PIN
# 10y
# Y
# Real name: Stephen Ball
# Email address: stephen@rebelinblue.com
# Comment:
# O
# quit

# Turn on touch for SIGNATURES.
ykman openpgp set-touch sig $TOUCH_POLICY
# $PUK

# Turn on touch for AUTHENTICATION.
ykman openpgp set-touch aut on
# $PUK

# Turn on touch for ENCRYPTION.
ykman openpgp set-touch enc on
# $PUK

KEYID=$(gpg --card-status | grep 'Signature key' | cut -f2 -d: | tr -d ' ')
BIN_GPG_PUBKEY=$KEYID.gpg.pub.bin
ASC_GPG_PUBKEY=$KEYID.gpg.pub.asc

gpg --export "$KEYID" > "~/Desktop/$BIN_GPG_PUBKEY"
gpg --armor --export "$KEYID" > "~/Desktop/$ASC_GPG_PUBKEY"
cp ~/.gnupg/openpgp-revocs.d/$KEYID.rev ~/Desktop/$KEYID.rev
rm ~/.gnupg/openpgp-revocs.d/$KEYID.rev

/usr/local/MacGPG2/bin/gpgconf --kill all

git config --global user.signingkey "$KEYID"
