#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

# tmux
wget http://ftp.gnu.org/gnu/texinfo/texinfo-6.0.tar.gz
tar zxf texinfo-6.0.tar.gz
SRC_DIR=$(find . -maxdepth 1 -type d -name "texinfo*")
pushd "$SRC_DIR"
./configure --prefix="$LR/texinfo"
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

popd

