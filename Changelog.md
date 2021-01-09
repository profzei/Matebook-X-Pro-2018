# Huawei Matebook X Pro (2018) Changelog

English
- **09-01-2021**

    **Update**
    - Update [kext] stripped `AirportItlwm_Big_Sur` v. 1.2.0 beta (commit 040a5e8)
    - Update [kext] stripped `AirportItlwm_Catalina` v. 1.2.0 beta (commit 040a5e8)

- **08-01-2021**

    **Update**
    - Update `OpenCore` v. 0.6.5
    - Update OpenCanopy theme fixing some warnings shown only by OC Debug version

    **OpenCore**
    - Update `config.plist` to support OpenCore v. 0.6.5:
        - Add `Misc -> Boot -> PickerVariant` set to `Auto` (for selecting custom icon set)
        - Add `UEFI -> Audio -> SetupDelay` set to `0`
        - Delete `UEFI -> Quirks -> DeduplicateBootOrder` key
    
- **07-01-2021**

    **Update**
    - Add `SSDT-BIOS.aml` (testing) which defines a new `_QBF,0,N` method (i.e. referred to `EC0`) found in original HUAWEI BIOS v. 1.33:
        - it's the only difference from HUAWEI BIOS v. 1.28 (supported atm in this repo) or v. 1.30
        - according to [this post in Reddit r/MatebookXPro](https://www.reddit.com/r/MatebookXPro/comments/kksexv/matebook_x_pro_bios_version_133_released_12242020/gh5jpkm?utm_source=share&utm_medium=web2x&context=3) MBXP's overheat when plugged in (reported by some users in the same sub r/MatebookXPro) should be fixed or at least improved
    - Restructing actual configuration for repo:
        - Delete `BOOT` folder (outdated to OpenCore v. 0.6.3)
        - Delete `OC` folder (outdated to OpenCore v. 0.6.3)
        - Update `Readme` accordingly

- **01-06-2021**

    **Update**
    - Update [kext] `WhateverGreen` v. 1.4.6
    - Update [kext] `AppleALC` v. 1.5.6
    - Update [kext] `CPUFriend` v. 1.2.3
    - Update [kext] `HibernationFixup` v. 1.3.9
    - Update [kext] `NVMeFix` v. 1.0.5
    - Update [kext] `RestrictEvents` v. 1.0.0

- **01-04-2021**

    **Update**
    - Update `SSDT-PS2K.aml`: better way to remap Cmd and Option keys

- **01-03-2021**

    **Update**
    - Update [kext] stripped `AirportItlwm_Big_Sur` v. 1.2.0 beta (commit 3f244c8)
    - Update [kext] stripped `AirportItlwm_Catalina` v. 1.2.0 beta (commit 3f244c8)
    - Update `SSDT-XHC.aml`: fixed loading for Intel(R) Bluetooth device
    - Add `SSDT-ARPT.aml` for OSX-native ACPI-interface for (Airport) WiFi-cards

- **01-02-2021**

    **Update**
    - Update `SSDT-XHC.aml` adding `_STA,0,N` method

    **OpenCore**
    - Update [config] `DeviceProperties -> Add` section for PCI devices:
        - cleaning info removing `name` property
        - injecting `ThunderboltUUID` property for Intel(R) JHL6240 Thunderbolt 3 Bridge [Alpine Ridge LP 2016] device

- **01-01-2021**

    **Update**
    - Update `SSDT-BAT0-HUAWEI.aml`:
        - support for Battery Information Supplement implementing `BAT0.CBIS,0,N` and `BAT0.CBSS,0,N` methods
        - splitting for some EC fields (respectively `B0TM`, `B0C1`, `B0CV`)

    Sidenote for Bluetooth (loading) issue: according to [stevezhengshiqi's opinion](https://github.com/daliansky/XiaoMi-Pro-Hackintosh/issues/522#issuecomment-753402849) it could be a driver issue from IntelBluetoothFirmware. A simple way to fix it could be a boot script (not a login script) powering down and then powering up BT device (script already written: only need for testing it) 

    Sidenote for Thunderbolt support: full TB support might be tricky as MateBook X Pro (2018) only has one TB-port and seems to be missing the usual switch between ports. Didn't look into it too much but it may be actually impossible to get it fully working (at least a better power management is achieved). 

- **31-12-2020**

    - Debugging work:
        - debug some `_Qxx` EC methods related to AC plugging in actions (`SSDT-DBG.aml`)
        - debug some EC fields deducing their role (`SSDT-DBG.aml`)

- **30-12-2020**
    
    **OpenCore**
    - Add [config] for Intel(R) UHD Graphics 620 the property `AAPL00,override-no-connect` (EDID obtained from Linux)
    - Add [config] `RP09._INI,0,N to XINI,0,N` binary patch for disabling ICM (Integrated Connection Manager) for Thunderbolt support

- **29-12-2020**

    **Update**
    - Add more native Thunderbolt support (not only the previous PCIe-to-PCIe bridge mode):
        - native macOS drivers without patched Thunderbolt firmware (wip...)
        - slightly improved power management for Thunderbolt controller (wip...)
    - Update `SSDT-INIT.aml` for initializing Thunderbolt controller
    - Rename `SSDT-EC-USBX.aml` to `SSDT-EC.aml` removing USB power injection
    - Add `SSDT-XHC.aml` for native ACPI-implementation of USB 2.0/3.0 (only useful USB ports are active) and relative USB power injection
    - Remove `SSDT-UIAC.aml` (because of native ACPI-implementation for USB)
    - Remove [kext] `USBInjectALL` (because of native ACPI-implementation for USB) 

    **OpenCore**
    - Add [config] `_UPC,0,N to XUPC,0,N` binary patch (for USB support)
    - Add [config] `_GPE.NTFY,1,S to XTFY,1,S` binary patch (for Thunderbolt support)

    The new Thunderbolt implementation is compatible with native macOS support for proper automatic sleep (`hibernatemode 3`) and hibernation (`hibernatemode 25`). This work is largely untested since I didn't have Thunderbolt devices! Anyway it should be better than previous support (at least for power management!)
    
    The native ACPI-implementation for USB has revealed another (?) bug of our DSDT i.e. Bluetooth device is properly recognized at boot-time but it needs a toggle off/on cycle to be "active" (i.e. turned on): further investigation needed but probably a login script for toggle off/on Bluetooth device needed to be implemented (wip...)

- **26-12-2020**

    **Update**
    - Update [kext] stripped `AirportItlwm_Big_Sur` v. 1.2.0 beta (commit eeebc4c)
    - Update [kext] stripped `AirportItlwm_Catalina` v. 1.2.0 beta (commit eeebc4c)
    - Update [kext] `VoltageShift` v. 1.25 (from v. 1.22 modified version)
    - Update `SSDT-AC0.aml` for storing in `PWRS` variable updated state for `EC0.ACAP` method (call in `_PSR` Method)
    - Update `SSDT-EC-USBX.aml` modifying `EC0.ECAV` method (removing call to `_REV>=0x02`)
    - Update `SSDT-PTSWAK-SLEEP.aml` fixing type for `SS3` (from `FieldUnitObj` to `IntObj`)
    - Rename `SSDT-BATT-HUAWEI.aml` to `SSDT-BAT0-HUAWEI.aml` modifying `BAT0._STA` and `EC0._REG` methods (updating `LIDS` and `PWRS` status variables)
    - Add [kext] `RestrictEvents` (commit 5f5f4bf) to replace `EFICheckDisabler`
    - Add `SSDT-LID.aml` for updating `LIDS` variable with LID status
    - Add `SSDT-NVME.aml` for handling NVMe SSD (injected properties to mimic MacbookPro14,1)
    - Add `SSDT-TPL1.aml` for re-enabling GPI0 pinning for touchpad
    - Remove [kext] `EFICheckDisabler`
    - Remove `SSDT-TB3HP.aml` (`Enabled` key set to `false` value) for better automatic sleep support: wip... more tests needed

    **OpenCore**
    - Add [config] support for managing in `Kernel -> Add` section `RestrictEvents.kext`
    - Add [config] `AC0._PSR,0,N to AC0.XPSR,0,N` binary patch
    - Add [config] `EC0.ECAV,0,N to EC0.XCAV,0,N` binary patch
    - Add [config] `LID._LID,0,N to LID.XLID,0,N` binary patch
    - Add [config] `EC0._Q81,0,N to EC0.XQ81,0,N` binary patch
    - Add [config] `BAT0._STA,0,N to BAT0.XSTA,0,N` binary patch
    - Add [config] `EC0._REG,2,N to EC0.XREG,2,N` binary patch
    - Remove [config] all entries in `NVRAM -> Add -> 7C436110-AB2A-4BBB-A880-FE41995C9F82 -> boot-args` except for `-igfxnorpsc=1` (for Intel UHD620) and `itlwm_cc=IT` (for `AirportItlwm` country code support)
    - Remove [config] `acpi-wake-type` entry from `Pci(0x14, 0x0)` USB Controller

    For supporting full auto sleep mode (i.e. macOS default `hibernatemode 3`) atm two key steps are needed:
    - removing hot-plug for Thunderbolt devices (managed by `SSDT-TB3HP.aml`)
    - setting in macOS menubar `Soundflower (2ch)` to `None` as default settings instead of `Multi-Output Device` (this means that you need to manually set `Multi-Output Device` when it is necessary)

    The latter step is needed since Soundflower maintains an open audio channel even when no audio is playing (for reference see [Soundflower prevents screen saver, display and comptuer sleep #179](https://github.com/feniix/soundflower/issues/179#issuecomment-581544566))

- **25-12-2020**

    **Update**
    - Update `SSDT-RMNE.aml` removing ADR value
    - Remove `SSDT-HPET.aml` (`HPTE` initialization in `SSDT-INIT.aml`)
    - New script for automatic and recursive compiling `.dsl` to `.aml` file format for `SSDT` hotpatches
    - Use stable ASL+ Optimizing Compiler/disassembler version 20200528

- **20-12-2020**
    
    **Update**
    - Restructing actual configuration for repo:
        - Delete `CLOVER` folder since no more supported
        - Delete `SSDT` folder
        - Update `Readme` accordingly
    - Update [kext] stripped `AirportItlwm_Big_Sur` v. 1.2.0 beta (commit 4133528) for testing tx aggregation
    - Update [kext] stripped `AirportItlwm_Catalina` v. 1.2.0 beta (commit 4133528) for testing tx aggregation

    **OpenCore**
    - Update `config.plist` to improve support for booting Windows from OpenCanopy GUI loading default OEM information (long term testing needed):
        - `Kernel -> Quirks -> CustomSMBIOSGuid` set to `true` (previous value `false`)
        - `PlatformInfo -> UpdateSMBIOSMode` set to `Custom` (previous value `Create`)
    - Fixed `MAT Support is 1` issue caused by our buggy firmware (atm firmware release for this repo is 1.28):
        - `Booter -> Quirks -> DevirtualiseMmio` set to `true` (previous value `false`)
        - `Booter -> Quirks -> EnableWriteUnprotector` set to `false` (previous value `true`)
        - `Booter -> Quirks -> ProvideCustomSlide` set to `false` (previous value `true`) since all slides are usable therefore this quirk can be disabled
        - `Booter -> Quirks -> RebuildAppleMemoryMap` set to `true` (previous value `false`)
        - `Booter -> Quirks -> SyncRuntimePermissions` set to `true` (previous value `true`)
    - Changed priority order for loading kexts
    - Update `config.plist` using (for testing purpouses) the custom boot-args `itlwm_cc=IT` to use my country code IT-Italy
    
- **14-12-2020**

    Update to macOS Big Sur 11.1 (20C69)
    - Checking/rewriting some ACPI SSDTs: wip...
    - Restructuring repository: wip...
    - Re-enabling [kext] `SMCBatteryManager` for testing purpouses
    - Disabling [kext] `ACPIBatteryManager`

- **12-10-2020**

    **Update**
    - Update `OpenCore` v. 0.6.4
    - Update [kext] stripped `AirportItlwm_Big_Sur` v. 1.2.0 beta (commit c2f2c51)
    - Update [kext] stripped `AirportItlwm_Catalina` v. 1.2.0 beta (commit c2f2c51)
    - Update [kext] `AppleALC` v. 1.5.5
    - Update [kext] `HibernationFixup` v. 1.3.8
    - Update [kext] stripped `IntelBluetoothFirmware` v. 1.1.2 (commit 16bc609)
    - Update [kext] `Lilu` v. 1.5.0
    - Update [kext] `VirtualSMC` + plugins v. 1.1.9
    - Update [kext] `VoodooPS2Controller` v. 2.1.9
    - Update [kext] `WhateverGreen` v. 1.4.5
    - Update `SSDT-KBD.aml` for handling only (atm) `Fn` brightness keys
    - Update `SSDT-PTSWAK-SLEEP.aml` removing ACPI-S0 support

    **OpenCore**
    - Update `config.plist` to support OpenCore v. 0.6.4:
        - Add `Booter -> Patch` section
        - `Booter -> Quirks -> AllowRelocationBlock` set to `false`
        - `Misc -> Security -> BlacklistAppleUpdate` set to `true`
        - `UEFI -> Audio -> PlayChime` from boolean to string type (value set to `Enabled`)
    - Add [config] `TPD0._STA,0,N to TPD0.XSTA,0,N` binary patch
    - Add `SSDT-DTPD.aml` for disabling Touchscreen and therefore fixing touchpad issue after sleeping (this was necessary since `Multi_GPIO` support for `VoodooI2C` v. 2.5.2 seems to be bugged)
    - Add `SSDT-PS2K.aml` for swapping Command and Option keys in default (if not needed, please, set to `false` the variable `Enabled` for `SSDT-PS2K` in `ACPI -> Add` section)

- **11-17-2020**

	Initial support for macOS Big Sur 11.0.1
	
	**Update**
	- Update [kext] stripped `AirportItlwm_Catalina` v. 1.2.0 beta (6b22398)
	- Update [kext] stripped `AirportItlwm_Big_Sur` v. 1.2.0 beta (6b22398)

    **OpenCore**
    - `Booter -> Quirks -> SyncRuntimePermissions` set to `true` value (conservative approach)
    - Add [config] support for managing in `Kernel -> Add` section both `AirportItlwm_Big_Sur.kext` and `AirportItlwm_Catalina.kext`
    - Re-enabled [config] loading for `IntelBluetoothInjector.kext` for macOS Big Sur

- **11-16-2020**

    **Update**

    A lot of work has been developed under the hood to try to mimic the behavior of a real MacbookPro: it seems to me that the system is stable (all checks atm have been performed on Catalina 10.15.7 Supplemental Update which is taken as reference). Most of the patches in the ACPI section have been rewritten from scratch:
    - Add `SSDT-AC0.aml`: updated version of `SSDT-ADP1.aml` for patching AC-Device so that AppleACPIACAdapter-driver loads
    - Add `SSDT-INIT.aml`: patch for initializing some global variables
    - Add `SSDT-DDGPU.aml`: updated version of `SSDT-DDGPU-Optimus2.aml` for removing discrete GPU
    - Add `SSDT-KBD.aml`: updated version of `SSDT-FnKey2.aml`
    - Add `SSDT-PM.aml`: unique patch for fixing power management
    - Add `SSDT-PTSWAK-SLEEP.aml`: totally reworked patch for handling not only sleep/wake-up process but also for proper updating AC-state and lid-status
    - Add `SSDT-SHARE.aml`: patch for handling common utils for other SSDTs
    - Add `SSDT-VDEV.aml`: unique patch for handling virtual devices for macOS compatibility (DMAC, MCHC, MEM2, BUS0)
    - Update `SSDT-BATT-HUAWEI.aml`
    - Update `SSDT-EC-USBX.aml`
    - Update `SSDT-PNLF.aml`
    - Update `SSDT-PWRB.aml`
    - Remove `SSDT-DMAC.aml`
    - Remove `SSDT-DTPG.aml`
    - Remove `SSDT-MCHC.aml`
    - Remove `SSDT-MEM2.aml`
    - Remove `SSDT-PLUG-PR.PR00.aml`
    - Remove `SSDT-PMCR.aml`
    - Remove `SSDT-PTSWAK-Optimus2.aml`
    - Remove `SSDT-RMCF.aml` (pair with `SSDT-PTSWAK-Optimus2.aml`)
    - Remove `SSDT-SBUS.aml`
    - Remove `SSDT-TPXX.aml`
    	
    Analyzing OEM SSDTs, I found 3 critical errors on the ACPI setup under `SSDT-7-KBL-ULT.aml` (sensor hub). I report here in the following for my memory: there are 3 big screwups on methods (`\_SB.SGOV`) that require two arguments, being passed as a method (`\_SB.GGOV`) with one argument and then a "hanging" argument which then causes compilation errors.
    
    Correcting instances like:
    - `\_SB.SGOV (0x02010016, OLDV)`
    - `\_SB.SGOV (0x02010014, DFUE)`
    - `\_SB.SGOV (0x02010014, OLDV)`

    should let the board to handle power correctly.
    Therefore original `SSDT-7-KBL-ULT.aml` has been dropped from loading process (its entry added in `config.plist` in `ACPI -> Delete` section) in favour of its modified version `SSDT-7KBL.aml`

    **OpenCore**
    - Add [config] `PCI0._INI,0,S to PCI0.XINI,0,S` binary patch
    - Add [config] `HPET._CRS to HPET.XCRS` standard binary patch
    - Add [config] `RTC IRQ 8` standard binary patch
    - Add [config] `TIMR IRQ 0` standard binary patch
    - Remove [config] `AC0_ to ADP1` binary patch
    - Remove [config] `TPD0._STA,0,N to TPD0.XSTA,0,N` binary patch
    - Remove [config] `TPL1._STA,0,N to TPL1.XSTA,0,N` binary patch

- **11-12-2020**

    **Update**
    - Update `OpenCore` v. 0.6.3

    **OpenCore**
    - Update `config.plist` to support OpenCore v. 0.6.3:
        - `Kernel -> Quirks -> ForceSecureBootScheme` set to `false`
        - `Kernel -> Quirks -> LegacyCommpage` set to `false`
        - `PlatformInfo -> CustomMemory` set to `false`
        - `UEFI -> Output -> ForceResolution` set to `false`
    - [config] Disable `IntelBluetoothInjector` entry in `Kernel -> Add` section for macOS 11+ to resume boot speed
    - [config] Remove `itlwm` entry in `Kernel -> Add` section in favour of `AirportItlwm` to support native Intel(R) Wi-Fi card as default option
    - [config] Disable `NoTouchID` entry in `Kernel -> Add` section: this kext seems not needed anymore for avoiding lag before password verification on Catalina 10.15.7 & Big Sur 11.0.1 
    - [config] Remove `AAPL, slot-name` info in `DeviceProperties -> Add` section to support HEVC on macOS 11+

- **11-11-2020**
	
	**Update**
	- Update [kext] `AppleALC` v. 1.5.4
	- Update [kext] `HibernationFixup` v. 1.3.7
	- Update [kext] `Lilu` v. 1.4.9
	- Update [kext] `VirtualSMC` and plugins v. 1.1.8
	- Update [kext] `VoodooPS2Controller` v. 2.1.8
	- Update [kext] `WhateverGreen` v. 1.4.4

- **11-10-2020**

	Fixed `HardDrive.icns` icon in custom graphics for OpenCanopy GUI [credit to **@R-Teer**]

- **11-06-2020**
	
	**Update**
    - A cleaner version of OpenCanopy with custom graphics has been provided by **@R-Teer**:
		- better icon spacing and readability
		- added new T2 chip boot chime with better bass and key change from legacy chime
		- optimized image file sizes for some resources
    - This can be enabled by configuring in `config.plist`:
        - `Security -> BootProtect -> Bootstrap` (previous value: `None`)
    	- add `Drivers -> OpenCanopy.efi` entry
		- `Misc -> Boot -> PickerMode: External` (previous value: `Builtin`)
		- `Misc -> Boot -> PickerAttributes : 1`
		- [Optional] you can set `Misc -> Boot -> HideAuxiliary: true` also: auxiliary options can be viewed then using spacebar during picker screen

	Support for macOS Catalina 10.15.7 Supplemental Update (19H15)
	
    Support for Big Sur Beta 11.0.1 Release Candidate (20B5022a)

- **11-01-2020**

	**Update**
	- Update `SSDT-BATT-HUAWEI.aml` to improve memory management for Embedded Controller (`EC0_`)
	- Update [kext] `IntelBluetoothFirmware` optimizing its size from 15-16 MB to 644 KB
	- Remove [kext] `itlwm` using `AirportItlwm` as default option

	**OpenCore**
    - Add [kext] `AirportItlwm` v. 1.2.0-alpha ([4f88bea](https://github.com/OpenIntelWireless/itlwm/commit/4f88beaaef2ff82481476361c8d2da00ca50046c)) reducing its size from 10-11 MB to 2 MB
    - Add [config] 4 binary patch in ACPI section to pair `SSDT-BATT-HUAWEI.aml`:
        - `EC0.SMBR to EC0.XMBR`
        - `EC0.SMBW to EC0.XMBW`
        - `EC0.SMR1 to EC0.XMR1`
        - `EC0.SMW1 to EC0.XMW1`
    - Update [config] quirks for enabling proper support for `AirportItlwm` in `config.plist` for macOS Catalina (for more details see [`Network`](https://github.com/profzei/Matebook-X-Pro-2018/tree/master/Network) section):
    	- `DmgLoading` set to `Signed`
    	- `SecureBootModel` set to `Default`
    	- enabled forced loading for `IO80211Family`

- **10-28-2020**

    Support for Big Sur Beta 11.0.1 (20B5012d): wip for renewed ACPI support...

- **10-23-2020**

    **Update**
    - Update [kext] `USBInjectAll` v. 0.7.6
    
    Update [`Network`](https://github.com/profzei/Matebook-X-Pro-2018/tree/master/Network) section with new instructions for modifying `HeliPort menubar icon` for **macOS Big Sur** [credit **@R-Teer**]

- **10-18-2020**

    - Add a new repository for BIOS
    - Support for Big Sur Beta 10 (20A5395g): wip for renewed ACPI support...

- **10-12-2020**

    **Update**
    - Update `OpenCore` v. 0.6.2
    - Update [kext] `AppleALC` v. 1.5.3
    - Update [kext] `CPUFriend` v. 1.2.2
    - Update [kext] `HibernationFixup` v. 1.3.6
    - Update [kext] `Lilu` v. 1.4.8
    - Update [kext] `NVMeFix` v. 1.0.4
    - Update [kext] `VirtualSMC` and plugins v. 1.1.7
    - Update [kext] `VoodooI2C` v. 2.5.2
    - Update [kext] `VoodooI2CHID` v. 2.5.2
    - Update [kext] `VoodooPS2Controller` v. 2.1.7
    - Update [kext] `WhateverGreen` v. 1.4.3
    - Update `SSDT-ADP1.aml` to improve Power Resources for Wake-up
    - Update `SSDT-TPXX.aml` to fix bus speed (`SSCN` and `FMCN` methods)

    **OpenCore**
    - Update `config.plist` to support OpenCore v. 0.6.2
    - Add [kext] `VoltageShift` v. 1.22 for undervolting support
    
- **10-10-2020**

    Add a new section in [Wiki](https://github.com/profzei/Matebook-X-Pro-2018/wiki/Undervolt-via-VoltageShift) for **undervolting** our MBXP: it is possible to use `VoltageShift` from the **EFI folder** instead of disabling SIP. At the moment support only for Catalina!

- **10-06-2020**

    Add a new section in [Wiki](https://github.com/profzei/Matebook-X-Pro-2018/wiki/Activate-Surround-Sound-via-MIDI-on-internal-speakers) for activating **surround sound** via MIDI on internal speakers with support for **native audio shortcuts**

- **10-04-2020**

    **Update**
    - Update `SSDT-FnKey.aml` for switching Command - Option keys

    **OpenCore**
    - Update `config.plist` to support OpenCore v. 0.6.2

- **09-30-2020**

    - Support for Big Sur Beta 9 (20A5384c)
    - Added macOS Boot chime support: disabled by default, set `PlayChime` and `AudioSupport` to `True` if you want it. Also, be sure to add `AudioDxe.efi` to `Drivers` section inside `config.plist` to enable sound support on bootpicker. Boot chime was upsampled by @tylernguyen using Audacity: this upsampled file will be used until `AudioDxe.efi` can upsample audio on the fly.

- **09-25-2020**

    Update to macOS Catalina 10.15.7 (19H2)

- **09-23-2020**

    Support for Big Sur Beta 8 (20A5374i)

- **09-21-2020**

    **Update**
    - Update `SSDT-EC-USBX.aml`: improved ACPI Darwin detection in `USBX` device

- **09-20-2020**

    **Update**
    - Update [`Network`](https://github.com/profzei/Matebook-X-Pro-2018/tree/master/Network) section with new instructions for `AirportItlwm` using `OC Force` (i.e. forcing injection of `IO80211Family.kext`)

    **OpenCore**
    - Update [config] `Force` section with `IO80211Family.kext` code to support proper loading for `AirportItlwm`
    
- **09-19-2020**

    **OpenCore**
    - Update `config.plist` to support OpenCore v. 0.6.2

- **09-18-2020**

	**Update**
	- Update [kext] `itlwm` v. 1.1.0 stable
	- Update [`Network`](https://github.com/profzei/Matebook-X-Pro-2018/tree/master/Network) section for supporting `AirportItlwm` beta

	**OpenCore**
	- Update `config.plist` to support `AirportItlwm` beta
	- Add [kext] `AirportItlwm` beta

- **09-15-2020**

    **Update**
    - Add `SSDT-PWRB.aml` for enabling Power Button Device: just press down for 1-2 seconds to shown `Shut Down Dialog`

    **OpenCore**
    - Add [config] 1 binary patch in ACPI section to pair `SSDT-PWRB.aml`:
        - `PWRB._STA to PWRB.XSTA`

- **09-13-2020**

    **Update**
    - Update `OpenCore` v. 0.6.1
    - Update [kext] `Lilu` v. 1.4.7
    - Update [kext] `VirtualSMC` and plugins v. 1.1.6
    - Update [kext] `AppleALC` v. 1.5.2
    - Update [kext] `WhateverGreen` v. 1.4.2
    - Update `SSDT-TPXX.aml` with a better approach for GPI0 pinning (issue [#46 ](https://github.com/profzei/Matebook-X-Pro-2018/issues/46) **still unresolved**! ...wip)

    **OpenCore**
    - Update `config.plist` to support `OpenCore` v. 0.6.1
    - Add [config] 2 binary patches in ACPI section to pair `SSDT-TPXX.aml`:
        - `TPD0._STA to TPD0.XSTA` for touchscreen
        - `TPL1._STA to TPL1.XSTA` for touchpad
    - Add [kext] `EFICheckDisabler`
    - Add [kext] `HibernationFixup` v. 1.3.5
    - Add [kext] `itlwm` v. 1.0.0 stable (enabled by default)

    This release is compatible also with macOS **Big Sur Beta 6**

- **08-27-2020**

    **OpenCore**
    - Update `config.plist` to support `OpenCore` v. 0.6.1

- **08-22-2020**

	**OpenCore**
	- Update `config.plist` to support `OpenCore` v. 0.6.1

    **Update**
    - Updated support for macOS Big Sur Beta 5 (20A5354i) in Wiki section](https://github.com/profzei/Matebook-X-Pro-2018/wiki/Upgrade-to-macOS-Big-Sur): "everything" seems to be working fine!

- **08-20-2020**
	- Initial support for macOS Big Sur Beta 4: for details and an installation guide, please, refer to [Wiki section](https://github.com/profzei/Matebook-X-Pro-2018/wiki/Upgrade-to-macOS-Big-Sur)

- **08-16-2020**
    - Support for macOS Catalina 10.15.6 Supplemental Update (19G2021)

- **08-15-2020**
    - Update `OpenCore` v. 0.6.0
    - Update `SSDT-BATT-HUAWEI.aml` to support memory management for Thermal Framework
    - Add `SSDT-ADP1.aml` to properly load `AppleACPIACAdapter`
    - Update `SSDT-TPXX.aml`: re-enabled and improved support for touchscreen due to the numerous requests (default option)
    - Add `SSDT-TPXX-NO.aml` (to be renamed in `config.plist` as `SSDT-TPXX.aml`): version for disabling touchscreen
    - Add [kext] `ACPIBatteryManager` for fixing (just for now) the very annoying issue due to flooding messages in `Console.app` -> `kernel PMRD: clamshell closed 0, disabled 0, desktopMode 0, ac 0 sleepDisabled 0` (ThreadID 0x74): atm the switch from `SMCBatteryManager` to `ACPIBatteryManager` has been necessary to obtain maximum system stability and ensure the best possible user experience... I'm not happy about this decision because `ACPIBatteryManager` breaks external battery managers! This is a very old random issue (references can be found [tonymacx86](https://www.tonymacx86.com/threads/lid-sensor-flooding-log-with-clamshellstatechanged.272312/), [reddit](https://www.reddit.com/r/MatebookXPro/comments/bvirux/dat_june_hackintosh_update/?sort=new), [InsanelyMac](https://www.insanelymac.com/forum/topic/342497-help-needed-virtualsmc-causes-periodic-updates-of-clamshell-state/), [gnodipac886's repo](https://github.com/gnodipac886/MatebookXPro-hackintosh/issues/75)). **Any contribute is very welcomed!**

    **OpenCore**
    - Update `config.plist` to support `OpenCore` v. 0.6.0
    - Delete [config] unuseful entries for cleaner structure
    - Add [config] 1 binary patch `AC0_ to ADP1` to pair `SSDT-ADP1.aml`
    - Add [config] 5 binary patches to pair `SSDT-BATT-HUAWEI.aml`:
        - `TPWR.ACUR to TPWR.XCUR (Thermal Batt)`
        - `TPWR.AVOL to TPWR.XVOL (Thermal Batt)`
        - `TPWR.PBSS to TPWR.XBSS (Thermal Batt)`
        - `TPWR.PMAX to TPWR.XMAX (Thermal Batt)`
        - `TPWR.PSOC to TPWR.XSOC (Thermal Batt)`

- **08-07-2020**
	- Update support for `Intel Dual-Band Wireless-AC 8265/8275` card [credit to yichebb and AshleyMiller9696]:
        - in section [`Network`](https://github.com/profzei/Matebook-X-Pro-2018/tree/master/Network) instructions and support for the **OpenIntelWireless** project, i.e. `itlwm.kext` and `HeliPort.app`
        - since `itlwm.kext` and `HeliPort.app` are in beta phase, [**pipeline**](https://github.com/1hbb/OpenIntelWireless-Factory/releases) can be used for compiling `itlwm.kext` and `HeliPort.app` with latest changes every 8 hours!
        
    **OpenCore**
    - Update `config.plist` with support for `itlwm` in `Kernel -> Add` section

- **08-03-2020**
	- Update [kext] `AppleALC` v. 1.5.1
	- Update [kext] `CodecCommander` v. 2.7.2
	- Update [kext] `CPUFriend` v. 1.2.1
	- Update [kext] `Lilu` v. 1.4.6
	- Update [kext] `NVMeFix` v. 1.0.3
	- Update [kext] `VirtualSMC` and plugins v. 1.1.5
	- Update [kext] `VoodooPS2Controller` v. 2.1.6
	- Update [kext] `WhateverGreen` v. 1.4.1
	- Update [kext] `IntelBluetoothFirmware` v. 1.1.2

- **07-30-2020**
    - Update `SSDT-EC-USBX.aml` to be compliant with Dortania guide
    - Update [kext] `NoTouchID` v. 1.0.4
    - Update [OC] `config.plist`:
        - improved loading kexts order

- **07-27-2020**
	- Update `SSDT-BATT-HUAWEI.aml`
	- Update [kext] `IntelBluetoothFirmware` v. 1.1.1:
		- udate firmwares to official (Intel) June release
		- fix kernel panic when waking up from sleep (Sleep transition timed out 180 seconds while ...)
		- fix wakeup BT unavailable issue
		- fix some memory leaks
	- Update [kext] `AppleALC` v. 1.5.1 (up to [acidanthera/AppleALC@f07c1f8](https://github.com/acidanthera/AppleALC/commit/f07c1f8c65270f58a50f96bac2588710d0ff7683))
	- Update [kext] `Lilu` v. 1.4.6 (up to [acidanthera/Lilu@28122d0](https://github.com/acidanthera/Lilu/commit/28122d0084dc5fe1b486bd52945160cf5be64d49))
	- Update [kext] `NVMeFix` v. 1.0.3 (up to [acidanthera/NVMeFix@48a0fda](https://github.com/acidanthera/NVMeFix/commit/48a0fda97650fd6a7563d65e479421524685bcee))
	- Update [kext] `VirtualSMC` v. 1.1.5 (up to [acidanthera/VirtualSMC@fab53dc](https://github.com/acidanthera/VirtualSMC/commit/fab53dc600eef3b559c9a99b6cfd598c5f24927e))
	- Update [kext] `VoodooPS2Controller` v. 2.1.6 (up to [acidanthera/VoodooPS2Controller@60a4566](https://github.com/acidanthera/VoodooPS2/commit/60a4566c237f9c39bf38122ec8c0910a388dbe9d))
	- Update [kext] `WhateverGreen` v. 1.4.1 (up to [acidanthera/WhateverGreen@b97c692](https://github.com/acidanthera/WhateverGreen/commit/b97c692aee9672786a181423dd476a05782ba7e9))


- **07-26-2020**
	- Add `SSDT-ALSD.aml` for better support for native Ambient Light Sensor Device
	- Add `SSDT-DTPG.aml` to be compliant with ACPI rules
	- Add `SSDT-TPXX.aml` for enabling proper GPI0 pinning for touchpad device and disabling touchscreen for saving power
	- Update [kext] `VoodooI2C` v. 2.4.3 (smoother behaviour in gestures)
	- Update [kext] `VoodooI2CHID` v. 2.4.3 (smoother behaviour in gestures)
	- Update [OC] `config.plist`:
        - Added `SSDT-ALSD` in `ACPI -> Add` section
        - Added `SSDT-DTPG` in `ACPI -> Add` section
        - Added `SSDT-TPXX` in `ACPI -> Add` section
        - Removed double istance for `VoodooInput` in `Kernel -> Add` section
        - Removed istance for `VoodooPS2Keyboard` in `Kernel -> Add` section
        - Removed istance for `VoodooPS2Mouse` in `Kernel -> Add` section

- **06-23-2020**
	- Support for **OpenCore 0.5.9**
	- Update `SSDT-PLUG-PR.PR00.aml`: better Power Management
    - Update `SSDT-PNLF.aml`
	- Better Sleep support
	- Detailed guide in [Wiki section](https://github.com/profzei/Matebook-X-Pro-2018/wiki/Converting-from-Clover-to-OpenCore) for converting from Clover to OpenCore
		- [script](https://github.com/profzei/Matebook-X-Pro-2018/raw/master/Wiki/Converting_Clover_to_OpenCore.sh) for automated deletion
    - Changed [OC] ProductName to `MacBookPro15,2` for better statistics support
    - Support for dual booting Windows 10 with rEFInd
    - Added a simple black theme for rEFInd bootloader
    - Detailed guide in [Wiki section](https://github.com/profzei/Matebook-X-Pro-2018/wiki/Converting-from-Clover-to-OpenCore) for configuring rEFInd

- **06-01-2020**
	- Update [kext] `Lilu` v. 1.4.5
    - Update [kext] `WhateverGreen` v. 1.4.0
    - Update [kext] `AppleALC` v. 1.5.0
    - Update [kext] `VirtualSMC` and related plugins v. 1.1.4
    - Regression [kext] for a more stability to `VoodooI2C` v. 2.3
    - Regression [kext] for a more stability to `VoodooI2CHID` v. 2.3
	- Update [kext] `VoodooPS2Controller` v. 2.1.5

- **05-31-2020**
    - Add initial support for `Intel Dual-Band Wireless-AC 8265/8275` card:
        - in (new) section [`Network`](https://github.com/profzei/Matebook-X-Pro-2018/tree/master/Network) instructions and support for `AppleIntelWiFi.kext`
        - in (new) section [`Network`](https://github.com/profzei/Matebook-X-Pro-2018/tree/master/Network) instructions and support for a totally automated loader script `IntelKextAutoLoader`
    - Add `ALCPlugFix` for a better support to the switch between the headset and the built-in input [ComboJack & Realtek ALC256](https://github.com/profzei/ALCPlugFix)

- **05-26-2020**
    - Update `OcQuirks` [package](https://github.com/ReddestDream/OcQuirks/releases) to revision 22:
        - Replace `FwRuntimeServices.efi` with `OpenRuntime.efi`
        - Add `OcQuirks.plist` with some value changed from their defaults:
            - `EnableWriteUnprotector` value set to `true` (default value was `false`)
            - `RebuildAppleMemoryMap` value set to `false` (default value was `true`)
            - `SyncRuntimePermissions` value set to `false` (default value was `true`)
    - Update `VirtualSMC.efi` efi driver in `CLOVER/driver/UEFI` to match version (1.1.3) of `VirtualSMC.kext` and accompanying plugins
    - Add `BOOT/BOOTX64.efi` for consistency (both @ r5118) with `CLOVER/CLOVERX64.efi`

- **05-24-2020**
	- Add [config] LSPCON driver support to enable DisplayPort to HDMI 2.0 output on Intel(R) UHD 620 Graphics card:
		- Not modified `framebuffer-conX-type` value from `HDMI` to `DP` accordingly to framebuffer `C0870005` specifics for connectors to preserve "digital audio" 
		- Add the `enable-lspcon-support` property to enable the driver
		- Add the `framebuffer-conX-has-lspcon` property both for connector 1 and connector 2 (to inform the driver which connector has an onboard LSPCON adapter)
		- Add the `framebuffer-conX-preferred-lspcon-mode` property both for connector 1 and connector 2 to specify `DP to HDMI 2.0` mode for LSPCON adapter

- **05-22-2020**
    - Update `Clover` v. 5118
    - Restored `SSDT-PLUG-PR.PR00.aml` to improve `cf-frequency-data` section for CPU `i7-8550U`

- **05-20-2020**
    - Update `Clover` v. 5117
	- The way to modify BIOS has been found and successfully applied: CFG-Lock removed and DVMT changed
		- `CFG Lock` now is set to `disabled` (previous value was `enabled`)
		- `DVMT Pre-Allocated` was already set to `64 MB` (which is the maximum value available)
		- `DVMT Total Gfx Mem` now is set to `MAX` (previous value was `256 MB`)
		- `Intel(R) SpeedStep` was already set to `enabled`
		- `Intel(R) Speed Shift` was already set to `enabled`
	- Set [config] `KernelPM` value to `false`: this parameter affected only post-Haswell CPUs with CFG locked
	- Remove [config] in section `KernelToPatch` binary patch `MSR 0xE2 -xcpm-idle instant reboot`
	- Remove [config] `framebuffer-fbmem` and `framebuffer-stolenmem` keys for UHD 620 Graphics card
	- Remove (till next update...) `SSDT-TPD0.aml` since it refers to touchscreen (`TPD0`)
	- Add `SSDT-GPI0.aml` and `SSDT-TPL1.aml` for touchpad GPIO interrupt mode: it uses VoodooInput bundled inside VoodooI2C (no need for external kext)
	- Add [config] 2 binary patches:
		- `_STA to XSTA for Device GPI0` to pair `SSDT-GPI0.aml`
		- `_CRS to XCRS for Device TPL1` to pair `SSDT-TPL1.aml` (touchpad)
	- Add [config] in section `KextToPatch` 2 binary patches respectively `com.apple.driver.AppleIntelLpssI2C` and `com.apple.driver.AppleIntelLpssI2CController` even if these two "old" issues should be fixed with `VoodooI2C` v. 2.4 (GenI2C app in "Diagnose" section still checks the presence of these two patches)
	- Add [config] `SSDT->NoOemTableId` key and its value is set to `false`
	- Remove [config] old and unused key `DropTables->#MCFG`
	- Remove [config] `DSDT->ReuseFFFF` key (its value was set to `false`)
	- Remove [config] `DSDT->Debug` key (its value was set to `false`)
	- Remove [config] `DSDT->DropOEM_DSM` key since `Clover` v. 5117 dropped it
    - Remove [config] `Boot->Debug` key (its value was set to `false`)
    - Add [config] `Graphics->EDID->Inject` key to value `yes` since it is checked that the right value is injected
    - Remove [config] `KernelAndKextPatches->Debug` key (its value was `false`)
    - Remove [config] `KernelAndKextPatches->DellSMSBIOSPatch` key (its value was `false`)
    - Remove [config] `KernelCPU` key (its value was set to `false`)
    - Remove [config] `KernelLapic` key (its value was set to `false`)
    - Replaced `SSDT-XCPM.aml` with standard (OpenCore project) `SSDT-PLUG-PR.PR00.aml`
    - Implemented in `SSDT-PLUG-PR.PR00.aml` method `_PPC` for "Performance Present Capabilities" [credit to Zero-zer0]
    - Update [config] `Devices->Properties` to let `System Information.app` show more Properties in PCI0 devices
        - for PCI Bridges `reg-ltrovr` property is injected: `IOPCIFamily.kext` will set latency tolerance offset for each of the latency tolerance devices (this could fix some potential issues)

- **05-11-2020**
	- Add [config] attribute `acpi-wake-type` to the USB Controller in Device `PciRoot(0x0)/Pci(0x14,0x0)` to fix sleep when lid is closed (during sleep state both CapsLock and Fn leds are off; display wakes up properly)
	- Set [config] `AppleIntelCPUPM` value to `false` since this parameter affects only pre-Haswell CPUs
	- Set [config] `KernelPM` value to `true`: this parameter is needed for proper CPU Power Management if CFG-Lock can't be disabled in BIOS for Haswell and newer CPUs
	- Set [config] `HWPEnable` value to `true`: with an SMBIOS like MacBookPro14,x which supports HWP technology (i.e. Intel SpeedShift), CPU handles pstate management by itself (CPU itself automatically shift to higher and lower pstates depending on CPU demand instead of requiring the OS to do it)

- **05-10-2020**
    - Add `SSDT-TPD0.aml` to enable APIC interrupt mode: it uses VoodooInput bundled inside VoodooI2C (no need for external kext)
    - Remove `SSDT-SLPB.aml` (it added support for "sleep button")
    - Remove `SSDT-DeepIdle.aml`: it added support for "deep idle" at software level, but, in some (unknown) way, it breaks it at hardware level with a battery discharge rate of about 2% per hour during sleep state
    - Modified [config] framebuffer for UHD 620 Graphics card to `C0870005`:
        - no more glitches during boot transition from 1st to 2nd stage
        - full support for software sleep state: during sleep state both CapsLock and Fn leds are off; display wakes up properly (no more split screen issue!)
        - custom patching for each connector (con 0: LVDS, con 1: HDMI, con 2: HDMI): support up to two 4K @ 60 Hz monitors
        - enabled digital audio with `hda-gfx` property
        - enabled (standard) semantic patches for BIOS with DVMT Pre-Alloc 32 MB when higher is required (`fbmem`= 9 MB, `stolenmem`= 38 MB)
        - enabled HDMI in UHD resolution with 60 fps with `-cdfon` boot-arg and `enable-hdmi20` property: this could fix random `gIOScreenLockState3` error during boot phase
        - added the `disable-external-gpu` property
        - added `-igfxmlr` boot-arg and `enable-dpcd-max-link-rate-fix` property: this could fix random kernel panic due to a "division-by-zero"
        - specified a maximum link rate value via the `dpcd-max-link-rate` property for builtin display: `0x06` for RBR, `0x0A` for HBR (typically used for 1080p display), `0x14` for HBR2 (typically used for 4K display) and `0x1E` for HBR3
    - Improved details in Graphics section
    - Add [config] new LiteON CA3 patch `IONVMeFamily Preferred Block Size 0x10 -> 0x02` in `KextsToPatch` section [credit to ygy3389]

- **05-08-2020**
    - Update `Clover` v. 5116
    - Update [kext] `Lilu` v. 1.4.4
    - Update [kext] `WhateverGreen` v. 1.3.9
    - Update [kext] `AppleALC` v. 1.4.9
    - Update [kext] `VoodooI2C` v. 2.4.2
    - Update [kext] `VoodooI2CHID` v. 2.4.2
    - Update [kext] `VoodooPS2Controller` v. 2.1.4
    - Update [kext] `VirtualSMC` and related plugins v. 1.1.3
    - Update [kext] `HibernationFixup` v. 1.3.3

- **05-05-2020**
    - Add `config-catalina.plist` for supporting macOS Catalina
    - Modified [config] Boot arg from `darkwake=1` to `darkwake=4`
    - Applied `Security Update 2020-002 Mojave` flawlessly. See [here](https://support.apple.com/en-gb/HT211100)

- **05-02-2020**
	- Add `SSDT-RMCF.aml` since `SSDT-PNLF.aml` and `SSDT-PTSWAK.aml` are using Rehabman's approach with `RMCF` device and relative method

- **04-29-2020**
    - Update `Clover` v. 5115
    - Update `Readme` with Fix AppleID for Catalina
    - Remove `SSDT-ALS0.aml`: since native `ALSD` Ambient Light Sensore Device works properly there's no need for a fake one
    - Improved `SSDT-DDGPU.aml` in `SSDT-DDGPU-Optimus.aml`: discrete gpu is disabled with Optimus method (Bumblee method has been also tested but with poor results)
    - Improved `SSDT-PTSWAK.aml` in `SSDT-PTSWAK-Optimus.aml` to pair with `SSDT-DDGPU-Optimus.aml`
    - Add `SSDT-BATT-HUAWEI.aml` for a better native support for Huawei Matebook X Pro battery
    - Add [config] 18 binary patches to pair `SSDT-BATT-HUAWEI.aml` 

- **04-13-2020**
    - Update `Readme` with Development section for Catalina 10.15.4
    - Remove [config] binary patch `XHC1 to XHC` for USB ports
    - Change [config] from binary patch `Method(_WAK,1,N) to ZWAK` to `Method(_WAK,1,S) to ZWAK`: "Zero ACPI Error" messages during boot process achieved

- **04-12-2020**
    - Remove [config] the `IOGraphicsFamily.kext` `ForceKextsToLoad` patch because `VoodooI2C` v2.4 fix the issue
    - Update [config] `Device`-`Properties` section for `AAPL,ig-platform-id`: `00001659` (no more graphical glitches during boot process from 1st to 2nd stage phase)
    - Update [config] `Device`-`Properties` section for `device-id`: `16590000` (same as above)
    - Update `Readme` with Graphics section

- **04-10-2020**
    - Applied [config] binary patch `EC0 to EC` according to [khronokernel guide](https://github.com/khronokernel/Getting-Started-With-ACPI/blob/master/Laptops/laptop-ec.md)
    - Remove `SSDT-EC-USBX.aml` since there is no need for a fake EC device in Mojave laptop configuration
    - Add `SSDT-USBX.aml` to enable USB power properties via USBX device (formerly in `SSDT-EC-USBX.aml`)
    - Update `SSDT-FnKey.aml` applying `EC0 to EC` patch
    - Revert [kext] `CodecCommander` v. 2.7.1 to [RehabMan old version](https://bitbucket.org/RehabMan/os-x-eapd-codec-commander/downloads/) instead of Sniki's fork for a better compatibility with Mojave

- **04-09-2020**
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

- **04-01-2020**
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


- **03-15-2020**
	
	- More detailed comments in `*.dsl` files
	- Update `Readme.md`
	- Modified `Changelog.md` structure


- **03-14-2020**
    
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


- **03-13-2020**
    
    - Initial commit
