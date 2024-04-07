#!/bin/bash

if [ -z "$1" ]; then
  du -h -a -d 1 --exclude-from=/home/bae/Documents/scripts/du_exc.txt /
fi
