#!/bin/bash

validate_input(){
    if [ $# -ne 1 ];then
        echo "Ошибка"
        exit 1
    fi

    if  [[ $1 != */ ]];then
        echo "Ошибка"
        exit 1
    fi
    if ! [[ -d "$1" ]];then
        echo "Ошибка"
        exit 1
    fi
}