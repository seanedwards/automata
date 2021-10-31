#!/usr/bin/env bash

set -e

CMD="$1"
DISK="$2"

case "$CMD" in
repartition)
	sgdisk -Z $DISK
	# EFI boot partition
	sgdisk -n2:1M:+512M -t3:EF00 "$DISK"
	# ZFS partition
	sgdisk -n1:0:0 -t1:BF01 "$DISK"

	mkfs.vfat "$DISK-part2"

	zpool create -f -o ashift=12      \
		-O acltype=posixacl       \
		-O relatime=on            \
		-O xattr=sa               \
		-O dnodesize=legacy       \
		-O normalization=formD    \
		-O mountpoint=none        \
		-O canmount=off           \
		-O devices=off            \
		-R /mnt                   \
		-O compression=lz4        \
		-O encryption=aes-256-gcm \
		-O keyformat=passphrase   \
		-O keylocation=prompt     \
		rpool "$DISK-part1"

	zfs create -o mountpoint=legacy rpool/root
	zfs create -o mountpoint=legacy rpool/root/nixos
	zfs create -o mountpoint=legacy rpool/home
	;;

mount)
	mount -t zfs rpool/root/nixos /mnt

	mkdir -p /mnt/home
	mount -t zfs rpool/home /mnt/home

	mkdir -p /mnt/boot
	mount "$DISK-part2" /mnt/boot
	;;

*)
	echo "Usage: $0 <partition|mount> <disk-by-id>"
	;;
esac

