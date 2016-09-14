#!/bin/bash
echo "Script to install CVS server on Ubuntu 14.04"
apt-get install cvs
echo "Installation status cvs server --> $?"
apt-get install xinetd
echo "Installation status of xinetd service --> $?"
groupadd cvs
echo "Group add --> $?"
/usr/sbin/useradd -g cvs -m -d /home/cvs -s /bin/bash cvs
echo "Created cvs user --> $?"
user=cvs
echo "Set user variable to cvs $?"
echo "$user"
echo "Provide password for cvs user:"
read  passwd
echo "$user:$passwd" | chpasswd
echo "password set --> $?"
cd /home/cvs/ 
mkdir -p repository/Code
echo "Create directory for Code --> $?"
chgrp -R cvs /home/cvs/repository/Code
chmod g+srwx /home/cvs/repository/Code
echo "Changed permissions of Directory Code--> $?"
echo "Initialize CVS repository Code"
cvs -d /home/cvs/repository/Code init
echo "Code CVS repository initialized -->$?"
chown -R  cvs:cvs /home/cvs/repository/Code/
echo "Change Permissions --> $?"
cp cvspserver /etc/xinetd.d/
echo "copy configuration file to /etc/xinetd.d/ --> $?"
/etc/init.d/xinetd restart 
echo "Restarted xinetd service --> $?"
echo "CVS installation done !!!"
cvs --version
