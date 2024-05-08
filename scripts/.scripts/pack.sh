#!/bin/bash

filepath="/home/bae/Documents/packs/Pack009.hc"
diskF=/dev/sda2
diskP=/dev/sdb2
diskS=/dev/sdc2

if [ $# -eq 0 ]; then
  sudo veracrypt -t -m ro -k "" --pim=0 --protect-hidden=no "$filepath" /mnt/pack009
elif [ "$1" = "-d" ] && [ $# -eq 1 ]; then
  sudo veracrypt -d "$filepath"
elif [ "$1" = "-da" ]; then
  sudo veracrypt -d
elif [ "$1" = "-fd" ]; then
  sudo veracrypt -d -f "$filepath"
elif [ "$1" = "-d" ] && [ "$2" = "S" ]; then
  sudo veracrypt -d $diskS
elif [ "$1" = "-d" ] && [ "$2" = "F" ]; then
  sudo veracrypt -d $diskF
elif [ "$1" = "-d" ] && [ "$2" = "P" ]; then
  sudo veracrypt -d $diskP
elif [ "$1" = "-w" ]; then
  sudo veracrypt -t -k "" --pim=0 --protect-hidden=no "$filepath" /mnt/pack009
elif [ "$1" = "-m" ] && [ "$2" = "S" ]; then
  sudo veracrypt -t -k /mnt/pack009/Keyfiles/diskS --pim=0 --protect-hidden=no $diskS /mnt/S
elif [ "$1" = "-m" ] && [ "$2" = "Q" ]; then
  sed -n 4p "/mnt/pack009/PnQ Key.txt" | wl-copy
  echo "diskQ key copied to clipboard."
  echo "You should clean up the clipboard after use."
elif [ "$1" = "-m" ] && [ "$2" = "F" ]; then
  sudo veracrypt -t -k /mnt/pack009/Keyfiles/diskF --pim=0 --protect-hidden=no $diskF /mnt/F
elif [ "$1" = "-m" ] && [ "$2" = "P" ]; then
  sudo veracrypt -t -k /mnt/pack009/Keyfiles/diskP02 --pim=0 --protect-hidden=no $diskP /mnt/P
fi
