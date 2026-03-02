#!/bin/bash

collect_info() {
sudo apt install -y net-tools
    HOSTNAME=$(hostname)  
    TIME_ZON1=$(cat /etc/timezone)
    TIME_ZON2=$(date +%z | sed 's/\([+-]\)0*\([0-9]*\)00/\1\2/')
    TIMEZONE="$TIME_ZON1 UTC $TIME_ZON2"
    USER=$(whoami)
    OS=$(cat /etc/os-release | grep '^PRETTY_NAME='| cut -d'=' -f2 | tr -d '"')
    DATE=$(date +'%d%B%Y %H:%M:%S')
    UPTIME=$(uptime -p)
    UPTIME_SEC=$(cat /proc/uptime | cut -d'.' -f1)
    IP=$(ip -4 addr show | grep 'inet'| grep '127.0.0.1'|awk '{print $2}'| cut -d'/' -f1)
    MASK=$(ifconfig | awk '/netmask/ && !/127\.0\.0\.1/ {print $4; exit}')
    GATEWAY=$(ip r| awk '/default/ {print $3}')
    RAM_TOTAL=$(cat /proc/meminfo | awk '/MemTotal/ {printf "%.3f GB\n", $2/1024/1024}')
    RAM_USED=$(cat /proc/meminfo | awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {printf "%.3f", (t-a)/1024/1024}' )
    RAM_FREE=$(cat /proc/meminfo | awk '/MemAvailable/ {printf "%.3f GB\n", $2/1024/1024}' )
    SPACE_ROOT=$(df / | awk 'NR==2 {printf "%.2f MB", $2/1024}')
    SPACE_ROOT_USED=$(df / | awk 'NR==2 {printf "%.2f MB", $3/1024}')
    SPACE_ROOT_FREE=$(df / | awk 'NR==2 {printf "%.2f MB", $4/1024}')
}
