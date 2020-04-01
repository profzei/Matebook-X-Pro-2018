# Huawei Matebook X Pro (2018 Edition)
[![release](https://img.shields.io/badge/download-release-blue.svg)](https://github.com/profzei/Matebook-X-Pro-2018/releases) [![wiki](https://img.shields.io/badge/support-wiki-green.svg)](https://github.com/profzei/Matebook-X-Pro-2018/wiki)

macOS on Huawei Matebook X Pro 2018
![Alt text](https://ivanov-audio.com/wp-content/uploads/2014/01/Hackintosh-Featured-Image.png)

This repo is currently compatible with macOS Mojave 10.14.6 (18G87)


## Configuration

| Specifications      | Details                                                       |
| ------------------- | --------------------------------------------------------------|
| Computer model      | Huawei Matebook X Pro 2018 Space Gray                         |
| Processor           | Intel Core i7-8550U Processor @ 1.8 GHz                       |
| Memory              | 8 GB LPDDR3 2133 MHz                                          |
| Hard Disk           | LiteON SSD PCIe NVMe 512 GB                                   |
| Integrated Graphics | NVIDIA GeForce MX150 with 2 GB GDDR5 / Intel UHD Graphics 620 |
| Screen              | JDI 3k Display @ 3000 x 2000 (13.9 inch)                      |
| Sound Card          | Realtek ALC295 ???                                            |
| Wireless Card       | Intel Dual Band Wireless-AC 8265-8275                         |
| Bluetooth Card      | Intel Bluetooth 8265-8275                                     |

This repository is for personal purposes: it is heavily based on the hard work done by [gnodipac886](https://github.com/gnodipac886/MatebookXPro-hackintosh), but with some significant personal improvements in `CLOVER/ACPI/patched` and `CLOVER/kexts/Other` sections.


Changelog:   	see [Changelog.md](https://github.com/profzei/Matebook-X-Pro-2018/blob/master/Changelog.md)


## Device Firmware
- Bios version: `1.28`

## Bootloader Firmware
- Default bootloader: Clover `r5103` [Dids release](https://github.com/Dids/clover-builder/releases)

## SMBIOS
- Default SMBIOS settings of this repo is `MacBookPro14,1`

##CPUFriend
- The kexts and SSDT for `i7-8550U` are [here](https://github.com/profzei/Matebook-X-Pro-2018/tree/master/CPUFriend/1.2.0).
- `CPUFriendDataProvider.kext` is generated for SMBIOS `MacBookPro15,2` because of Kaby Lake R architecture.
- `CPUFriend.kext` and `CPUFriendDataProvider.kext` need to be put in `CLOVER/kexts/Other`
- Furthermore, you also need to put `SSDT-XCPM.aml` in `CLOVER/ACPI/patched` for working as normal after awake.


