#!/bin/bash

#NAME="$(cd "$(dirname "$0")" && pwd)"
source "color.sh"
source "sys_info.sh"

if [ "$#" -ne 4 ];then
    echo "Ошибка"
    exit 1
fi

if [ "$1" == $2 ]; then
    echo "Ошибка"
    exit 1
fi

if [ "$3" == $4 ]; then
    echo "Ошибка, цвет шрифта и фона совпадают , введите разные значения"
    exit 1
fi

for i in "$1" "$2" "$3" "$4"; do
    if ! [[ "$i" =~ ^[1-6]$ ]]; then
        echo "Ошибка, цвет шрифта и фона совпадают , введите разные значения"
        exit 1
    fi
done

print_sysinfo "$1" "$2" "$3" "$4"