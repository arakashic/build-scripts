#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

# libevent
wget "https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz"
find . -maxdepth 1 -name "libevent-*.tar.gz" -exec tar zxf {} \;
SRC_DIR=$(find . -maxdepth 1 -type d -name "libevent*")
pushd "$SRC_DIR"
./configure --prefix="$LR/library/libevent"
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

popd

