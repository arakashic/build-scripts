#!/bin/zsh -xe

source common.sh
library_path libgdbm

pushd "$BUILD_HOME"

wget -O zsh-5.2.zip "https://github.com/zsh-users/zsh/archive/zsh-5.2.zip"
unzip zsh-5.2.zip
SRC_DIR=$(find . -maxdepth 1 -type d -name "zsh*")
pushd "$SRC_DIR"
# ./configure --prefix="$LR/zsh" --enable-gdbm --with-gdbm=$LR/library/libgdbm
./Util/preconfig
./configure --prefix="$LR/zsh" --enable-gdbm
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

popd

