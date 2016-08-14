#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

# cmake
wget -O neovim.tar.gz https://github.com/neovim/neovim/archive/v0.1.3.tar.gz
tar zxf neovim.tar.gz
SRC_DIR=$(find . -maxdepth 1 -type d -name "neovim*")
pushd "$SRC_DIR"
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$LR/nvim"
make install
popd
rm -rf "$SRC_DIR"

popd

