#!/bin/bash

check_file_exist() {
  if [ -f "$1" ]; then
    return 1
  else
    return 0
  fi
}
home="/data/data/com.termux/files/home"

cdd_func() {
  location="$1"
  cd "$location"
  ls -Al --color=auto
}
# variables
vim_st="$home/.local/state/nvim"
vim_swap="$home/.local/state/nvim/swap"
vim_view="$home/.local/state/nvim/view"
se="$home/doc/sessions"
doc="$home/doc"
script="$home/doc/android/scripts/.scripts"
obsidian="$home/storage/shared/ob-git"

if [ "$1" = "help" ]; then
  echo "vim-st: $vim_st"
  echo "vim-swap: $vim_swap"
  echo "vim-view: $vim_view"
  echo "se: $se"
  echo "d: $doc"
  echo "sc: $script"
  echo "ob: $obsidian"
  echo "to move dir, press <leader>p in tmux"
fi

if [ "$1" = "vim-st" ]; then
  cdd_func $vim_st
fi
if [ "$1" = "vim-swap" ]; then
  cdd_func $vim_swap
fi
if [ "$1" = "vim-view" ]; then
  cdd_func $vim_view
fi
if [ "$1" = "se" ]; then
  cdd_func $se
fi
if [ "$1" = "d" ]; then
  cdd_func $doc
fi
if [ "$1" = "sc" ]; then
  cdd_func $script
fi
if [ "$1" = "ob" ]; then
  cdd_func $obsidian
fi
