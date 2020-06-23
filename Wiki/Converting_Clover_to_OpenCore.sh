#!/bin/bash

echo "Removing Clover's script for boot and shutdown phases..."
sudo rm -rf /etc/rc.clover.lib
sudo rm -rf /etc/rc.boot.d/10.save_and_rotate_boot_log.local
sudo rm -rf /etc/rc.boot.d/20.mount_ESP.local
sudo rm -rf /etc/rc.boot.d/70.disable_sleep_proxy_client.local.disabled
sudo rm -rf /etc/rc.shutdown.d/80.save_nvram_plist.local
sudo rm -rf /etc/rc.boot.d
sudo rm -rf /etc/rc.shutdown.d

sleep 1

echo "Removing Clover's daemons..."
sudo launchctl unload /Library/LaunchDaemons/com.slice.CloverDaemonNew.plist
sudo rm -rf /Library/LaunchDaemons/com.slice.CloverDaemonNew.plist
sudo rm -rf /Library/LaunchDaemons/com.projectosx.clover.daemon.plist

sleep 1

echo "Removing Clover's Preference Pane..."
sudo rm -rf /Library/PreferencePanes/Clover.prefPane
sudo rm -rf /Library/Application\ Support/Clover

sleep 1
echo "...done!"