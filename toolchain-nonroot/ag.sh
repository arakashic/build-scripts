#!/bin/zsh -xe

source common.sh
library_path libpcre

pushd "$BUILD_HOME"

# ag
wget -O ag.tar.gz https://github.com/ggreer/the_silver_searcher/archive/0.32.0.tar.gz
tar zxf ag.tar.gz
SRC_DIR=$(find . -maxdepth 1 -type d -name "*silver*")
pushd "$SRC_DIR"
./build.sh --prefix="$LR/ag"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

popd

