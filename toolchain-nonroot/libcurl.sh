#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

# libcurl
wget https://github.com/bagder/curl/releases/download/curl-7_45_0/curl-7.45.0.tar.gz
find . -maxdepth 1 -name "curl-*.tar.gz" -exec tar zxf {} \;
SRC_DIR=$(find . -maxdepth 1 -type d -name "curl*")
pushd "$SRC_DIR"
./configure --prefix="$LR/library/libcurl"
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

popd

