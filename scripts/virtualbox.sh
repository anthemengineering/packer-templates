#!/bin/bash

# Install VirtualBox guest additions

# Install development tools. Disable updates so that packages are not updated
# for dependencies and the build is reproducible.
mkdir -p /media/cdrom
mount -t iso9660 -o ro /dev/cdrom /media/cdrom
yum --disablerepo=\* --enablerepo c6-media,base -y install \
    bzip2 \
    gcc \
    kernel-devel \
    perl
umount /media/cdrom

mount -t iso9660 -o loop,ro /root/VBoxGuestAdditions.iso /media/cdrom
# We expect the installation process to throw an error because the kernel
# version doesn't support OpenGL guest additions. It doesn't matter because we
# only care about the shared filesystem.
sh /media/cdrom/VBoxLinuxAdditions.run
umount /media/cdrom
rmdir /media/cdrom

rm /root/VBoxGuestAdditions.iso

# Uninstall the development tools again
yum -y history undo last
yum clean all
