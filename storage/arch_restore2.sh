#!/bin/bash
shopt -s dotglob

exclude_dir() {
  path="$1"
  mkdir -p "$path"
  mv delete/"$path"/* "$path"
}

exclude_dirs() {
  local path=$1
  while IFS= read -r line
  do
    if [[ ! "$line" =~ ^# ]] && [[ ! -z "$line" ]]; then
      exclude_dir "$line"
    fi
  done < "$path"
}

move_to_delete() {
  local exclude_path=$1
  # It's very very dangerous command!! be careful!!
  mkdir delete
  mv * delete
  cp delete/$exclude_path .
  exc_file=$(basename $exclude_path)
  exclude_dirs $exc_file
}


# Backup source
backdest="/mnt/sys_back"

# Exclude file location
excdir="/mnt/sys_back"
exclude_file="$excdir/arch_backup_exc.txt"

# Labels for backup name
distro=arch
type=full

# Check file name
ls -l /mnt/opt/sysback
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
  cd /mnt
  move_to_delete $exclude_file
  echo "This job takes a lot of time. please wait for finish."
  pv "$backupfile" | pbzip2 -dc | bsdtar --acls --xattrs -xpzf - 
fi
