#!/bin/bash
# читаем config

source "value.conf"
source "color.sh"
source "sys_info.sh"
a1=0
a2=0
a3=0
a4=0

if [ -z "$column1_background" ]; then
    a1=1
    column1_background=1
fi
if [ -z "$column1_font_color" ]; then
    a2=1
    column1_font_color=2
fi
if [ -z "$column2_background" ]; then
    a3=1
    column2_background=3
fi
if [ -z "$column2_font_color" ]; then
    a4=1
    column2_font_color=4
fi
# валидация
if [ "$column1_background" == $column1_font_color ]; then
    echo "Ошибка, цвет шрифта и фона совпадают , введите разные значения"
    exit 1
fi

if [ "$column2_background" == $column2_font_color ]; then
    echo "Ошибка, цвет шрифта и фона совпадают , введите разные значения"
    exit 1
fi

for i in "$column1_background" "$column1_font_color" "$column2_background" "$column2_font_color"; do
    if ! [[ "$i" =~ ^[1-6]$ ]]; then
        echo "Ошибка"
        exit 1
    fi
done

color_text() {
  case "$1" in
    1) echo "white" ;;
    2) echo "red" ;;
    3) echo "green" ;;
    4) echo "blue" ;;
    5) echo "purple" ;;
    6) echo "black" ;;
  esac
}

if [ $a1 == 1 ];then
    name_column1_background="default (white)"
else
    name_column1_background="$column1_background ($(color_text "$column1_background"))"
fi
if [ $a2 == 1 ];then
    name_column1_font_color="default (red)"
else
    name_column1_font_color="$column1_font_color ($(color_text "$column1_font_color"))"
fi
if [ $a3 == 1 ];then
    name_column2_background="default (green)"
else
    name_column2_background="$column2_background ($(color_text "$column2_background"))"
fi
if [ $a4 == 1 ];then
    name_column2_font_color="default (blue)"
else
    name_column2_font_color="$column2_font_color ($(color_text "$column2_font_color"))"
fi

print_sysinfo
echo ""
echo "Column 1 background = " "$name_column1_background"
echo "Column 1 font color = " "$name_column1_font_color"
echo "Column 2 background = " "$name_column2_background"
echo "Column2 font color = " "$name_column2_font_color"




