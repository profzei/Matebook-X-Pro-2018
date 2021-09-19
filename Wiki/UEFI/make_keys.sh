#!/bin/bash
# Copyright (c) 2021 by profzei
# Licensed under the terms of the GPL v3

# Common Name : Huawei MBXP 2018
echo -n "Enter a Common Name to embed in the keys: "
read NAME

openssl req -new -x509 -newkey rsa:2048 -sha256 -days 3650 -nodes -subj "/CN=$NAME Platform Key" -keyout PK.key -out PK.pem
openssl req -new -x509 -newkey rsa:2048 -sha256 -days 3650 -nodes -subj "/CN=$NAME Key Exchange Key" -keyout KEK.key -out KEK.pem
openssl req -new -x509 -newkey rsa:2048 -sha256 -days 3650 -nodes -subj "/CN=$NAME Image Signing Key" -keyout ISK.key -out ISK.pem

GUID=`python3 -c 'import uuid; print(str(uuid.uuid1()))'`
echo $GUID > myGUID.txt

cert-to-efi-sig-list -g "$GUID" PK.pem PK.esl
cert-to-efi-sig-list -g "$GUID" KEK.pem KEK.esl
cert-to-efi-sig-list -g "$GUID" ISK.pem ISK.esl

openssl x509 -in MicWinProPCA2011_2011-10-19.crt -inform DER -out MsWin.pem -outform PEM
openssl x509 -in MicCorUEFCA2011_2011-06-27.crt -inform DER -out UEFI.pem -outform PEM
cert-to-efi-sig-list -g "$GUID" MsWin.pem MsWin.esl
cert-to-efi-sig-list -g "$GUID" UEFI.pem UEFI.esl
cat ISK.esl MsWin.esl UEFI.esl > db.esl

sign-efi-sig-list -k PK.key -c PK.pem PK PK.esl PK.auth
sign-efi-sig-list -k PK.key -c PK.pem KEK KEK.esl KEK.auth
sign-efi-sig-list -k KEK.key -c KEK.pem db db.esl db.auth

chmod 0600 *.key

echo ""
echo ""
echo "For use with KeyTool, copy the *.auth files to a FAT32 USB"
echo "flash drive or to your EFI System Partition (ESP)."
echo ""
