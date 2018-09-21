#!/bin/sh
yum install -y /vagrant/kernel-4.18.0_rc6+-1.x86_64.rpm
grubby --set-default=/boot/vmlinuz-4.18.0-rc6+
reboot
