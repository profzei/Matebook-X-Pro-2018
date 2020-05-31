## Notes
* Works on Catalina 10.15.x
* You need delete `SSDT-DRP11.aml` if it is present in `EFI/CLOVER/ACPI/patched/`
* Support for WPA/WPA2
* For reference see:
	- [tonymacx86 thread](https://www.tonymacx86.com/threads/success-working-intel-wifi-drivers-for-7265ac-on-catalina.292207/page-44): last update on 2020-05-23
	- [Intel WiFi Kext V2](https://www.youtube.com/watch?v=kHfUjJ2RkyU)

## Usage
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
	- Edit the sudoers file:
	```
	sudo visudo /etc/sudoers
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

Remember that `AppleIntelWiFi.kext` is still in beta phase, but rapidly improving! There have been some reports of random crashes and reboots, use at your own risk!

## Other links
* Another project: [itlwm](https://github.com/zxystd/itlwm). Maintained by [zxystd](https://github.com/zxystd).