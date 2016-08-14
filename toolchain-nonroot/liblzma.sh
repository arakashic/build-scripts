#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

# liblzma
wget http://tukaani.org/xz/xz-5.2.2.tar.gz
find . -maxdepth 1 -name "gdbm-*.tar.gz" -exec tar zxf {} \;
SRC_DIR=$(find . -maxdepth 1 -type d -name "xz-*")
pushd "$SRC_DIR"
./configure --prefix="$LR/library/liblzma" --disable-xz --disable-xzdec \
    --disable-lzmadec --disable-lzmainfo --disable-lzma-links --disable-doc --disable-scripts
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

popd

