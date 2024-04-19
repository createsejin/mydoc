#!/bin/bash

shopt -s dotglob

cd ~/Downloads
while IFS= read -r exclude
do 
  find . -name "$exclude" -prune -o -print0
done < /home/bae/Documents/scripts/arch_back/test_exc.txt
