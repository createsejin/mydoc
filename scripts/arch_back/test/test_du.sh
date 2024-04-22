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
test_root="/mnt/test_root"
if [ "$check_main" -eq 1 ]; then
  home="/home/bae"
  echo "home=$home"
  sys_root=""
  echo "sys_root=$sys_root/"
else
  home="/mnt/root/home/bae"
  echo "home=$home"
  sys_root="/mnt/root"
  echo "sys_root=$sys_root/"
fi
echo "test_root=$test_root/"

if [ -z "$1" ]; then
  du -h -a -d 1 --exclude-from=$home/Documents/scripts/arch_back/arch_backup_exc.txt \
    $test_root/
fi

