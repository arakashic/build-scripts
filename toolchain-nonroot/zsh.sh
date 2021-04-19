#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

wget -O zsh-stable.zip "https://github.com/zsh-users/zsh/archive/refs/tags/zsh-5.8.zip"
unzip zsh-stable.zip
SRC_DIR=$(find . -maxdepth 1 -type d -name "zsh*")
pushd "$SRC_DIR"
./Util/preconfig
./configure --prefix="$LR/zsh" --disable-gdbm
make -j "$N_PROCS"
make install.bin install.modules install.fns
popd
rm -rf "$SRC_DIR"

popd

