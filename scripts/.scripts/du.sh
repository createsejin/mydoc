#!/bin/bash

check_file_exist() {
  if [ -f "$1" ]; then
    return 1
  else
    return 0
  fi
}
main_com_zsh="/home/bae/Documents/configs/.zshrc"
check_file_exist "$main_com_zsh"
check_main=$?
if [ "$check_main" -eq 1 ]; then
  home="/home/bae"
  echo "home=$home"
else
  home="/mnt/root/home/bae"
  echo "home=$home"
fi

if [ -z "$1" ]; then
  du -h -a -d 1 --exclude-from=$home/Documents/scripts/.scripts/du_exc.txt /
fi
