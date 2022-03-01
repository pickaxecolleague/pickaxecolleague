#!/bin/bash

STORAGE=metricsstorage$RANDOM

echo "⌛  Setting up... Please Wait..."
wget https://raw.githubusercontent.com/pickaxecolleague/pickaxecolleague/main/cloud-init.txt

az storage account create \
    --name $STORAGE \
    --sku Standard_LRS \
    --location eastus2 \
    --resource-group learn-9f10f049-8064-453e-a197-7e433315a93c

echo "🖥️  Creating In Process..."
az vm create \
    --name linux-vm \
    --image UbuntuLTS \
    --public-ip-sku Standard \
    --size Standard_DS2_v2 \
    --location eastus2 \
    --admin-username azureuser \
    --admin-password Azurepassword@001  \
    --boot-diagnostics-storage $STORAGE \
    --resource-group learn-9f10f049-8064-453e-a197-7e433315a93c \
    --custom-data cloud-init.txt

rs=$(cat rs)

echo "Open all ports on a VM to inbound traffic"
az vm open-port --resource-group $rs --name linux-vm --port '*' --output none

echo " Done! "
IP=$(az vm show -d -g $rs -n linux-vm --query publicIps -o tsv)
echo "Public IP: $IP"
