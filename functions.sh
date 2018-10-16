#!/bin/bash

function print_devices {
  #check dependencies
  which jq 1>>/dev/null 2>>/dev/null
  if [ $? -eq 1 ]
  then
    echo "Tool 'jq' not found."
    exit
  fi


  #get the devices
  curl -s --header "Access-Token: ${PUSHBULLET_TOKEN}" https://api.pushbullet.com/v2/devices | jq '.devices[] | "Device <" + .nickname + "> has iden <" + .iden + ">"'

}
