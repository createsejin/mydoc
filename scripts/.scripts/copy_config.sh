#!/bin/bash
if [ "$1" = "root" ]; then
  sudo cp /home/bae/Documents/root_configs/.zshrc /root/ 
  sudo cp /home/bae/Documents/root_configs/.oh-my-zsh/themes/xiong-chiamiov-plus.zsh-theme \
    /root/.oh-my-zsh/themes
  sudo cp /home/bae/Documents/configs/.config/tmux/tmux.conf /root/.config/tmux/
  sudo cp /home/bae/.config/nvim/init.vim /root/.config/nvimt/
fi
if [ "$1" = "arch_back" ]; then
  echo "arch_back scripts copy"
fi
# TODO: copy to nvimt, tmux conf files

