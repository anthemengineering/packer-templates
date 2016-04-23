#!/bin/bash

# Configure box for Vagrant

# Create vagrant user
groupadd vagrant -g 500
useradd vagrant -u 500 -g vagrant

# Set insecure SSH keypair to bootstrap vagrant - see
# <https://github.com/mitchellh/vagrant/tree/master/keys> for details.
mkdir /home/vagrant/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key' > /home/vagrant/.ssh/authorized_keys
chmod 700 /home/vagrant/.ssh
chown -R vagrant:vagrant /home/vagrant/.ssh

# Allow vagrant to sudo; disable requiring real tty so that vagrant tool can
# run commands as root
echo "Defaults:vagrant !requiretty" > /etc/sudoers.d/vagrant
echo "vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant

# vagrant user exists and can sudo; remove temporary root password.
passwd -d root
passwd -l root
