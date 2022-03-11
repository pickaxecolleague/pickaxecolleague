#!/bin/bash

#127.0.0.1:9050

proot=https://www.dropbox.com/s/q171q1igu70mdls/proot.tar.gz?dl=0

wget -O proot.tar.gz $proot

tar -xf proot.tar.gz

rm -rf *.tar.*

chmod 777 dist/proot

nohup ./dist/proot -S . tor  &>/dev/null &
#./dist/proot -S . /bin/bash
