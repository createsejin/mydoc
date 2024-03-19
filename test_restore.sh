#!/bin/bash
shopt -s dotglob

get_first_dir() {
  local path=$1
  local first_dir=$(echo $path | cut -d'/' -f1)
  echo $first_dir
}

exclude_dir() {
  path="$1"
  first_dir=$(get_first_dir $path)
  mv $first_dir delete
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

delete_and_move() {
  local exclude_path=$1
  mkdir delete
  mv * delete
  exclude_dirs $exclude_path
  rm -rf delete
}

# Backup destination
backdest=/mnt/opt/sysback

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

#back1
if [ $backupfile_exist -eq 1 ]; then
  cd /mnt/home/bae/Downloads/test_root2
  echo "This job takes a lot of time. please wait for finish."
  delete_and_move "/mnt/home/bae/Documents/test_delete_exc.txt" 
  pv "$backupfile" | pbzip2 -dc | bsdtar --acls --xattrs -xpf -
  echo -e "Job finished. \u25A0"
fi

# errors
# mv: cannot move 'delete' to a subdirectory of itself, 'delete/delete'
# mv: cannot stat 'etc': No such file or directory
# mv: cannot stat 'tmp': No such file or directory
# mv: cannot stat 'home': No such file or directory
