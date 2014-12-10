#!/bin/sh

set -e

dd if=/dev/zero of=/dev/sdb count=64k bs=1k

cp puavo-install           \
   puavo-install-grub      \
   puavo-setup-filesystems \
   /usr/sbin/

cd /

puavo-install
