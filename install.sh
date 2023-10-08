#!/bin/sh

if [ $(whoami) == "root" ]; then
  if cp ./alma.sh /usr/bin/alma; then
    echo "Installed!"
  else
    echo "Something went wrong!"
  fi 
else
  echo "Please run the installer as root!"
fi
