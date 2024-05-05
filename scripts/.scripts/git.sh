#!/bin/bash
if [ "$1" = "name" ]; then
  git config --global user.email "createsejin@gmail.com"
  git config --global user.name "createjin"
fi
if [ "$1" = "safe" ]; then
  cur_dir=$(pwd)
  echo "current_directory=$cur_dir"
  git config --global --add safe.directory $cur_dir
fi
if [ "$1" = "own" ]; then
  sudo chown -R bae:bae .git/objects
fi
