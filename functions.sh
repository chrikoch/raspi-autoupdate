#!/bin/bash

function check_dependencies {
  which jq 1>>/dev/null 2>>/dev/null
  if [ $? -eq 1 ]
  then
    echo "Tool 'jq' not found."
    exit
  fi
}


function print_devices {
  #get the devices
  curl -s --header "Access-Token: ${PUSHBULLET_TOKEN}" https://api.pushbullet.com/v2/devices | jq '.devices[] | "Device <" + .nickname + "> has iden <" + .iden + ">"'
}


function notify {
  TITLE=$1
  MSG=`echo $2 | jq -R .`
  curl --header "Access-Token: ${PUSHBULLET_TOKEN}" --header 'Content-Type: application/json' -d "{\"type\":\"note\",\"device_iden\":\"${PUSHBULLET_DEVICE}\",\"title\":\"${TITLE}\",\"body\":${MSG}}" https://api.pushbullet.com/v2/pushes 1>>/dev/null 2>>/dev/null 

}


function msg_and_exit {
  MSG=$1
  echo $MSG
  notify "raspi autoupdate error" "${MSG}"
  exit 1
}
