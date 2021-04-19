#!/bin/zsh -xe

source common.sh
library_path libevent

pushd "$BUILD_HOME"

# tmux
wget "https://github.com/tmux/tmux/releases/download/3.2/tmux-3.2.tar.gz"
tar zxf tmux-3.2.tar.gz
SRC_DIR=$(find . -maxdepth 1 -type d -name "tmux*")
pushd "$SRC_DIR"
./configure --prefix="$LR/tmux"
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

popd

