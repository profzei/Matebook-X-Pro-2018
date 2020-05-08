# Huawei Matebook X Pro (2018) Changelog

English

- 05-08-2020
    - Update `Clover` v. 5116
    - Update [kext] `Lilu` v. 1.4.4
    - Update [kext] `WhateverGreen` v. 1.3.9
    - Update [kext] `AppleALC` v. 1.4.9
    - Update [kext] `VoodooI2C` v. 2.4.2
    - Update [kext] `VoodooI2CHID` v. 2.4.2
    - Update [kext] `VoodooPS2Controller` v. 2.1.4
    - Update [kext] `VirtualSMC` and related plugins v. 1.1.3
    - Update [kext] `HibernationFixup` v. 1.3.3


- 05-05-2020
    - Add `config-catalina.plist` for supporting macOS Catalina
    - Modified [config] Boot arg from `darkwake=1` to `darkwake=4`
    - Applied `Security Update 2020-002 Mojave` flawlessy. See [here](https://support.apple.com/en-gb/HT211100)

- 05-02-2020
	- Add `SSDT-RMCF.aml` since `SSDT-PNLF.aml` and `SSDT-PTSWAK.aml` are using Rehabman's approach with `RMCF` device and relative method

- 04-29-2020
    - Update `Clover` v. 5115
    - Update `Readme` with Fix AppleID for Catalina
    - Remove `SSDT-ALS0.aml`: since native `ALSD` Ambient Light Sensore Device works properly there's no need for a fake one
    - Improved `SSDT-DDGPU.aml` in `SSDT-DDGPU-Optimus.aml`: discrete gpu is disabled with Optimus method (Bumblee method has been also tested but with poor results)
    - Improved `SSDT-PTSWAK.aml` in `SSDT-PTSWAK-Optimus.aml` to pair with `SSDT-DDGPU-Optimus.aml`
    - Add `SSDT-BATT-HUAWEI.aml` for a better native support for Huawei Matebook X Pro battery
    - Add [config] 18 binary patches to pair `SSDT-BATT-HUAWEI.aml` 

- 04-13-2020
    - Update `Readme` with Development section for Catalina 10.15.4
    - Remove [config] binary patch `XHC1 to XHC` for USB ports
    - Change [config] from binary patch `Method(_WAK,1,N) to ZWAK` to `Method(_WAK,1,S) to ZWAK`: "Zero ACPI Error" messages during boot process achieved

- 04-12-2020
    - Remove [config] the `IOGraphicsFamily.kext` `ForceKextsToLoad` patch because `VoodooI2C` v2.4 fix the issue
    - Update [config] `Device`-`Properties` section for `AAPL,ig-platform-id`: `00001659` (no more graphical glitches during boot process from 1st to 2nd stage phase)
    - Update [config] `Device`-`Properties` section for `device-id`: `16590000` (same as above)
    - Update `Readme` with Graphics section

- 04-10-2020
    - Applied [config] binary patch `EC0 to EC` according to [khronokernel guide](https://github.com/khronokernel/Getting-Started-With-ACPI/blob/master/Laptops/laptop-ec.md)
    - Remove `SSDT-EC-USBX.aml` since there is no need for a fake EC device in Mojave laptop configuration
    - Add `SSDT-USBX.aml` to enable USB power properties via USBX device (formerly in `SSDT-EC-USBX.aml`)
    - Update `SSDT-FnKey.aml` applying `EC0 to EC` patch
    - Revert [kext] `CodecCommander` v. 2.7.1 to [RehabMan old version](https://bitbucket.org/RehabMan/os-x-eapd-codec-commander/downloads/) instead of Sniki's fork for a better compatibility with Mojave

- 04-09-2020
    - Update [kext] `Lilu` v. 1.4.3
    - Update [kext] `WhateverGreen` v. 1.3.8
    - Update [kext] `AppleALC` v. 1.4.8
    - Update [kext] `CodecCommander` v. 2.7.2
    - Update [kext] `USBInjectAll` v. 0.7.3 ([Sniki's fork](https://github.com/Sniki/OS-X-USB-Inject-All/releases))
    - Update [kext] `VoodooI2C` v. 2.4, support trackpad in Recovery mode
    - Update [kext] `VoodooI2CHID` v. 2.4
    - Update [kext] `VoodooPS2Controller` v. 2.1.3
    - Update [kext] `VirtualSMC` and related plugins v. 1.1.2
    - Update [kext] `HibernationFixup` v. 1.3.2
    - Update [kext] `NVMeFix` v. 1.0.2
    - Update [kext] `IntelBluetoothFirmware` v. 1.0.3
    - Update `SSDT-XOSI.aml` according to [Sniki's fork](https://github.com/Sniki/OS-X-USB-Inject-All/releases)
    - Update `SSDT-MEM2.aml` removing `GFX0 to IGPU` patch
    - Update `SSDT-PNLF.aml` removing `GFX0 to IGPU` patch
    - Update `Readme`
    - Remove [config] `AppleIntelLpssI2C` patches because [alexandred](https://github.com/alexandred/VoodooI2C/commit/c6e3c278cda84a26f400a77f5ea57d819df9e405) solved the race problem
    - Remove [config] binary patch `GFX0 to IGPU` to improve graphics stability with WhateverGreen
    - Remove [config] binary patch `HECI to IMEI` to improve graphics stability with WhateverGreen
    - Remove [config] binary patch `HDAS to HDEF` to improve graphics stability with WhateverGreen

- 04-01-2020
    - Add `SSDT-ALS0.aml`
    - Add `SSDT-DeepIdle.aml`
    - Add `SSDT-FnKey.aml` for brightness FN Keys
    - Add `SSDT-HRT.aml`
    - Add `SSDT-TB3HP.aml`
    - Add `CPUFriend` folder 
    - Add `SSDT` folder for storing `*.dsl` files
    - Update [conservative] `SSDT-DDGPU.aml` (work in progress)
    - Update `SSDT-EC-USBX.aml` to fix regression to control brightness FN keys
    - Update `SSDT-MEM2.aml` for patch `GFX0 to IGPU`
    - Update `SSDT-PNLF.aml` to allow brightness dimmer [credit to Chatbox1024]
    - Update [conservative] `SSDT-PTSWAK.aml` (work in progress)
    - Update `SSDT-XCPM.aml` to improve `cf-frequency-data` section for CPU `i7-8550U`
    - Update `CPUFriendDataProvider.kext` to control CPU frequency to 0.8 GHz
    - Update `Readme`


- 03-15-2020
	
	- More detailed comments in `*.dsl` files
	- Update `Readme.md`
	- Modified `Changelog.md` structure


- 03-14-2020
    
    - Add `SSDT-DMAC.aml`
    - Add `SSDT-MCHC.aml`
    - Add `SSDT-MEM2.aml`
    - Add `SSDT-PMCR.aml`
    - Add `SSDT-SLPB.aml`
    - Add `SSDT-SBUS.aml`
    - Improved `SSDT-DDGPU.aml`
    - Improved `SSDT-EC-USBX.aml`
    - Improved `SSDT-GPRW.aml`
    - Improved `SSDT-RMNE.aml`


- 03-13-2020
    
    - Initial commit