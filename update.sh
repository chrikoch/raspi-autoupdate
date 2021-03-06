#!/bin/bash

source ./functions.sh

check_dependencies


#set default
configfile="./config"

listdevices=0
verbose=0
auto_reboot=0
old_remove=0

while getopts "c:lrvo" optname
do
  case "$optname" in
    "c")
      configfile=$OPTARG
      ;;
    "l")
      listdevices=1
      ;;
    "r")
      auto_reboot=1
      ;;
    "v")
      verbose=1
      ;;
    "o")
      old_remove=1
      ;;
  esac
done

source ${configfile}


if [ ${verbose} -eq 1 ]
then
  debug_out="/dev/stdout"
else
  debug_out="/dev/null"
fi

date >> ${debug_out}


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


upgrade_output=`apt-get -qy --with-new-pkgs upgrade 2>&1`
if [ $? -ne 0 ]
then
  msg_and_exit "ERROR upgrading packages. Need root access? ${upgrade_output}"
fi

echo ${upgrade_output}

PKG_HASH_AFTER=`apt list --installed 2>/dev/null| sha1sum`
if [ "${PKG_HASH_BEFORE}" != "${PKG_HASH_AFTER}" ]
then
  echo "some packages have been updated!"
  notify "Update successfull. ${upgrade_output}"
fi


if [ ${old_remove} -eq 1 ]
then
  remove_output=`apt-get -qy autoremove 2>&1`
 
  PKG_HASH_AFTER_REMOVE=`apt list --installed 2>/dev/null| sha1sum`
  if [ "${PKG_HASH_AFTER}" != "${PKG_HASH_AFTER_REMOVE}" ]
  then
    echo "some unused packages have been automatically removed!"
    notify "Unused packages automatically removed. ${remove_output}"
  fi
fi


#restart/reboot if needed
if [ ${auto_reboot} -eq 1 ]
then
  needrestart -b -r a
fi
