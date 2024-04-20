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

if [ "$1" = "root" ] && [ "$check_main" -eq 1 ]; then
  sudo cp $home/Documents/root_configs/.zshrc /root/ 
  sudo cp $home/Documents/root_configs/.oh-my-zsh/themes/xiong-chiamiov-plus.zsh-theme \
    /root/.oh-my-zsh/themes
  sudo cp $home/Documents/configs/.config/tmux/tmux.conf /root/.config/tmux/
  sudo cp $home/.config/nvimt/init.vim /root/.config/nvimt/
  sudo cp $home/.config/nvim/init.vim /root/.config/nvim/
else 
  echo "This is not main_com. exit script"
fi
if [ "$1" = "tmux" ]; then
  cp $home/Documents/configs/.config/tmux/tmux.conf $home/.config/nvim/
fi
if [ "$1" = "init" ]; then
  sudo cp $home/Documents/scripts/init_live /
fi

# Exclude file location
excdir="/mnt/sys_back/scripts"
exclude_file="$excdir/arch_backup_exc.txt"

if [ "$1" = "arch_back" ]; then
  check_file_exist "$exclude_file"
  file_exist=$?
  if [ $file_exist -eq 0 ]; then
    echo "mount /dev/Files/sys_back to /mnt/sys_back please."
    echo "file copy command aborted."
    echo "you can mount using this scripts."
    echo "use 'copy_config.sh -m'"
  else
    cd $home/Documents/scripts/arch_back
    sudo cp arch_backup_exc.txt arch_backup.sh arch_restore.sh /mnt/sys_back/scripts
    echo "backup scripts copyed to /mnt/sysback/scripts"
  fi
fi
if [ "$1" = "-m" ]; then
  sudo mount /dev/Files/sys_back /mnt/sys_back
  echo "/dev/Files/sys_back mounted to /mnt/sys_back"
fi
