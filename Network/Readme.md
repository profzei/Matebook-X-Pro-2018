## Notes
* Works on Catalina 10.15.x
* You need delete `SSDT-DRP11.aml` if it is present in `EFI/CLOVER/ACPI/patched/`
* Support for WPA/WPA2
* For reference see:
	- [tonymacx86 thread](https://www.tonymacx86.com/threads/success-working-intel-wifi-drivers-for-7265ac-on-catalina.292207/page-44): last update on 2020-05-23
	- [Intel WiFi Kext V2](https://www.youtube.com/watch?v=kHfUjJ2RkyU)

## OpenIntelWireless - How to use
This project is based on:
- `itlwm.kext`: an Intel Wifi Adapter Kernel Extension for macOS, based on the OpenBSD Project
- `HeliPort`: a GUI-based Intel WiFi Client for `itlwm.kext`
We will use itlwm and HeliPort to drive our Intel Wireless Card. 
1. Download the latest releases at the following links:
	- [https://github.com/OpenIntelWireless/itlwm/releases](https://github.com/OpenIntelWireless/itlwm/releases)
	- [https://github.com/OpenIntelWireless/HeliPort/releases](https://github.com/OpenIntelWireless/HeliPort/releases)
2. Turn off `Show Wi-Fi status` in menu bar in `System Preferences` -> `Network` -> `Wi-Fi`
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
	– You need to **allow software from any sources first**
	– If needed, run the following command in `Terminal.App`:
```
sudo spctl --master-disable
```
7. Add `HeliPort.App` to `System Startup`:
	- Go to `System Preferences` -> `Users & Groups`
	- Select in your admin account `Login Items` tab
	- Add (`+` symbol) `HeliPort.App` from `Applications` folder

Remember that `itlwm.kext` and `HeliPort` are still in **beta phase**, but rapidly improving! Use at your own risk!

[**Pipeline**](https://github.com/1hbb/OpenIntelWireless-Factory/releases) has been created for compiling `itlwm.kext` and `HeliPort.app` with latest changes every 8 hours!

### Discussion
- If you have questions about the driver, please discuss them on [https://gitter.im/OpenIntelWireless/itlwm](https://gitter.im/OpenIntelWireless/itlwm)
- If you want to report bugs, please use [https://github.com/OpenIntelWireless/itlwm/issues](https://github.com/OpenIntelWireless/itlwm/issues)


## AppleIntelWiFi - How to use
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
