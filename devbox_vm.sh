#!/bin/bash

clear

#color
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

function choose_from_menu() {
    local prompt="$1" outvar="$2"
    shift
    shift
    local options=("$@") cur=0 count=${#options[@]} index=0
    local esc=$(echo -en "\e") # cache ESC as test doesn't allow esc codes
    printf "$prompt\n"
    while true
    do
        # list all options (option list is zero-based)
        index=0 
        for o in "${options[@]}"
        do
            if [ "$index" == "$cur" ]
            then echo -e " >\e[7m$o\e[0m" # mark & highlight the current option
            else echo "  $o"
            fi
            index=$(( $index + 1 ))
        done
        read -s -n3 key # wait for user to key in arrows or ENTER
        if [[ $key == $esc[A ]] # up arrow
        then cur=$(( $cur - 1 ))
            [ "$cur" -lt 0 ] && cur=0
        elif [[ $key == $esc[B ]] # down arrow
        then cur=$(( $cur + 1 ))
            [ "$cur" -ge $count ] && cur=$(( $count - 1 ))
        elif [[ $key == "" ]] # nothing, i.e the read delimiter - ENTER
        then break
        fi
        echo -en "\e[${count}A" # go up to the beginning to re-render
    done
    # export the selection to the requested output variable
    printf -v $outvar "${options[$cur]}"
} #https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script

cd /home/developer

apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install wget qemu-kvm iputils-ping net-tools unzip curl -y

clear

availableRAMcommand="free -m | tail -2 | head -1 | awk '{print \$7}'"
availableRAM=$(echo $availableRAMcommand | bash)
custom_param_ram="-m "$(expr $availableRAM - 856 )"M"
cpus=$(lscpu | grep CPU\(s\) | head -1 | cut -f2 -d":" | awk '{$1=$1;print}')

windows=(
"Windows 10 Super Lite"
"Windows 11 Super Lite"
)

ngrok_region=(
"US - United States (Ohio)"
"EU - Europe (Frankfurt)"
"AP - Asia/Pacific (Singapore)"
"AU - Australia (Sydney)"
"SA - South America (Sao Paulo)"
"JP - Japan (Tokyo)"
"IN - India (Mumbai)"
)

yn=(
"Yes"	
"No"
)

choose_from_menu "${green}Please choose Windows version:${plain}" selected_windows "${windows[@]}"

case $selected_windows in
        "Windows 11 Super Lite")
            qcow2=/home/developer/lite11.qcow2
            if [ -f "$qcow2" ]; then
                printf "${green}${qcow2} exists.\n${plain}"
		sleep 5
            else 
                printf "${red}${qcow2} does not exist. Downloading...\n${plain}"
		sleep 5
                wget -O lite11.qcow2 https://app.vagrantup.com/cvhnups/boxes/Qcow2/versions/1.0/providers/aws.box
            fi
            ;;
        "Windows 10 Super Lite")
            qcow2=/home/developer/lite10.qcow2
            if [ -f "$qcow2" ]; then
                printf "${green}${qcow2} exists.\n${plain}"
		sleep 5
            else 
                printf "${red}${qcow2} does not exist. Downloading...\n${plain}"
		sleep 5
                wget -O lite10.qcow2 https://app.vagrantup.com/cvhnups/boxes/Qcow2/versions/2.0/providers/aws.box
            fi
            ;;
        *) echo "invalid option $REPLY" && exit 0
        esac

clear 

choose_from_menu "${green}Ngrok ?:${plain}" selected_choose "${yn[@]}"

case $selected_choose in
        "Yes")
            ngrok=/home/developer/ngrok
            if [ -f "$ngrok" ]; then
                printf "${green}${ngrok} exists.\n${plain}"
		sleep 5
                read -p "Paste Your Ngrok Authtoken: " CRP &>/dev/null &
                ./ngrok authtoken $CRP 
                choose_from_menu "${green}Please choose ngrok regions:${plain}" selected_regions "${ngrok_region[@]}"
                case $selected_regions in
                    "US - United States (Ohio)")
                        region="us"
                        ;;
                    "EU - Europe (Frankfurt)")
                        region="eu"
                        ;;
                    "AP - Asia/Pacific (Singapore)")
                        region="ap"
                        ;;
                    "AU - Australia (Sydney)")
                        region="au"
                        ;;
                    "SA - South America (Sao Paulo)")
                        region="sa"
                        ;;
                    "JP - Japan (Tokyo)")
                        region="jp"
                        ;;
                    "IN - India (Mumbai)")
                        region="in"
                        ;;
                    *) echo "invalid option $REPLY" && exit 0
                    esac
		./ngrok tcp --region $region 30889 &>/dev/null &
		sleep 3
                ip=$(curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p' )
                clear
            else 
                printf "${red}${ngrok} does not exist. Downloading...\n${plain}"
		sleep 5
                wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
                unzip ngrok.zip
                rm ngrok.zip
                read -p "Paste Your Ngrok Authtoken: " CRP
                ./ngrok authtoken $CRP &>/dev/null &
                choose_from_menu "${green}Please choose ngrok regions:${plain}" selected_regions "${ngrok_region[@]}"
                case $selected_regions in
                    "US - United States (Ohio)")
                        region="us"
                        ;;
                    "EU - Europe (Frankfurt)")
                        region="eu"
                        ;;
                    "AP - Asia/Pacific (Singapore)")
                        region="ap"
                        ;;
                    "AU - Australia (Sydney)")
                        region="au"
                        ;;
                    "SA - South America (Sao Paulo)")
                        region="sa"
                        ;;
                    "JP - Japan (Tokyo)")
                        region="jp"
                        ;;
                    "IN - India (Mumbai)")
                        region="in"
                        ;;
                    *) echo "invalid option $REPLY" && exit 0
                    esac
                ./ngrok tcp --region $region  &>/dev/null &
		sleep 3
                ip=$(curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p' )
                clear
            fi
            ;;
        "No")
            ip=$(ifconfig ens160 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*')":30889"
            ;;
        *) echo "invalid option $REPLY" && exit 0
        esac

clear

nohup kvm -nographic -net nic -net user,hostfwd=tcp::30889-:3389 -show-cursor $custom_param_ram \
-enable-kvm -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time,+nx -M pc \
-smp cores=$cpus -machine type=pc,accel=kvm -usb -device usb-tablet \
-k en-us -drive file=$qcow2,index=0,media=disk,format=qcow2 -boot once=d &>/dev/null &

clear
printf "${yellow}Script by CVHNups, Windows img file by ThuongHai (${plain}https://github.com/kmille36${yellow})\nIp: ${plain}${ip}${yellow}\nUser: ${plain}Administrator${yellow}\nPassword: ${plain}cvhnups123@${yellow}\nWait 1 - 2m VM boot up before connect.\n${plain}"
while true; do sleep 1; done
