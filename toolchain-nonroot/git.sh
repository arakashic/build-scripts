#!/bin/zsh -xe

source common.sh
library_path libcurl

pushd "$BUILD_HOME"

# git
wget -O git.tar.gz https://github.com/git/git/archive/v2.9.2.tar.gz
tar zxf git.tar.gz
SRC_DIR=$(find . -maxdepth 1 -type d -name "git*")
pushd "$SRC_DIR"
make configure
./configure --prefix="$LR/git" --with-curl
make -j "$N_PROCS" all
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

popd

