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
test_home="/mnt/test_root/home/bae"

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
  cd $test_home/Downloads
  rm -rf --interactive=never move_test/*
  cp -r move_test_bak/* move_test/
fi

# Exclude file location
excdir="/mnt/sys_back/scripts"
exclude_file="$excdir/arch_backup_exc.txt"

exclude_dir() {
  path="$1"
  mkdir -p "$path"
  if [ "$(ls -A $path)" ]; then
    mv delete/"$path"/* "$path"/
  else
    mv delete/"$path" .
  fi
}

exclude_file() {
  root="/mnt/test_root/"
  # exclude file path list
  path="$1"
  # absolute file path
  ab_file_path="$root$path"
  dir="$(dirname $ab_file_path)"
  mkdir -p $dir
  mv delete/"$path" $dir/
}

exclude_dirs() {
  root="/mnt/test_root/"
  moved="$root/delete/"
  while IFS= read -r line
  do
    if [[ ! "$line" =~ ^# ]] && [[ ! -z "$line" ]]; then
      if [ -f "$moved$line" ]; then
        exclude_file "$line"
      elif [ -d "$moved$line" ]; then
        exclude_dir "$line"
      else
        # maybe a unlinked symbolic link
        echo "$moved$line is not file or directory."
      fi
    fi
  done < "$exclude_file"
}

move_to_delete() {
  mkdir delete
  mv !(delete) delete
  exclude_dirs
}

exclude_dirs_test() {
  local path=$1
  root="/mnt/test_root/"
  while IFS= read -r line
  do
    if [[ ! "$line" =~ ^# ]] && [[ ! -z "$line" ]]; then
      if [ -f "$root$line" ]; then
        echo "$root$line is file"
      elif [ -d "$root$line" ]; then
        echo "$root$line is dir"
      else
        echo "$root$line is not file or directory."
      fi
    fi
  done < "$path"
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

if [ "$1" = "test004" ]; then
  cd /mnt/test_root
  exclude_dirs_test $exclude_file
fi
