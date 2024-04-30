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
exclude_path="$excdir/test/arch_backup_exc_test.txt"

exclude_dir_root() {
  path="$1"
  moved="$root/delete/"
  mkdir -p "$path"
  if [ "$(ls -A $moved$path)" ]; then
    mv delete/"$path"/* "$path"/
  fi
}

exclude_file_root() {
  # exclude file path list
  path="$1"
  # absolute file path
  ab_file_path="$root$path"
  dir="$(dirname $ab_file_path)"
  mkdir -p $dir
  mv delete/"$path" $dir/
}

exclude_dir_home() {
  path="$1"
  moved="$test_home/delete/"
  mkdir -p "$test_home/$path"
  cd $test_home
  if [ "$(ls -A $moved$path)" ]; then
    mv delete/"$path"/* "$path"/
  fi
}

exclude_file_home() {
  path="$1"
  mv delete/"$path" .
}

exclude_dirs_root() {
  moved="$root/delete/"
  while IFS= read -r line
  do
    if [[ ! "$line" =~ ^# ]] && [[ ! -z "$line" ]] && \
      [[ ! "$line" == "$home_prefix"* ]]; then
      echo "exclude_dirs_root:"
      if [ -f "$moved$line" ]; then
        echo "$moved$line is file"
        exclude_file_root "$line"
      elif [ -d "$moved$line" ]; then
        echo "$moved$line is directory"
        exclude_dir_root "$line"
      else
        # This case maybe a unlinked symbolic link.
        echo "$moved$line is not file or directory"
        exclude_file_root "$line"
      fi
    fi
  done < "$exclude_path"
}

exclude_dirs_home() {
  moved="$root/home/bae/delete/"
  home_prefix="home/bae/"
  while IFS= read -r line
  do
    if [[ ! "$line" =~ ^# ]] && [[ ! -z "$line" ]] && \
      [[ "$line" == "$home_prefix"* ]]; then
      line=${line#"$home_prefix"}
      echo "exclude_dirs_home:"
      if [ -f "$moved$line" ]; then
        echo "$moved$line is file"
        exclude_file_home "$line"
      elif [ -d "$moved$line" ]; then
        echo "$moved$line is directory"
        exclude_dir_home "$line"
      else
        # This case maybe a unlinked symbolic link.
        echo "$moved$line is not file or directory"
        exclude_file_home "$line"
      fi
    fi
  done < "$exclude_path"
}

move_to_delete_root() {
  cd $root
  mkdir delete
  mv !(delete|home|boot) delete
  rm -rf boot/*
  exclude_dirs_root
  rm -rf delete
}

move_to_delete_home() {
  cd $root
  cd home/bae
  mkdir delete
  mv !(delete) delete
  exclude_dirs_home 
  rm -rf delete
}

# This command is extremely dangerous!! Be careful of using this!!
if [ "$1" = "test003" ]; then
  cd /mnt/test_root
  move_to_delete_root
  move_to_delete_home
fi

if [ "$1" = "restore003" ]; then
  rm -rf --interactive=never /mnt/test_root/*
  cp -r /mnt/test_root_bak/* /mnt/test_root/
fi

if [ "$1" = "test_home001" ]; then
  exclude_dirs_home 
fi


if [ "$1" = "test004" ]; then
  while IFS= read -r line
  do
    if [[ ! "$line" =~ ^# ]] && [[ ! -z "$line" ]]; then
      mkdir -p $line
    fi
  done < "$exclude_path"
fi
