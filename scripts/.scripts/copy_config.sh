#!/bin/bash
shopt -s dotglob

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
  sys_root=""
  echo "sys_root=$sys_root/"
else
  home="/mnt/root/home/bae"
  echo "home=$home"
  sys_root="/mnt/root"
  echo "sys_root=$sys_root/"
fi

if [ "$1" = "root" ] && [ "$check_main" -eq 1 ]; then
  sudo cp $home/Documents/root_configs/.zshrc $sys_root/root/ 
  sudo cp $home/Documents/root_configs/.oh-my-zsh/themes/xiong-chiamiov-plus.zsh-theme \
    $sys_root/root/.oh-my-zsh/themes
  sudo cp $home/Documents/configs/.config/tmux/tmux.conf $sys_root/root/.config/tmux/
  sudo cp $home/.config/nvimt/init.vim $sys_root/root/.config/nvimt/
  sudo cp $home/.config/nvim/init.vim $sys_root/root/.config/nvim/
elif [ "$1" = "root" ] && [ "$check_main" -eq 0 ]; then 
  echo "This is not main_com. exit script"
fi

if [ "$1" = "tmux" ]; then
  cp $home/Documents/configs/.config/tmux/tmux.conf $home/.config/nvim/
fi
if [ "$1" = "init" ]; then
  sudo cp $home/Documents/scripts/init_live $sys_root/
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
    echo "backup scripts copyed to /mnt/sysback/scripts/"
  fi
fi

if [ "$1" = "arch_back_test" ]; then
  check_file_exist "$exclude_file"
  file_exist=$?
  if [ $file_exist -eq 0 ]; then
    echo "mount /dev/Files/sys_back to /mnt/sys_back please."
    echo "file copy command aborted."
    echo "you can mount using this scripts."
    echo "use 'copy_config.sh -m'"
  else
    cd "$home/Documents/scripts/arch_back"
    sudo cp arch_backup_exc.txt /mnt/sys_back/scripts
    cd "$home/Documents/scripts/arch_back/test"
    sudo cp arch_backup_test.sh arch_restore_test.sh '/mnt/sys_back/scripts/test'
    echo "backup test scripts copyed to /mnt/sysback/scripts/test/"
  fi
fi

if [ "$1" = "-m" ]; then
  sudo mount --mkdir /dev/Files/sys_back /mnt/sys_back
  echo "/dev/Files/sys_back mounted to /mnt/sys_back"
fi

