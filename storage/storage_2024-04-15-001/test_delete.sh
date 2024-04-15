#!/bin/bash

exclude_dir() {
  mkdir -p "$1"
  mv delete/"$1"/* "$1"
}

cd /mnt/home/bae/Downloads/test

if [ $# -eq 0 ]; then
  mkdir delete
  mv * .* delete
  exclude_dir "etc/pacman.d/gnupg"
  rm -rf delete
fi
if [ "$1" = "make" ]; then
  touch test1 .test2 test3 .test4
  mkdir -p etc/pacman.d/gnupg
  cp -r /etc/pacman.d/gnupg/* etc/pacman.d/gnupg
fi
if [ "$1" = "test01" ]; then
  mkdir delete
  mv * .* delete
  #exclude_dir "etc/pacman.d/gnupg"
fi
if [ "$1" = "test02" ]; then
  exclude_dir "etc/pacman.d/gnupg"
fi
