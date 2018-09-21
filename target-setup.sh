#!/bin/sh
# setup a 512MB ramdisk as target block device
modprobe zram
echo $((512*1024*1024)) > /sys/block/zram0/disksize

# setup nvme-tcp target with nqn "ramdisk"
modprobe nvmet_tcp
mkdir /sys/kernel/config/nvmet/subsystems/ramdisk
echo 1 > /sys/kernel/config/nvmet/subsystems/ramdisk/attr_allow_any_host
mkdir /sys/kernel/config/nvmet/subsystems/ramdisk/namespaces/1
echo -n /dev/zram0 > /sys/kernel/config/nvmet/subsystems/ramdisk/namespaces/1/device_path
echo 1 > /sys/kernel/config/nvmet/subsystems/ramdisk/namespaces/1/enable
mkdir /sys/kernel/config/nvmet/ports/1
echo "ipv4" > /sys/kernel/config/nvmet/ports/1/addr_adrfam
echo "tcp" > /sys/kernel/config/nvmet/ports/1/addr_trtype
echo "11345" > /sys/kernel/config/nvmet/ports/1/addr_trsvcid
echo "192.168.33.10" > /sys/kernel/config/nvmet/ports/1/addr_traddr
ln -s /sys/kernel/config/nvmet/subsystems/ramdisk /sys/kernel/config/nvmet/ports/1/subsystems/ramdisk
