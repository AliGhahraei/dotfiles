#!/bin/sh
MSG_GREEN='\033[0;32m'
MSG_RED='\033[0;31m'
MSG_END='\033[0m'

msg(){
    # shellcheck disable=SC2059
    printf "\n$MSG_GREEN$1$MSG_END\n"
}

error_msg(){
    # shellcheck disable=SC2059
    printf "\n$MSG_RED$1$MSG_END\n"
}
