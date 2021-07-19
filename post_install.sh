#!/bin/sh

# Download the Prowlarr software (assuming acceptance of the EULA):
echo -n "Downloading the Prowlarr software..."
fetch "http://prowlarr.servarr.com/v1/update/develop/updatefile?os=linux&runtime=netcore&arch=x64" -o /usr/local/share/tmp.tar.gz

# Unpack the archive into the /usr/local/share directory:
echo -n "Installing Prowlarr in /usr/local/share..."
tar -xzvf /usr/local/share/tmp.tar.gz -C /usr/local/share

# remove unnecessary files
rm /usr/local/share/tmp.tar.gz

# Create user
pw user add prowlarr -c prowlarr -u 1059 -d /nonexistent -s /usr/bin/nologin

# make "prowlarr" the owner of the install location
mkdir /config
chown -R prowlarr:prowlarr /usr/local/share/Prowlarr /config

#Set write permission to be able to write plugins update
chmod 755 /usr/local/share/Prowlarr

# Start the services
chmod u+x /etc/rc.d/prowlarr
sysrc -f /etc/rc.conf prowlarr_enable="YES"
service prowlarr start

echo "Prowlarr successfully installed" > /root/PLUGIN_INFO