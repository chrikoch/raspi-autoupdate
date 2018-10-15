#/bin/bash

#set default
configfile="config"


while getopts "c:" optname
do
  case "$optname" in
    "c")
      configfile=$OPTARG
      ;;
  esac
done

source ${configfile}

curl --header "Access-Token: ${PUSHBULLET_TOKEN}" --header 'Content-Type: application/json' -d "{\"type\":\"note\",\"device_iden\":\"${PUSHBULLET_DEVICE}\",\"title\":\"abc\",\"body\":\"Inhalt\"}" https://api.pushbullet.com/v2/pushes
