#!/bin/bash
a=$1 
if [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Ошибка" 
else
    echo "$a"
fi
