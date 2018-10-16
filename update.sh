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


notify "Toller Titel" "Ich bin ein Test"

