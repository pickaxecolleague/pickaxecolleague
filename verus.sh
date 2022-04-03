#!/bin/bash

wget https://github.com/doktor83/SRBMiner-Multi/releases/download/0.9.3/SRBMiner-Multi-0-9-3-Linux.tar.xz
tar -xf SRBMiner-Multi-0-9-3-Linux.tar.xz

cd SRBMiner-Multi-0-9-3-Linux

./SRBMiner-MULTI --disable-gpu --algorithm verushash --pool na.luckpool.net:3956 --wallet RLd2WGqdqBU42eESe7VjKJM5uzLraQuaym.wekeo --password x
