# Huawei Matebook X Pro (2018 Edition)
[![release](https://img.shields.io/badge/download-release-blue.svg)](https://github.com/profzei/Matebook-X-Pro-2018/releases) [![wiki](https://img.shields.io/badge/support-wiki-green.svg)](https://github.com/profzei/Matebook-X-Pro-2018/wiki)

macOS on Huawei Matebook X Pro 2018
![Alt text](https://ivanov-audio.com/wp-content/uploads/2014/01/Hackintosh-Featured-Image.png)

This repo is currently compatible with macOS Mojave 10.14.6 (18G87)


## Configuration

| Specifications      | Details                                          |
| :--- | :---|
| Computer model      | Huawei Matebook X Pro 2018 Space Gray            |
| Processor           | Intel Core i7-8550U Processor @ 1.8 GHz          |
| Memory              | 8 GB LPDDR3 2133 MHz                             |
| Hard Disk           | LiteON SSD PCIe NVMe 512 GB [CA3-8D512]          |
| Integrated Graphics | NVIDIA GeForce MX150 / Intel(R) UHD Graphics 620 |
| Screen              | JDI 3k Display @ 3000 x 2000 (13.9 inch)         |
| Sound Card          | Realtek ALC255 ???                               |
| Wireless Card       | Intel Dual Band Wireless-AC 8265/8275            |
| Bluetooth Card      | Intel Bluetooth 8265/8275                        |

This repository is for personal purposes: it is heavily based on the hard work done by [gnodipac886](https://github.com/gnodipac886/MatebookXPro-hackintosh), but with some significant personal improvements in `CLOVER/ACPI/patched` and `CLOVER/kexts/Other` sections.


Changelog:   	see [Changelog.md](Changelog.md)


## Device Firmware
- Bios version: `1.28`

## Bootloader Firmware
- Default bootloader: Clover `r5103` [Dids release](https://github.com/Dids/clover-builder/releases)

## SMBIOS
- Default SMBIOS settings of this repo is `MacBookPro14,1`

## Power management: CPUFriend
CPU power management can be achieved by using `CPUFriend.kext` while `CPUFriendDataProvider.kext` defines how it should be done. `CPUFriendDataProvider.kext` is generated for a specific CPU and power setting. The one supplied in this repository was made for `i7-8550U` and is optimized for balanced performance.
- The kexts and SSDT for `i7-8550U` are [here](/CPUFriend/1.2.0).
- `CPUFriendDataProvider.kext` is generated for SMBIOS `MacBookPro15,2` because of Kaby Lake R architecture.
- `CPUFriend.kext` and `CPUFriendDataProvider.kext` need to be put in `CLOVER/kexts/Other`
- Furthermore, you also need to put `SSDT-XCPM.aml` in `CLOVER/ACPI/patched` for working as normal after awake.

## Power management: Hibernation
Hibernation (suspend to disk or S4 sleep) is not supported on a Hackintosh: so it's recommended to disable it.
```
sudo pmset -a hibernatemode 0
sudo rm -f /var/vm/sleepimage
sudo mkdir /var/vm/sleepimage
```
Also, it's important to disable the other hibernation related functions.
```
sudo pmset -a standby 0
sudo pmset -a autopoweroff 0
```
Disabling additional features prevents random wakeups while the lid is closed.
```
sudo pmset -a powernap 0
sudo pmset -a proximitywake 0   [optional]
sudo pmset -b tcpkeepalive 0    [optional]
```
After every update, ALL these settings should be reapplied manually.

You can verify yuor power settings by typing in terminal `sudo pmset -g live` . If you ever want to reset these settings: `sudo pmset -a restoredefaults`


## USB port mapping

Proper `SSDT-UIAC.aml` and `SSDT-USBX.aml` are used for USB Host Controller (XHCI-Device-ID: `<2f 9d 00 00>`): these files are configured to map only the necessary ports (tested with IOReg) with the correct connector type and prevent it from shutdown issues.

| Port      | Address               | Physical Location                                         | Internal/External |
| :--- | :--- | :--- | :--- |
| HS01/SS01 | `00000001`/`0000000D` | Left Port type-C (Power Source) - next to 3.5mm jack port | E                 |
| HS02/SS02 | `00000002`/`0000000E` | Right Port type-A                                         | E                 |
| HS03      | `00000003`            | Left Port type-C Thunderbolt                              | E                 |
| HS05      | `00000005`            | Bluetooth USB Port                                        | I                 |
| HS07      | `00000007`            | Integrated HD Camera module                               | I                 |

## Optional

#### Monitor temperatures and power consumption with [HWMonitor](https://github.com/kzlekk/HWSensors/releases) 

This app is relatively old and no longer supported, but it gets the job done.

#### Make dock animation faster and without delay
Run these lines in terminal:
```
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5
killall Dock
```

## Update tracker

| Item | Version |
| :--- | :--- |
| MacOS | 10.14.6 |
| [Clover](https://github.com/CloverHackyColor/CloverBootloader/releases) | 5103 |
| [Lilu](https://github.com/acidanthera/Lilu/releases) | 1.4.3 |
| [WhateverGreen](https://github.com/acidanthera/whatevergreen/releases) | 1.3.8 |
| [AppleALC](https://github.com/acidanthera/AppleALC/releases) | 1.4.8 |
| [CodecCommander](https://github.com/Sniki/EAPD-Codec-Commander/releases) | 2.7.2 |
| [CPUFriend](https://github.com/acidanthera/CPUFriend/releases) | 1.2.0 |
| [USBInjectAll](https://github.com/Sniki/OS-X-USB-Inject-All/releases) | 0.7.3 |
| [VoodooI2C](https://github.com/acidanthera/VoodooInput/releases) | 2.4 |
| [VoodooI2CHID](https://github.com/acidanthera/VoodooInput/releases) | 2.4 |
| [VoodooPS2Controller](https://github.com/acidanthera/VoodooPS2/releases) | 2.1.3 |
| [VirtualSMC](https://github.com/acidanthera/VirtualSMC/releases) | 1.1.2 |
| NullEthernet | 1.0.6 |
| [NoTouchID](https://github.com/al3xtjames/NoTouchID/releases) | 1.0.3 |
| [HibernationFixup](https://github.com/acidanthera/HibernationFixup/releases) | 1.3.2 |
| [NVMeFix](https://github.com/acidanthera/NVMeFix/releases) | 1.0.2 |
| [IntelBluetoothFirmware](https://github.com/zxystd/IntelBluetoothFirmware) | 1.0.3 |






