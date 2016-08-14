#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

# libpcre
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz
find . -maxdepth 1 -name "pcre-*.tar.gz" -exec tar zxf {} \;
SRC_DIR=$(find . -maxdepth 1 -type d -name "pcre*")
pushd "$SRC_DIR"
./configure --prefix="$LR/library/libpcre"
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

popd

