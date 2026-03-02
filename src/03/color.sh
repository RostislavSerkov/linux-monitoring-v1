#!/bin/bash

color_code() {
    case $1 in
        1) echo 37 ;;
        2) echo 31 ;;
        3) echo 32 ;;
        4) echo 34 ;;
        5) echo 35 ;;
        6) echo 30 ;;
    esac
}

color_fone() {
    case $1 in
        1) echo 47 ;;
        2) echo 41 ;;
        3) echo 42 ;;
        4) echo 44 ;;
        5) echo 45 ;;
        6) echo 40 ;;
    esac
}

printe(){
    local key="$1"
    local val="$2"
    local f1_code=$(color_fone "$3")
    local c1_code=$(color_code "$4")
    local f2_code=$(color_fone "$5")
    local c2_code=$(color_code "$6")
    local reset="\e[0m"

    printf "\e[${f1_code};${c1_code}m%-15s${reset}\e[${f2_code};${c2_code}m%-25s${reset}\n" "$key" "$val"
}


