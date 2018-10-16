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


#we want to know wheter updates have been installed, so check for currently installed packages:
PKG_HASH_BEFORE=`apt list --installed 2>/dev/null| sha1sum`

echo ${PKG_HASH_BEFORE}

apt-get update
if [ $? -ne 0 ]
then
  msg_and_exit "ERROR updating package lists. Need root access?"
fi



notify "Toller Titel" "Ich bin ein Test"

