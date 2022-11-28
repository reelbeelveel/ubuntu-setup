#!/bin/bash
sudo apt update
sudo apt upgrade
sudo apt install -y \
  bitwise \
  curl \
  dotnet6 \
  gcc \
  gdb \
  g++ \
  git \
  gpg \
  lf \
  nodejs \
  openssl \
  python3 \
  ssh \
  tar \
  wget \
  zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 
mv raw.zshrc ~/.zshrc
