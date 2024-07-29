#!/bin/bash

function check_file_exist() {
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

function cdd_func() {
  location="$1"
  cd "$location"
  ls -Al --color=auto
}

function cdd_ls_func() {
  location="$1"
  ls -Al --color=auto $location
}

function cdd_and_cdv() {
  location="$2"
  if [ "$1" = "-d" ]; then
    cdd_func $location
  fi
  if [ "$1" = "-v" ]; then
    cdd_ls_func $location
  fi
}

function handle_location() {
  local sub_cmd=$1
  local location=$2
  local sub_input=$3
  local input=$4

  if [ "$input" = "$sub_cmd" ]; then
    cdd_and_cdv "$sub_input" "$location"
  fi
  if [[ "$location" == "$home"* ]]; then
    location="~${location#$home}"
    locations+=($location)
  else
    locations+=($location)
  fi
  sub_cmds+=($sub_cmd)
}

locations=()
declare -a locations
sub_cmds=()
declare -a sub_cmds

sub_cmd="vim"
location="$home/.config/nvim"
handle_location "$sub_cmd" "$location" "$1" "$2"

sub_cmd="vimt"
location="$home/.config/nvimt"
handle_location "$sub_cmd" "$location" "$1" "$2"

sub_cmd="vim-st"
location="$home/.local/state/nvim"
handle_location "$sub_cmd" "$location" "$1" "$2"

sub_cmd="vim-swap"
location="$home/.local/state/nvim/swap"
handle_location "$sub_cmd" "$location" "$1" "$2"

sub_cmd="vim-view"
location="$home/.local/state/nvim/view"
handle_location "$sub_cmd" "$location" "$1" "$2"

sub_cmd="se"
location="$home/Documents/sessions"
handle_location "$sub_cmd" "$location" "$1" "$2"

sub_cmd="d"
location="$home/Documents"
handle_location "$sub_cmd" "$location" "$1" "$2"

sub_cmd="sc"
location="$home/Documents/scripts/.scripts"
handle_location "$sub_cmd" "$location" "$1" "$2"

sub_cmd="cf"
location="$home/Documents/configs"
handle_location "$sub_cmd" "$location" "$1" "$2"

sub_cmd="asc"
location="$home/Documents/android/scripts/.scripts"
handle_location "$sub_cmd" "$location" "$1" "$2"

sub_cmd="ob"
location="$home/Obsidian"
handle_location "$sub_cmd" "$location" "$1" "$2"
#cdd @#

function help_msg() {
  #help @#
  loc_len=${#locations[@]}
  sub_len=${#sub_cmds[@]}
  if [[ $loc_len == $sub_len ]]; then
    for ((i=1; i<$loc_len+1; ++i)); do
      printf "%10s: ${locations[i]}\n" "${sub_cmds[i]}"
    done
  fi
}

if [ "$2" = "help" ]; then
  help_msg
fi
