#!/bin/sh
rpm -i --nodeps /vagrant/nvme-*.rpm
yum install -y /vagrant/kernel-*.rpm
grubby --set-default="$(rpm -qpl /vagrant/kernel-*.rpm|grep /boot/vmlinuz)"
reboot
