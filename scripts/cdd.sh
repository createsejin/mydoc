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

if [ "$1" = "vim-st" ]; then
  location="$home/.local/state/nvim"
  cd "$location"
  ls -Al --color=auto
  echo "cd $location" | wl-copy
fi
if [ "$1" = "vim-swap" ]; then
  location="$home/.local/state/nvim/swap"
  cd $location
  ls -Al --color=auto
  echo "cd $location" | wl-copy
fi
if [ "$1" = "vim-view" ]; then
  location="$home/.local/state/nvim/view"
  cd $location
  ls -Al --color=auto
  echo "cd $location" | wl-copy
fi
if [ "$1" = "se" ]; then
  location="$home/Documents/sessions"
  cd $location
  ls -Al --color=auto
  echo "cd $location" | wl-copy
fi
if [ "$1" = "d" ]; then
  location="$home/Documents"
  cd $location
  ls -Al --color=auto
  echo "cd $location" | wl-copy
fi
if [ "$1" = "sc" ]; then
  location="$home/Documents/scripts/.scripts"
  cd $location
  ls -Al --color=auto
  echo "cd $location" | wl-copy
fi
