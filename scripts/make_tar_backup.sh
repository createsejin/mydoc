#!/bin/bash
if [ "$1" = "zip" ]; then
  cd /home/bae/.config/nvim.bak
  bsdtar --acls --xattrs -cpaf - nvchat_git | pv -s $(\du -sb . | awk '{print $1}') \
  | pbzip2 > "nvchat_git.tar.gz"
fi
if [ "$1" = "unzip" ]; then
  cd /home/bae/.config/nvim.bak
  pv "nvchat_git.tar.gz" | pbzip2 -dc | bsdtar --acls --xattrs -xpzf -
fi
