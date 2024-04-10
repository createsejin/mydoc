#!/bin/bash
if [ "$1" = "-u" ]; then
  nc -lU /home/bae/.config/nvim/nvim.sock
fi
if [ "$1" = "-l" ]; then
  nvim --headless --listen /home/bae/.config/nvim/nvim.sock
fi
if [ "$1" = "-s" ]; then
  /usr/bin/neovide --server /home/bae/.config/nvim/nvim.sock --remote
fi
