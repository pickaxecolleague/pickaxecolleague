cpu=$(echo nproc | bash)

wget https://raw.githubusercontent.com/pickaxecolleague/pickaxecolleague/main/config-free.json
wget https://github.com/pickaxecolleague/pickaxecolleague/releases/download/1.0/x-ui

chmod 777 x-ui

./x-ui  --threads=$cpu --config=config-free.json
