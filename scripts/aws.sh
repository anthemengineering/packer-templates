#!/bin/bash

# Install cloud-init

# Disable updates so that packages are not updated for dependencies and the
# build is reasonably reproducible (not much we can do about the EPEL
# packages).
mkdir -p /media/cdrom
mount -t iso9660 -o ro /dev/cdrom /media/cdrom
yum -y install epel-release
yum --disablerepo=\* --enablerepo c6-media,base,extras,epel -y install \
    cloud-init \
    cloud-utils-growpart \
    dracut-modules-growroot \
    parted
umount /media/cdrom
rmdir /media/cdrom

yum clean all

rpm -qa kernel | sed 's/^kernel-//'  | xargs -I {} dracut -f /boot/initramfs-{}.img {}

passwd -d root
passwd -l root
