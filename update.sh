#/bin/bash

source functions.sh

#set default
configfile="config"

listdevices=0

while getopts "c:l" optname
do
  case "$optname" in
    "c")
      configfile=$OPTARG
      ;;
    "l")
      listdevices=1
      ;;
  esac
done

source ${configfile}

if [ ${listdevices} -eq 1  ]
then
  print_devices
  exit
fi

curl --header "Access-Token: ${PUSHBULLET_TOKEN}" --header 'Content-Type: application/json' -d "{\"type\":\"note\",\"device_iden\":\"${PUSHBULLET_DEVICE}\",\"title\":\"abc\",\"body\":\"Inhalt\"}" https://api.pushbullet.com/v2/pushes

