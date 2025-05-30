#!/bin/bash

cd ~/neovim
git pull
rm -rf build
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
