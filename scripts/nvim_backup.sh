#!/bin/bash
shopt -s dotglob
if [ "$1" = "copy" ]; then
  # delete previous files
  cd /home/bae/.config/nvim.bak
  mkdir delete
  mv * delete
  # copy original files
  cd /home/bae/.config/nvim
  cp -r * /home/bae/.config/nvim.bak
  cd /home/bae/.config/nvim.bak
  rm -rf .git .gitignore
  # move files to keep
  cd delete
  mv .git .gitignore my_old_init ../
  cd ..
  rm -rf delete
fi
if [ "$1" = "restore2" ]; then
  cd /home/bae/.config/nvim.test2
  rm -rf *
  cd ..
  cp -r nvim.test/* nvim.test2
fi
if [ "$1" = "zip" ]; then
  cd /home/bae/.config/nvim.test2
  bsdtar --acls --xattrs -cpaf - nvchat_git | pv -s $(\du -sb . | awk '{print $1}') \
  | pbzip2 > "nvchat_git.tar.gz"
fi
if [ "$1" = "unzip" ]; then
  cd /home/bae/.config/nvim.test2
  pv "nvchat_git.tar.gz" | pbzip2 -dc | bsdtar --acls --xattrs -xpzf -
fi
