#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

# libcurl
wget ftp://ftp.gnu.org/gnu/gdbm/gdbm-1.11.tar.gz
find . -maxdepth 1 -name "gdbm-*.tar.gz" -exec tar zxf {} \;
SRC_DIR=$(find . -maxdepth 1 -type d -name "gdbm*")
pushd "$SRC_DIR"
./configure --prefix="$LR/library/libgdbm"
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

popd

