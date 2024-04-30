#!/bin/bash

shopt -s dotglob
shopt -s extglob

# Backup source
backdest="/mnt/sys_back/backup"

root="/mnt/test_root"

# Exclude file location
excdir="/mnt/sys_back/scripts"
exclude_path="$excdir/arch_backup_exc.txt"

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
    if [[ ! "$line" =~ ^# ]] && [[ ! -z "$line" ]] && [[ ! "$line" == "home" ]]; then
      if [ -f "$moved$line" ]; then
        exclude_file "$line"
      elif [ -d "$moved$line" ]; then
        exclude_dir "$line"
      else
        # This case maybe a unlinked symbolic link or non exist file
        exclude_file "$line"
      fi
    fi
  done < "$exclude_path"
}

move_to_delete() {
  mkdir delete
  mv !(delete|home|boot) delete
  rm -rf boot/*
  exclude_dirs
  rm -rf delete
}

# Labels for backup name
distro="arch"
type="full"

# Check file name
ls -l $backdest
echo -n "input backup version name: "
read version

backupfile="$backdest/$distro-$type-$version.tar.gz"

check_file_exist() {
  if [ -f "$1" ]; then
    return 1
  else
    return 0
  fi
}

check_file_exist "$backupfile"
backupfile_exist=$?

if [ $backupfile_exist -eq 1 ]; then
  cd $root
  echo "This job takes a lot of time. please wait for finish."
  move_to_delete
  pv "$backupfile" | pbzip2 -dc | bsdtar --acls --xattrs -xpzf - 
else
  echo "There is no backup_file. exit restore script"
fi
