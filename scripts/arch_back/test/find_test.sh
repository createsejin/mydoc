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
else
  home="/mnt/root/home/bae"
fi
test_home="/mnt/test_root/home/bae"
root="/mnt/test_root/"

if [ "$1" = "test001" ]; then
  cd $home/Downloads
  while IFS= read -r exclude
  do 
    find . -name "$exclude" -prune -o -print0
  done < "$home/Documents/scripts/arch_back/test/test_exc.txt"
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
  cd $test_home/Downloads
  rm -rf --interactive=never move_test/*
  cp -r move_test_bak/* move_test/
fi

test_ls() {
  path=$(pwd)
  if [ "$(ls -A $path)" ]; then
    echo "dir is not empty"
  else
    echo "dir is empty."
  fi
}

# Exclude file location
excdir="/mnt/sys_back/scripts"
exclude_file="$excdir/arch_backup_exc.txt"

exclude_dir() {
  path="$1"
  moved="$root/delete/"
  mkdir -p "$path"
  if [ "$(ls -A $moved$path)" ]; then
    mv delete/"$path"/* "$path"/
  fi
}

exclude_file() {
  # exclude file path list
  path="$1"
  # absolute file path
  ab_file_path="$root$path"
  dir="$(dirname $ab_file_path)"
  mkdir -p $dir
  mv delete/"$path" $dir/
}

exclude_dirs() {
  moved="$root/delete/"
  while IFS= read -r line
  do
    if [[ ! "$line" =~ ^# ]] && [[ ! -z "$line" ]]; then
      if [ -f "$moved$line" ]; then
        exclude_file "$line"
      elif [ -d "$moved$line" ]; then
        exclude_dir "$line"
      else
        # This case maybe a unlinked symbolic link.
        exclude_file "$line"
      fi
    fi
  done < "$exclude_file"
}

move_to_delete() {
  mkdir delete
  mv !(delete) delete
  exclude_dirs
  rm -rf delete
}

# This command is extremely dangerous!! Be careful of using this!!
if [ "$1" = "test003" ]; then
  cd /mnt/test_root
  move_to_delete
fi

if [ "$1" = "restore003" ]; then
  rm -rf --interactive=never /mnt/test_root/*
  cp -r /mnt/test_root_bak/* /mnt/test_root/
fi
