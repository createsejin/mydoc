#!/bin/bash

shopt -s dotglob
shopt -s extglob

if [ "$1" = "test001" ]; then
  cd ~/Downloads
  while IFS= read -r exclude
  do 
    find . -name "$exclude" -prune -o -print0
  done < /home/bae/Documents/scripts/arch_back/test_exc.txt
fi
if [ "$1" = "test002" ]; then
  cd ~/Downloads/move_test
  mv !(move|test4|.test5) move

  cd ~/Downloads/move_test
  mkdir move/test4
  cd test4
  mv !(Documents) ../move/test4

  cd ~/Downloads/move_test
  mkdir move/.test5
  cd .test5
  mv !(Projects) ../move/.test5
fi
if [ "$1" = "test003" ]; then
  echo -e "\033[32mtesttest\033[0mtesttest"
fi
if [ "$1" = "restore002" ]; then
  cd ~/Downloads
  rm -rf --interactive=never move_test/*
  cp -r move_test_bak/* move_test/
fi

