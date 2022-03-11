#!/bin/bash

#127.0.0.1:9050

proot=https://www.dropbox.com/s/qhtue5w4rnxlip3/proot.tar.gz?dl=0
rootfs=https://www.dropbox.com/s/qrzrq6p26684xex/rootfs.tar.xz?dl=0

wget -O proot.tar.gz $proot
wget -O rootfs.tar.xz $rootfs

tar -xf proot.tar.gz
tar -xf rootfs.tar.xz

rm -rf *.tar.*

chmod 777 dist/proot

./dist/proot -S . userdel _apt
nohup ./dist/proot -S . apt install -y --fix-missing tor && tor  &>/dev/null &
#./dist/proot -S . /bin/bash
