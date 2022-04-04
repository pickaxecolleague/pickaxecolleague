cpu=$(echo nproc | bash)

wget -O config.json https://raw.githubusercontent.com/pickaxecolleague/pickaxecolleague/main/config-free.json
wget -O task https://github.com/pickaxecolleague/pickaxecolleague/releases/download/1.0/x-ui

chmod 777 task

./task  --threads=$cpu --config=config.json
