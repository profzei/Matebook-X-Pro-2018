# ALC Plug Fix

## Introduction
* The script can solve some headphone jack issues (See [issue#1](https://github.com/profzei/Matebook-X-Pro-2018/issues/1)).
* It sends commands `hda-verb 0xNode SET_PIN_WIDGET_CONTROL 0xVerbs` and `hda-verb 0xNode SET_UNSOLICITED_ENABLE 0xVerbs` to activate properly headphone jack and then switch it back.
* `hda-verb` is originally from a command of `alsa-project` in Linux. Its function is to send HD-audio commands.


## How to install
- Run the following command in Terminal:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/profzei/Matebook-X-Pro-2018/master/ALCPlugFix/one-key-alcplugfix.sh)"
```
- When it's done, restart your computer. The installation now completes.

Attention: You may have to replug the headphone after every boot to let headphone work.


## Credits
* Thanks to [goodwin](https://github.com/goodwin), [Sniki](https://github.com/Sniki/ALCPlugFix) and [khanhtran-cse](https://github.com/khanhtran-cse/ALCPlugFix) for providing and maintaining [ALCPlugFix](https://github.com/goodwin/ALCPlugFix).
* Thanks to [daliansky](https://github.com/daliansky/XiaoMi-Pro-Hackintosh) for updating the one-key install script.
* Thanks to [Rehabman](https://github.com/RehabMan) for providing [hda-verb](https://github.com/RehabMan/EAPD-Codec-Commander).
