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
exc_file="/mnt/home/bae/Documents/test_delete_exc.txt"

if [ "$1" = "test01" ]; then
  cd /mnt/home/bae/Downloads/test_root3
  delete_and_move $exc_file
fi
if [ "$1" = "restore" ]; then
  /mnt/home/bae/Documents/test_delete2.sh restore_test11
fi
if [ "$1" = "restore2" ]; then
  cd /mnt/home/bae/Downloads
  cp -r test_root2/home test_root3
  cp -r test_root2/etc test_root3
  cp -r test_root2/tmp test_root3
fi
if [ "$1" = "restore3" ]; then
  cd /mnt/home/bae/Downloads 
  cp -r test_root3_ba/* test_root3
fi

