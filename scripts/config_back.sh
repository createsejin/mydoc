#!/usr/bin/zsh
setopt GLOB_DOTS

configs="/home/bae/Documents/configs"

if [ -z "$1" ]; then
  cd /home/bae
  cp .zshrc .zprofile .p10k.zsh \
    $configs/zshrcs
  cp .bashrc $configs/bashrcs/bae
  sudo cp -r .tmux $configs
  cp .config/rustfmt/rustfmt.toml $configs/rustfmt
fi

if [ "$1" = "root" ]; then
  cd /root
  cp .zshrc .zprofile \
    $configs/zshrcs/root
fi
