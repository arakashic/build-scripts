#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

REPO="https://github.com/wting/autojump"
BUILD_DIR="$BUILD_HOME/autojump"

git clone "$REPO"
pushd "$BUILD_DIR"
./install.py
popd
rm -rf "$BUILD_DIR"

popd
