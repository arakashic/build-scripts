#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

# lua
wget -O lua.tar.gz http://www.lua.org/ftp/lua-5.3.1.tar.gz
tar zxf lua.tar.gz
SRC_DIR=$(find . -maxdepth 1 -type d -name "lua*")
pushd "$SRC_DIR"
make -j "$N_PROCS" linux
make -j "$N_PROCS" install INSTALL_TOP="$LR/lua"
popd
rm -rf "$SRC_DIR"

popd

