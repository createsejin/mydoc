#!/bin/bash

shopt -s dotglob
shopt -s extglob

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

if [ "$1" = "test001" ]; then
  cd $home/Downloads
  while IFS= read -r exclude
  do 
    find . -name "$exclude" -prune -o -print0
  done < $home/Documents/scripts/arch_back/test/test_exc.txt
fi
if [ "$1" = "test002" ]; then
  cd $home/Downloads/move_test
  mv !(move|test4|.test5) move

  cd $home/Downloads/move_test
  mkdir move/test4
  cd test4
  mv !(Documents) ../move/test4

  cd $home/Downloads/move_test
  mkdir move/.test5
  cd .test5
  mv !(Projects) ../move/.test5
fi
if [ "$1" = "restore002" ]; then
  cd $home/Downloads
  rm -rf --interactive=never move_test/*
  cp -r move_test_bak/* move_test/
fi

# Exclude file location
excdir="/mnt/sys_back/scripts"
exclude_file="$excdir/arch_backup_exc.txt"

exclude_dir() {
  path="$1"
  mkdir -p "$path"
  mv delete/"$path"/* "$path"
}
exclude_file() {
  root="/mnt/test_root/"
  re_file_path="$1"
  ab_file_path="$root$re_file_path"
  dir="$(dirname $ab_file_path)"
  mkdir -p $dir
  # TODO: complete script and test this function!
}

exclude_dirs() {
  local path=$1
  while IFS= read -r line
  do
    if [[ ! "$line" =~ ^# ]] && [[ ! -z "$line" ]]; then
      if [ -f "$line" ]; then
        echo "$line is file."
        exclude_file "$line"
      elif [ -d "$line" ]; then
        echo "$line is directory."
        #exclude_dir()
      else
        echo "$line is not file or directory."
      fi
    fi
  done < "$path"
}

move_to_delete() {
  mkdir delete
  mv !(delete) delete
  exclude_dirs $exclude_file
}

# This command is extremely dangerous!! Be careful of using this!!
if [ "$1" = "test003" ]; then
  cd /mnt/test_root
  #move_to_delete
fi

if [ "$1" = "restore003" ]; then
  rm -rf --interactive=never /mnt/test_root/*
  cp -r /mnt/test_root_bak/* /mnt/test_root/
fi

if [ "$1" = "test004" ]; then
  cd /mnt/test_root
  exclude_dirs $exclude_file
fi
