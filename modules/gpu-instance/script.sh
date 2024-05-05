#!/bin/bash

sudo apt-get update && sudo apt-get -y upgrade

sudo apt-get -y install \
  wget \
  git \
  tmux \
  python3.10-venv

WORKSPACE="/home/ubuntu"

# stable-diffusion

if [ ! -d "$WORKSPACE/stable-diffusion-webui" ]; then
  cd $WORKSPACE
  sudo -u ubuntu git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

  cd $WORKSPACE/stable-diffusion-webui
  sudo -u ubuntu python3.10 -m venv venv
fi

# filebrowser
sudo -u ubuntu wget -qO- https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
