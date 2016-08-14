#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

# tmux
wget http://ftp.gnu.org/gnu/binutils/binutils-2.25.tar.gz
tar zxf binutils-2.25.tar.gz
SRC_DIR=$(find . -maxdepth 1 -type d -name "binutils*")
pushd "$SRC_DIR"
./configure --prefix="$LR/binutils"
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

popd

