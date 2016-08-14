#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

# cmake
wget -O cmake.tar.gz https://cmake.org/files/v3.6/cmake-3.6.1.tar.gz
tar zxf cmake.tar.gz
SRC_DIR=$(find . -maxdepth 1 -type d -name "cmake*")
pushd "$SRC_DIR"
./bootstrap --prefix="$LR/cmake"
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

popd

