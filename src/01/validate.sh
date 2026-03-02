#!/bin/bash
validate_param(){
    if [[ $# =~ 0 ]]; then
        echo "Ошибка"
        exit 1
    fi

    if [[ $# -gt 1 ]]; then
        echo "Ошибка"
        exit 1
    fi

    if [[ $1 =~ ^-?[0-9]+([.]+[0-9])?$ ]]; then
        echo "Ошибка"
        exit 1
    fi
}