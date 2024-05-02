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
}

cdd_ls_func() {
  location="$1"
  ls -Al --color=auto $location
}

cdd_and_cdv() {
  sub_cmd="$1"
  location="$2"
  if [ "$1" = "-d" ] && [ "$2" = "$sub_cmd" ]; then
    cdd_func $location
  fi
  if [ "$1" = "-v" ] && [ "$2" = "$sub_cmd" ]; then
    cdd_ls_func $location
  fi
  if [[ "$location" == "$home"* ]]; then
    location="~${location#$home}"
    locations+=($location)
  fi
}

# variables 
#@#var
vim="$home/.config/nvim"
vimt="$home/.config/nvimt"
vim_st="$home/.local/state/nvim"
vim_swap="$home/.local/state/nvim/swap"
vim_view="$home/.local/state/nvim/view"
se="$home/Documents/sessions"
doc="$home/Documents"
script="$home/Documents/scripts/.scripts"
obsidian="$home/Obsidian"

help_msg() {
  #@#help
  echo "vim: $vim"
  echo "vimt: $vimt"
  echo "vim-st: $vim_st"
  echo "vim-st: $vim_st"
  echo "vim-swap: $vim_swap"
  echo "vim-view: $vim_view"
  echo "se: $se"
  echo "d: $doc"
  echo "sc: $script"
  echo "ob: $obsidian"
}

declare -a locations

if [ "$1" = "help" ]; then
  help_msg
fi
if [ "$1" = "-v" ] && [ "$2" = "help" ]; then
  help_msg
fi

if [ "$1" = "vim" ]; then
  cdd_func $vim
fi
if [ "$1" = "vimt" ]; then
  cdd_func $vimt
fi
if [ "$1" = "vim-st" ]; then
  cdd_func $vim_st
fi
if [ "$1" = "vim-swap" ]; then
  cdd_func $vim_swap
fi

location="$home/.local/state/nvim/view"
sub_cmd="vim-view"
if [ "$1" = "$sub_cmd" ]; then
  cdd_func $location
fi
if [ "$1" = "-v" ] && [ "$2" = "$sub_cmd" ]; then
  cdd_ls_func $location
fi
if [[ "$location" == "$home"* ]]; then
  location="~${location#$home}"
  locations+=($location)
fi

sub_cmd="se"
location="$home/Documents/sessions"
if [ "$2" = "$sub_cmd" ]; then
  cdd_and_cdv "$sub_cmd" "$location"
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

if [ "$1" = "test001" ]; then
  for location in "${locations[@]}"
  do
    echo "$location"
  done
fi
