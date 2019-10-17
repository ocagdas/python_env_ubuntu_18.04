#!/bin/bash
set -e
 
# If "-e uid={custom/local user id}" flag is not set for "docker run" command, use 9999 as default
CURRENT_UID=${uid:-9999}
 
# Notify user about the UID selected
echo "Current UID : $CURRENT_UID"
# Create user called "docker" with selected UID
useradd -d /home/docker --shell /bin/bash -u $CURRENT_UID -o -c "" -m docker
passwd -d docker
# Set "HOME" ENV variable for user's home directory
export HOME=/home/docker
echo "docker  ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers; echo "Defaults    !requiretty" >> /etc/sudoers
 
# Execute process
exec /usr/local/bin/gosu docker "$@"

