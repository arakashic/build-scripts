#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

wget -O zsh-5.5.1.zip "https://github.com/zsh-users/zsh/archive/zsh-5.5.1.zip"
unzip zsh-5.5.1.zip
SRC_DIR=$(find . -maxdepth 1 -type d -name "zsh*")
pushd "$SRC_DIR"
./Util/preconfig
./configure --prefix="$LR/zsh" --disable-gdbm
make -j "$N_PROCS"
make install.bin install.modules install.fns
popd
rm -rf "$SRC_DIR"

popd

