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
else
  home="/mnt/root/home/bae"
fi

cdd_func() {
  location="$1"
  cd "$location"
  ls -Al --color=auto
  echo "cd $location" | wl-copy
}

if [ "$1" = "vim-st" ]; then
  cdd_func "$home/.local/state/nvim"
fi
if [ "$1" = "vim-swap" ]; then
  cdd_func "$home/.local/state/nvim/swap"
fi
if [ "$1" = "vim-view" ]; then
  cdd_func "$home/.local/state/nvim/view"
fi
if [ "$1" = "se" ]; then
  cdd_func "$home/Documents/sessions"
fi
if [ "$1" = "d" ]; then
  cdd_func "$home/Documents"
fi
if [ "$1" = "sc" ]; then
  cdd_func "$home/Documents/scripts/.scripts"
fi
