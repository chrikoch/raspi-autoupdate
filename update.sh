#!/bin/bash

source ./functions.sh

check_dependencies


#set default
configfile="./config"

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

update_output=`apt-get -q update 2>&1`
if [ $? -ne 0 ]
then
  msg_and_exit "ERROR updating package lists. Need root access? ${update_output}"
fi


upgrade_output=`apt-get -qy upgrade 2>&1`
if [ $? -ne 0 ]
then
  msg_and_exit "ERROR upgrading packages. Need root access? ${upgrade_output}"
fi

echo ${upgrade_output}

PKG_HASH_AFTER=`apt list --installed 2>/dev/null| sha1sum`
if [ "${PKG_HASH_BEFORE}" != "${PKG_HASH_AFTER}" ]
then
  echo "some packages have been updated!"
  #TODO notify with output!
fi

#TODO Check for reboot 
