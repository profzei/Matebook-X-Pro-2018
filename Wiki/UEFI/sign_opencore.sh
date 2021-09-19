#!/bin/bash
# Copyright (c) 2021 by profzei
# Licensed under the terms of the GPL v3

LINK=$1
# https://github.com/acidanthera/OpenCorePkg/releases/download/0.7.2/OpenCore-0.7.2-RELEASE.zip
VERSION=$2
# 0.7.2


if ! command -v wget &> /dev/null
then
    echo "Please install wget"
    exit
fi

if ! command -v sbsign &> /dev/null
then
    echo "Please install sbsigntools"
    exit
fi

mkdir Signed
mkdir Signed/Drivers
mkdir Signed/Tools

# Download and unzip OpenCore
wget $LINK
unzip "OpenCore-${VERSION}-RELEASE.zip" "X64/*" -d "./Downloaded"
rm "OpenCore-${VERSION}-RELEASE.zip"

# Download HfsPlus
wget https://github.com/acidanthera/OcBinaryData/raw/master/Drivers/HfsPlus.efi -O ./Downloaded/HfsPlus.efi

if [ -f "./ISK.key" ]; then
    echo "ISK.key was decrypted successfully"
fi

if [ -f "./ISK.pem" ]; then
    echo "ISK.pem was decrypted successfully"
fi

# Sign drivers
sbsign --key ISK.key --cert ISK.pem --output ./Signed/BOOTx64.efi ./Downloaded/X64/EFI/BOOT/BOOTx64.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/OpenCore.efi ./Downloaded/X64/EFI/OC/OpenCore.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/OpenRuntime.efi ./Downloaded/X64/EFI/OC/Drivers/OpenRuntime.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/OpenCanopy.efi ./Downloaded/X64/EFI/OC/Drivers/OpenCanopy.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/AudioDxe.efi ./Downloaded/X64/EFI/OC/Drivers/AudioDxe.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Drivers/HfsPlus.efi ./Downloaded/HfsPlus.efi
sbsign --key ISK.key --cert ISK.pem --output ./Signed/Tools/OpenShell.efi ./Downloaded/X64/EFI/OC/Tools/OpenShell.efi

# Clean 
rm -rf Downloaded
echo "Cleaned..."
