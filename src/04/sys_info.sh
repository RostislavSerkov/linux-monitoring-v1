#!/bin/bash

collect_info() {
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
    GATEWAY=$(ip r| awk '/default/ {print $3}')
    RAM_TOTAL=$(cat /proc/meminfo | awk '/MemTotal/ {printf "%.3f GB\n", $2/1024/1024}')
    RAM_USED=$(cat /proc/meminfo | awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END {printf "%.3f", (t-a)/1024/1024}' )
    RAM_FREE=$(cat /proc/meminfo | awk '/MemAvailable/ {printf "%.3f GB\n", $2/1024/1024}' )
    SPACE_ROOT=$(df / | awk 'NR==2 {printf "%.2f MB", $2/1024}')
    SPACE_ROOT_USED=$(df / | awk 'NR==2 {printf "%.2f MB", $3/1024}')
    SPACE_ROOT_FREE=$(df / | awk 'NR==2 {printf "%.2f MB", $4/1024}')

    PREFIX=$(ip -o -f inet addr show scope global | awk 'NR==1 {split($4,a,"/"); print a[2]}')
    cidr_to_mask() {
    local p=$1
    local mask="" oct i
    for i in 1 2 3 4; do
        if ((p >= 8)); then
        oct=255
        p=$((p-8))
        elif ((p > 0)); then
        oct=$((256 - 2**(8-p)))
        p=0
        else
        oct=0
        fi
        mask+=$oct
        [[ $i -lt 4 ]] && mask+="."
    done
    echo "$mask"
    }

    MASK=$(cidr_to_mask "$PREFIX")
}

print_sysinfo() {
    local p1=$column1_background p2=$column1_font_color p3=$column2_background p4=$column2_font_color
    collect_info

    printe "HOSTNAME"        "$HOSTNAME"        $p1 $p2 $p3 $p4
    printe "TIMEZONE"        "$TIMEZONE"        $p1 $p2 $p3 $p4
    printe "USER"            "$USER"            $p1 $p2 $p3 $p4
    printe "OS"              "$OS"              $p1 $p2 $p3 $p4
    printe "DATE"            "$DATE"            $p1 $p2 $p3 $p4
    printe "UPTIME"          "$UPTIME"          $p1 $p2 $p3 $p4
    printe "UPTIME_SEC"      "$UPTIME_SEC"      $p1 $p2 $p3 $p4
    printe "IP"              "$IP"              $p1 $p2 $p3 $p4
    printe "MASK"            "$MASK"            $p1 $p2 $p3 $p4
    printe "GATEWAY"         "$GATEWAY"         $p1 $p2 $p3 $p4
    printe "RAM_TOTAL"       "$RAM_TOTAL"       $p1 $p2 $p3 $p4
    printe "RAM_USED"        "$RAM_USED"        $p1 $p2 $p3 $p4
    printe "RAM_FREE"        "$RAM_FREE"        $p1 $p2 $p3 $p4
    printe "SPACE_ROOT"      "$SPACE_ROOT"      $p1 $p2 $p3 $p4
    printe "SPACE_ROOT_USED" "$SPACE_ROOT_USED" $p1 $p2 $p3 $p4
    printe "SPACE_ROOT_FREE" "$SPACE_ROOT_FREE" $p1 $p2 $p3 $p4
}