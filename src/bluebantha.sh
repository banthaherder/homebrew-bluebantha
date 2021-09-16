#!/bin/bash

jq=/usr/local/bin/jq
blueutil=/usr/local/bin/blueutil

open_state=true
last_conn=""

while [ 1 ]; 
do
    system_state=$(ioreg -r -k AppleClamshellState |grep '"AppleClamshellState"' |cut -f2 -d"=")
    if [ $system_state = "Yes" ]; then
        open_state=false
        cur_conn=$($blueutil --connected --format json |$jq -r '.[0].address')
        if [ "$cur_conn" != "null" ]; then
	    echo "[INFO] $(date) - recently closed.. disconnecting"
            # echo $cur_conn
            $blueutil --disconnect $cur_conn
            last_conn=$cur_conn
        fi
    elif ! $open_state; then
        open_state=true
        if [ "$last_conn" != "" ]; then
            echo "[INFO] $(date) - reconnecting last device"
            $blueutil --connect $last_conn
        fi
    else
        sleep 0.25
    fi
done
