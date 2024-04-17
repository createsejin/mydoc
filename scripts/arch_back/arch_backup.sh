#!/bin/bash
# full system backup

shopt -s dotglob

check_file_exist() {
  if [ -f "$1" ]; then
    return 1
  else
    return 0
  fi
}

# mount sys_back
echo "mount Files/sys_back partition"
mount --mkdir /dev/Files/sys_back /mnt/sys_back

# Backup destination
backdest="/mnt/sys_back"

# Labels for backup name
distro="arch"
type="full"
date=$(date "+%F")

# Exclude file location
excdir="/mnt/sys_back"
exclude_file="$excdir/arch_backup_exc.txt"

# Check if exclude file exists
if [ ! -f $exclude_file ]; then
  echo -n "No exclude file exists, continue? (y/n): "
  read continue
  if [ $continue == "n" ]; then exit; fi
fi

while true; do
  echo "file number?"
  read filenum
  if [[ $filenum =~ ^[0-9]{1,3}$ ]]; then
    break
  else
    echo "Invaild input. Please input a correct number."
  fi
done    

formatted_filenum=$(printf "%03d" $filenum)
backupfile="$backdest/$distro-$type-$date-$formatted_filenum.tar.gz"
check_file_exist "$backupfile"
backupfile_exist=$?
if [ $backupfile_exist -eq 1 ]; then
  echo "$backupfile already exist."
  echo "Backup process canceled."
else
  # -p, --acls and --xattrs store all permissions, ACLs and extended attributes.
  # Without both of these, many programs will stop working!
  # It is safe to remove the verbose (-v) flag. If you are using a
  # slow terminal, this can greatly speed up the backup process.
  # Use bsdtar because GNU tar will not preserve extended attributes.
  echo "This job takes a lot of time. please wait for finish."
  cd /mnt
  bsdtar --exclude-from="$exclude_file" \
    --acls --xattrs -cpaf - . | pv -s $(du -sb . | awk '{print $1}') \
    | pbzip2 > "$backupfile"
  echo -e "Job finished. \u25A0"
fi
