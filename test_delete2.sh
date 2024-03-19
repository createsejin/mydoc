#!/bin/bash
shopt -s dotglob

is_dir_empty() {
  local dir=$1
  if [ -z "$(ls -A $dir)" ]; then
    return 1
  else
    return 0
  fi
}

is_hidden_empty() {
  local dir=$1
  if [ -z "$(ls -d $dir/.*)" ]; then
    return 1
  else
    return 0
  fi
}

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

check_file_exist() {
  if [ -f "$1" ]; then
    return 1
  else
    return 0
  fi
}

print_lines() {
  local path=$1
  while IFS= read -r line
  do
    if [[ ! "$line" =~ ^# ]] && [[ ! -z "$line" ]]; then
      echo "$line"
    fi
  done < "$path"
}

# :'<,'>s/\([a-z]\)$/\1"/g

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

if [ "$1" = "test02" ]; then # test delete
  cd /mnt/home/bae/Downloads/test_root2
  mkdir delete
  exclude_dir "etc/pacman.d/gnupg"
  rm -rf delete
fi

if [ "$1" = "test03" ]; then # restore etc
  cd /mnt/home/bae/Downloads/test_root2 
  mkdir "etc"
  cp -r "etc_back"/* "etc"
fi

# Backup destination
backdest=/mnt/opt/sysback

# Labels for backup name
distro=arch
type=full

if [ "$1" = "test04" ]; then # test rollback
  # Check file name
  ls -l /mnt/opt/sysback
  echo -n "input backup version name: "
  read version
  
  backupfile="$backdest/$distro-$type-$version.tar.gz"
  
  check_file_exist "$backupfile"
  backupfile_exist=$?
  
  if [ $backupfile_exist -eq 1 ]; then
    cd /mnt/home/bae/Downloads/test_root2
    echo "This job takes a lot of time. please wait for finish."
    bsdtar --acls --xattrs -xpzf "$backupfile"
    echo -e "Job finished. \u25A0"
  fi
fi
if [ "$1" = "test05" ]; then # test get first dir
  path="etc/pacman.d/gnupg"
  first_dir=$(echo $path | cut -d'/' -f1)
  echo $first_dir
fi
if [ "$1" = "test06" ]; then # test dir empty
  cd /mnt/home/bae/Downloads/test_root2
  path="home/bae"
  is_dir_empty $path
  res=$?
  if [ $res -eq 1 ]; then
    echo "dir is empty."
  else
    echo "dir is not empty."
  fi
  #mv home/bae/* test
fi
if [ "$1" = "restore_test" ]; then
  cd /mnt/home/bae/Downloads
  mv test5/* test5/.* test
fi
if [ "$1" = "test07" ]; then # move test
  cd /mnt/home/bae/Downloads/test
  mv * ../test5
fi
if [ "$1" = "test08" ]; then # move hidden file test
  cd /mnt/home/bae/Downloads/test
  mv .* ../test5
fi
if [ "$1" = "test09" ]; then 
  cd /mnt/home/bae/Downloads
  is_dir_empty "test"
  res=$?
  if [ $res -eq 0 ]; then
    echo "normal files empty."
  else
    echo "normal files not empty."
  fi
fi
if [ "$1" = "test10" ]; then
  cd /mnt/home/bae/Downloads
  is_hidden_empty "test5"
  res=$?
  if [ $res -eq 0 ]; then
    echo "hidden files empty."
  else
    echo "hidden files not empty."
  fi
fi
if [ "$1" = "restore_test11" ]; then
  cd /mnt/home/bae/Downloads/test_root2
  cp -r etc_back/* etc
  cp -r tmp_back/* tmp
  cp -r home_back/* home
fi
#dm1
if [ "$1" = "test11" ]; then # test multi delete move
  cd /mnt/home/bae/Downloads/test_root2
  mkdir delete
  #mv * delete
  exclude_dir "etc/pacman.d/gnupg"
  #exclude_dir "etc_back"
  exclude_dir "tmp"
  #exclude_dir "tmp_back"
  exclude_dir "home/bae/Documents"
  #exclude_dir "home_back"
  #exclude_dir "proc"
  #exclude_dir "sys"
  #exclude_dir "dev"
  rm -rf delete
fi
if [ "$1" = "test12" ]; then # test file line print
  cd /mnt/home/bae/Documents
  print_lines "arch_backup_exc.txt"
fi

# test multi delete move through execlude_dirs()
if [ "$1" = "test13" ]; then 
  cd /mnt/home/bae/Downloads/test_root2
  mkdir delete
  #mv * delete
  exclude_dirs "/mnt/home/bae/Documents/test_delete_exc.txt"
  rm -rf delete
fi
