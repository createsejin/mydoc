#!/bin/bash
echo "file number?"
read filenum
if [[ $filenum =~ ^[0-9]{1,3}$ ]]; then
  echo "vaild input."
else
  echo "Invaild input. Please input a number."
fi

