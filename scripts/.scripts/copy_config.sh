#!/bin/bash
if [ "$1" = "root" ]; then
  sudo cp /home/bae/Documents/root_configs/.zshrc /root/ 
  sudo cp /home/bae/Documents/root_configs/.oh-my-zsh/themes/xiong-chiamiov-plus.zsh-theme \
    /root/.oh-my-zsh/themes
  sudo cp /home/bae/Documents/configs/.config/tmux/tmux.conf /root/.config/tmux/
  sudo cp /home/bae/.config/nvimt/init.vim /root/.config/nvimt/
  sudo cp /home/bae/.config/nvim/init.vim /root/.config/nvim/
fi
if [ "$1" = "arch_back" ]; then
  cd /home/bae/Documents/scripts/arch_back
  sudo cp arch_backup_exc.txt arch_backup.sh arch_restore.sh /mnt/sys_back
fi
