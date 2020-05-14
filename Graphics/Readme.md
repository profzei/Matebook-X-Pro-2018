## Graphics settings
[Support information](https://www.intel.com/content/www/us/en/support/products/126789/graphics-drivers/graphics-for-8th-generation-intel-processors/intel-uhd-graphics-620.html) for Intel(R) UHD Graphics 620
| Specifications                             | Details                   |
| :--- | :---|
| Processor Graphics                         | Intel(R) UHD Graphics 620 |
| Graphics Base Frequency                    | 300 MHz                   |
| Graphics Max Dynamic Frequency             | 1.00 - 1.15 GHz           |
| Graphics Video Max Memory                  | 32 GB                     |
| Graphics Output                            | eDP / DP / HDMI / DVI     |
| 4K Support                                 | Yes, at 60 Hz             |
| Max Resolution (HDMI 1.4)                  | 4096x2304 @ 24 Hz         |
| Max Resolution (DP)                        | 4096x2304 @ 60 Hz         |
| Max Resolution (eDP-Integrated Flat Panel) | 4096x2304 @ 60 Hz         |
| Max Resolution (VGA)                       | N/A                       |
| DirectX Support                            | 12                        |
| OpenGL Support                             | 4.5                       |
| Intel Quick Sync Video                     | Yes                       |
| Intel InTru 3D Technology                  | Yes                       |
| Intel Clear Video HD Technology            | Yes                       |
| Intel Clear Video Technology               | Yes                       |
| # of Displays Supported                    | 3                         |
| Device ID                                  | 0x5917                    |


Recommended framebuffer for Intel(R) UHD Graphics 620 (Kaby Lake Refresh) card:
```
AAPL,ig-platform-id		[Data]		0500C087
device-id			[Data]		C0870005
```
Software sleep function works flawlessly with the above mentioned settings: during sleep state both CapsLock and Fn leds are off. During wake up phase display wakes up properly (no more split screen issue!). 

KBL connectors `AppleIntelKBLGraphicsFramebuffer.kext`:
```
ID: 87C00005, STOLEN: 57 MB, FBMEM: 0 bytes, VRAM: 1536 MB, Flags: 0x00A30702
TOTAL STOLEN: 58 MB, TOTAL CURSOR: 1 MB (1572864 bytes), MAX STOLEN: 172 MB, MAX OVERALL: 173 MB (181940224 bytes)
Model name: Intel UHD Graphics 617
Camellia: CamelliaV3 (3), Freq: 1388 Hz, FreqMax: 1388 Hz
Mobile: 1, PipeCount: 3, PortCount: 3, FBMemoryCount: 3
[0] busId: 0x00, pipe: 8, type: 0x00000002, flags: 0x00000098 - ConnectorLVDS
[1] busId: 0x05, pipe: 9, type: 0x00000400, flags: 0x000003C7 - ConnectorDP
[2] busId: 0x04, pipe: 10, type: 0x00000400, flags: 0x000003C7 - ConnectorDP
00000800 02000000 98000000
01050900 00040000 C7030000
02040A00 00040000 C7030000
```


Intel(R) UHD Graphics 620 (Kaby Lake Refresh) card configuration:
```
<key>PciRoot(0x0)/Pci(0x2,0x0)</key>
	<dict>
		<key>AAPL,ig-platform-id</key>
		<data>BQDAhw==</data>
		<key>AAPL,slot-name</key>
		<string>Internal</string>
		<key>device-id</key>
		<data>wIcABQ==</data>
		<key>device_type</key>
		<string>VGA compatible controller</string>
		<key>disable-external-gpu</key>
		<data>AQAAAA==</data>
		<key>dpcd-max-link-rate</key>
		<data>FAAAAA==</data>
		<key>enable-dpcd-max-link-rate-fix</key>
		<data>AQAAAA==</data>
		<key>enable-hdmi20</key>
		<data>AQAAAA==</data>
		<key>force-online</key>
		<data>AQAAAA==</data>
		<key>framebuffer-con0-enable</key>
		<data>AQAAAA==</data>
		<key>framebuffer-con0-flags</key>
		<data>mAAAAA==</data>
		<key>framebuffer-con0-type</key>
		<data>AgAAAA==</data>
		<key>framebuffer-con1-enable</key>
		<data>AQAAAA==</data>
		<key>framebuffer-con1-flags</key>
		<data>xwMAAA==</data>
		<key>framebuffer-con1-type</key>
		<data>AAgAAA==</data>
		<key>framebuffer-con2-enable</key>
		<data>AQAAAA==</data>
		<key>framebuffer-con2-flags</key>
		<data>xwMAAA==</data>
		<key>framebuffer-con2-type</key>
		<data>AAgAAA==</data>
		<key>framebuffer-fbmem</key>
		<data>AACQAA==</data>
		<key>framebuffer-patch-enable</key>
		<data>AQAAAA==</data>
		<key>framebuffer-stolenmem</key>
		<data>AABgAg==</data>
		<key>framebuffer-unifiedmem</key>
		<data>AAAAgA==</data>
		<key>hda-gfx</key>
		<string>onboard-1</string>
		<key>model</key>
		<string>Intel UHD Graphics 620</string>
	</dict>
```

## External Display support
- According to [ioregistryExplorer](https://github.com/vulgo/IORegistryExplorer), `Framebuffer@0 (Connector 0) ` is LVDS (Internal Display).
- `Framebuffer@1 (Connector 1)`, `Framebuffer@2 (Connector 2)` are pointing to DisplayPort and HDMI respectively.
- Refer to [gfxutil](https://github.com/acidanthera/gfxutil/releases), path of iGPU is `DevicePath = PciRoot(0x0)/Pci(0x2,0x0)`
- HDMI is working perfectly, video and audio output are both working flawlessly.

### Digital Audio (HDMI / DVI / DP)
To enable digital audio it is necessary to set the necessary properties and, usually, patch the connectors.
To enable audio in general and HDMI in particular use WEG along with AppleALC.kext.
On 10.10.5 and above, WEG automatically changes the connector-type of DP (00040000) to HDMI (00080000) if no custom patches are used.
The actual connection may be of any type (HDMI / DVI / DP), but for the digital audio to function the connector-type must explicitly be HDMI.

When HDMI plugged in, macOS would recognize as DP (busID: 0x05), not HDMI (busID: 0x04).     
  - List of busID and ports recognized in macOS:

|   DP     |   HDMI   |    DVI    |
| -------- | -------- | --------- |
|   0x02   |   0x00   |    0x01   |
|   0x04   |   0x02   |    0x02   |
|   0x05   |   0x04   |    0x04   |
|   0x06   |   0x06   |    0x06   |

- `framebuffer-conX-enable`     
	    `01000000` -> Enable, `00000000` -> Disable
- `framebuffer-conX-type`
    	`00000800` -> HDMI output, `00000400` -> DP output
- `framebuffer-conX-index`
    	`fffffff` -> Block
- `framebuffer-unifiedmem`
      	`00000080` -> VRAM to 2048M, `000000C0` -> VRAM to 3072M
- `framebuffer-fbmem`
      	`00009000` -> 9M for FHD, `00000003` -> 48M for QHD/UHD
- All framebuffer values can be insert as `NUMBER` type, except `ig-platform-id`.

## Display fixes
On macOS > 10.13.6, to enable higher HiDPI resolution, you need to set DVMT to 64 MB first: this, in general, means a CFG-unlocked machine.

Use [xzhih](https://github.com/xzhih)'s [one-key-hidpi](https://github.com/xzhih/one-key-hidpi) to improve quality of system UI. Script can be run in remote or local mode: I choose local one. My steps are the following:
- download ZIP archive, decompressing it and double click `hidpi.command` to run
- select `Enable HIDPI (with EDID)` [choice #2]
- select `MacBook Pro` [choice #3]
- select `3000x2000` for resolution config [choice #5]
- reboot

After reboot, more `HiDPI` resolutions become available like `3000x2000`, `2880x1920`, `2250x1500`, `1920x1280`. The configuration file `DisplayProductID-422a` for our display (JDI422a) can be found for the path `/System/Library/Displays/Contents/Resources/Overrides/` in `DisplayVendorID-2889` folder. If you want to "identify" easier actual "Display profile" in "System Preferences" -> "Display Preferences", do the following steps:
```
cd /System/Library/Displays/Contents/Resources/Overrides/DisplayVendorID-2889
sudo nano DisplayProductID-422a
```
paste this code
```
<key>DisplayProductName</key>
<string>Huawei JDI422a Retina Display</string>
```
and press <Ctrl> + <X>, then respond with <Y> (for "Yes") and then press <Enter> to save the file and exit nano editor. Reboot the laptop. For reference see [here](http://x220.mcdonnelltech.com/enable-scaled-resolutions/)


#### Display Color Profile
Copy the `.icm` file to `/Library/ColorSync/Profiles` and select it in `System Preferences -> Display -> Color tab`.

For more details refer to [Installing ICM profile on macOS](https://profzei.github.io/2020/01/26/installing-icm-profiles.html)