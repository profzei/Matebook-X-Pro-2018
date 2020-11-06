## Notes
* Works on Catalina 10.15.x
* You need delete `SSDT-DRP11.aml` if it is present in `EFI/OC/ACPI/` or in `EFI/CLOVER/ACPI/patched/`
* Support for WPA/WPA2

At the moment [18 September 2020] there are two ways to drive our native **Intel Wireless Card**:
* use **itlwm** and **HeliPort**
* use **AirportItlwm**

As mentioned in the related project documentation, **Intel Wi-Fi card cannot reach maximum speeds at the moment**: developers are putting efforts to polish drivers and add new features.



## AirportItlwm - How to use
This project is still in **beta phase**:
* supports all itlwm-supported devices
* supports native Wi-Fi selection and switching with WPA/WPA2/Unencrypted Wi-Fi Networks
* supports Location Services
* Handoff and Universal Clipboard perfectly supported (See [#292 (comment)](https://github.com/OpenIntelWireless/itlwm/issues/292#issuecomment-693728787))

Since it's in **beta phase**, there are **known issues and limitations**:
* Handoff and Universal Clipboard are the only supported Continuity features.
* Instant HotSpot from iPhone can be recognized but may likely fail to connect. **Workaround**: use itlwm.kext with HeliPort.
* Apple Bluetooth peripherals may fail to connect. **Workaround**: use itlwm.kext with HeliPort or disable iCloud.

Bootloader Compatibility:
* Supported: OpenCore -> `Kernel Collections with & without Apple Secure Boot`
* Supported: OpenCore -> `Prelinked Kernel with ImmutableKernel`
* Not Supported: OpenCore & Clover with `Prelinked Kernel without ImmutableKernel`

1. First, make sure your macOS version >= 10.15 and your OpenCore bootloader version >= 0.6.1
2. [If applicable] Remove `itlwm` and `HeliPort`
3. Turn on `Show Wi-Fi status` in menu bar in `System Preferences` -> `Network` -> `Wi-Fi` (In MacOS 11<=* `System Preferences` -> `Dock & Menu bar` -> `Wi-Fi`)
4. Download the latest release at the following link:
	- [https://github.com/OpenIntelWireless/itlwm/releases](https://github.com/OpenIntelWireless/itlwm/releases)
5. Unzip the pack you downloaded and copy `AirportItlwm.kext` to `EFI/OC/Kexts/` folder
6. Open `/EFI/OC/config.plist` and find the following code:
```
<dict>
	<key>Arch</key>
	<string>x86_64</string>
	<key>BundlePath</key>
	<string>AirportItlwm.kext</string>
	<key>Comment</key>
	<string>Intel Wi-Fi driver</string>
	<key>Enabled</key>
	<false/>
	...
```
and change to:
```
<dict>
	<key>Arch</key>
	<string>x86_64</string>
	<key>BundlePath</key>
	<string>AirportItlwm.kext</string>
	<key>Comment</key>
	<string>Intel Wi-Fi driver</string>
	<key>Enabled</key>
	<true/>
	...
```
7. Also change your `SecureBootModel` to allow loading **immutablekernel**. **Warning**: if your macOS version >= macOS 11 (KernelCollection) then you don't need to do the following steps!

Find the following code:
```
<dict>
	<key>DmgLoading</key>
	<string>Any</string>
	...
```
and change to:
```
<dict>
	<key>DmgLoading</key>
	<string>Signed</string>
	...
```
Find the following code:
```
<dict>
	<key>SecureBootModel</key>
	<string>Disabled</string>
	...
```
and change to:
```
<dict>
	<key>SecureBootModel</key>
	<string>Default</string>
	...
```

8. If the above method doesn't work, you can force loading `IO80211Family`. Open `/EFI/OC/config.plist`, find the following code:
```
<key>Force</key>
	<array>
		<dict>
			<key>Arch</key>
			<string>Any</string>
			<key>BundlePath</key>
			<string>System/Library/Extensions/IO80211Family.kext</string>
			<key>Comment</key>
			<string></string>
			<key>Enabled</key>
			<false/>
	...
```
and change to:
```
<key>Force</key>
	<array>
		<dict>
			<key>Arch</key>
			<string>Any</string>
			<key>BundlePath</key>
			<string>System/Library/Extensions/IO80211Family.kext</string>
			<key>Comment</key>
			<string></string>
			<key>Enabled</key>
			<true/>
	...
```

9. Reboot

Remember that `AirportItlwm.kext` is still in **beta phase**, but rapidly improving! Use at your own risk!

### Discussion
- If you have questions about the driver, please discuss them on [https://gitter.im/OpenIntelWireless/itlwm](https://gitter.im/OpenIntelWireless/itlwm)
- If you want to report bugs, please use [https://github.com/OpenIntelWireless/itlwm/issues](https://github.com/OpenIntelWireless/itlwm/issues)


## OpenIntelWireless - How to use
This project is based on:
- `itlwm.kext`: an Intel Wifi Adapter Kernel Extension for macOS, based on the OpenBSD Project
- `HeliPort`: a GUI-based Intel WiFi Client for `itlwm.kext`
We will use itlwm and HeliPort to drive our Intel Wireless Card. 
1. Download the latest releases at the following links:
	- [https://github.com/OpenIntelWireless/itlwm/releases](https://github.com/OpenIntelWireless/itlwm/releases)
	- [https://github.com/OpenIntelWireless/HeliPort/releases](https://github.com/OpenIntelWireless/HeliPort/releases)
2. Turn off `Show Wi-Fi status` in menu bar in `System Preferences` -> `Network` -> `Wi-Fi`
   (In MacOS 11<=* `System Preferences` -> `Dock & Menu bar` -> `Wi-Fi`)
3. Unzip all the packs you downloaded and copy `itlwm.kext` to `/EFI/OC/Kexts/` or `/EFI/CLOVER/kexts/Other/` folder
4. If you are using **OpenCore**, you need to change your config.plist. Open `/EFI/OC/config.plist` and find the following code:
```
<dict>
	<key>BundlePath</key>
	<string>itlwm.kext</string>
	<key>Comment</key>
	<string>Intel Wi-Fi driver</string>
	<key>Enabled</key>
	<false/>
	...
```
and change to:
```
<dict>
	<key>BundlePath</key>
	<string>itlwm.kext</string>
	<key>Comment</key>
	<string>Intel Wi-Fi driver</string>
	<key>Enabled</key>
	<true/>
	...
```
5. Reboot and move `HeliPort.App` to your `Applications` folder
6. Open `HeliPort.App`:
	- You need to **allow software from any sources first**
	- If needed, run the following command in `Terminal.App`:
```
sudo spctl --master-disable
```
7. Add `HeliPort.App` to `System Startup`:
	- Go to `System Preferences` -> `Users & Groups`
	- Select in your admin account `Login Items` tab
	- Add (`+` symbol) `HeliPort.App` from `Applications` folder

~~Remember that `itlwm.kext` and `HeliPort` are still in **beta phase**, but rapidly improving! Use at your own risk!~~

[**Pipeline**](https://github.com/1hbb/OpenIntelWireless-Factory/releases) has been created for compiling `itlwm.kext` and `HeliPort.app` with latest changes every 8 hours!

8. [Optional] You can modify **HeliPort's menubar icon** for **macOS Big Sur**:
	- Quit HeliPort app by holding `Alt` key + clicking `HeliPort menubar icon` -> then choose `Quit HeliPort`
	- In your `Applications` folder, locate `HeliPort` app
	- After selecting `HeliPort` app, right click on it and then choose `Show Package Contents`
	- Under `Contents -> Resources` replace `Assets.car` with the file available [https://github.com/R-Teer/Heliport-Menubar-Icon-Big-Sur](https://github.com/R-Teer/Heliport-Menubar-Icon-Big-Sur/blob/main/Assets.car) [credit **@R-Teer**]
	- Restart `HeliPort` app and enjoy the revised look!

### Discussion
- If you have questions about the driver, please discuss them on [https://gitter.im/OpenIntelWireless/itlwm](https://gitter.im/OpenIntelWireless/itlwm)
- If you want to report bugs, please use [https://github.com/OpenIntelWireless/itlwm/issues](https://github.com/OpenIntelWireless/itlwm/issues)


## ~~AppleIntelWiFi - How to use~~ [Deprecated!]
* For reference see:
	- [tonymacx86 thread](https://www.tonymacx86.com/threads/success-working-intel-wifi-drivers-for-7265ac-on-catalina.292207/page-44): last update on 2020-05-23
	- [Intel WiFi Kext V2](https://www.youtube.com/watch?v=kHfUjJ2RkyU)

1. Download `AppleIntelWiFi 0523.zip` and `IntelKextAutoLoader.zip` files from here or from [tonymacx86 thread](https://www.tonymacx86.com/threads/success-working-intel-wifi-drivers-for-7265ac-on-catalina.292207/page-44) (last update: 2020-05-23) 
2. Create a folder `AppleIntelWiFi` on Desktop
3. Unzip `AppleIntelWiFi 0523.zip` and move the `kext` file in `Desktop/AppleIntelWiFi` folder
	- Select `AppleIntelWiFi.kext`, right-click, select option `Show Package Contents`
	- Navigate, select and open `Contents/Info.plist`
	- Navigate `IOKitPersonalities/AppleIntelWiFi/IFConfig`
	- Modify `NWID` entry with your `SSID` and `WPAKEY` with your `PASSWORD` i.e. your network parameters
	- Save and exit
4. Use Hackintool to disable Gatekeeper or run the following commands in terminal:
```
sudo spctl --master-disable
sudo mount -uw /
sudo killall Finder
```
5. Unzip `IntelKextAutoLoader.zip` and move the script in `Desktop/AppleIntelWiFi` folder 
6. Ensure that `IntelKextAutoLoader` script is only readable and executable, not writable (for security purposes); it should also be owned by `root` (with setuid), so only `root` can alter these permissions; in a terminal shell type the following:
```
sudo chown root:wheel IntelKextAutoLoader
sudo chmod 4755 IntelKextAutoLoader
```
7. Add `IntelKextAutoLoader` script to `System Startup`
	- Go to `System Preferences` -> `Users & Groups`
	- Select in your admin account `Login Items` tab
	- Add (`+` symbol) the shell script `IntelKextAutoLoader`
8. Modify your `/etc/sudoers` file to not require a password for executing this shell script at every login
	- For editing the sudoers file `/etc/sudoers`, just type the following command in a terminal shell:
	```
	sudo visudo
	```
	- Use arrows keys to go to the end of file (EOF)
	- Use `i` to insert a line above the line the cursor is located on
	- Append these lines to `/etc/sudoers`, replacing `myusername` with your login username (use `whoami` to find this out):
	```
	Cmnd_Alias      INTELCMD = /bin/chmod, /usr/sbin/chown, /sbin/kextload
	Cmnd_Alias      INTELWIFI = /Users/myusername/Desktop/AppleIntelWiFi/IntelKextAutoLoader
	myusername      ALL = (ALL) NOPASSWD: INTELCMD
	myusername      ALL = (ALL) NOPASSWD: INTELWIFI
	```
	- Press the `Esc` key to get back to `Normal mode`
	- Type a colon (`:`) to move the cursor to the bottom of the screen
	- Type `wq`: `w` for Write (or Save) and `q` for Quit. This command combination returns you to the command line.
9. Reboot your machine

Remember that `AppleIntelWiFi.kext` is still in **beta phase**, but rapidly improving! There have been some reports of random crashes and reboots, use at your own risk!

## Other Project
- [https://github.com/usr-sse2/Black80211-Catalina](https://github.com/usr-sse2/Black80211-Catalina) joins [https://github.com/AppleIntelWifi/Black80211-Catalina](https://github.com/AppleIntelWifi/Black80211-Catalina) and [https://github.com/OpenIntelWireless/itlwm](https://github.com/OpenIntelWireless/itlwm) to provide a wireless driver for Intel adapters that can be controlled using native AirPort menu item.
