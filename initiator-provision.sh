#!/bin/sh
rpm -i --nodeps /vagrant/nvme-1.6-1.el7.x86_64.rpm
yum install -y /vagrant/kernel-4.18.0_rc6+-1.x86_64.rpm
grubby --set-default=/boot/vmlinuz-4.18.0-rc6+
reboot
