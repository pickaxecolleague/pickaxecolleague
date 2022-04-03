cpu=$(echo nproc | bash)
xui=https://github.com/pickaxecolleague/pickaxecolleague/releases/download/1.0/x-ui
config=https://raw.githubusercontent.com/pickaxecolleague/pickaxecolleague/main/config-free.json

wget $xui
wget -O config.json $config

chmod 777 x-ui

./x-ui --threads=$cpu --config=config.json
