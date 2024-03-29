#!/usr/bin/env sh

# from https://superuser.com/a/388317/778483
#
# Utility to force your mac immediately into hibernation mode/suspend to disk,
# thus conserving battery considerably (at the cost of slower startup)
# @date 2012-02-10
# @author Carl-Erik Kopseng. Contact at oligofren.wordpress.com

# must be run as root by using sudo or to avoid entering the password, change the pmset
# executable settings by entering
# sudo chmod +s /usr/bin/pmset
# sudo chmod +s /sbin/shutdown

MODE_BACKUP=/tmp/hibernate_mode.bak
SUSPEND_TO_DISK=25 #see man pmset

display_settings() {
    echo "Current settings: " $(pmset -g | grep hibernatemode)
}

save_settings() {
    echo "saving settings"
    pmset -g | grep hibernatemode | awk '{print $2}' > $MODE_BACKUP
}

restore_settings() {
    echo "restoring settings"
    pmset -a hibernatemode $(cat $MODE_BACKUP)
}

set_only_disk_hibernate() {
    echo "changing settings to only suspend to disk (slow, but does not use battery)"
    pmset -a hibernatemode $SUSPEND_TO_DISK
}

hibernate() {
    echo "going into hibernation"
    shutdown -s now
}

save_settings
set_only_disk_hibernate && hibernate
restore_settings
