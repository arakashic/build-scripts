#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

if [[ ! -d $LR/glibc ]]; then
    mkdir $LR/glibc
fi

# libcurl
wget http://ftp.gnu.org/gnu/glibc/glibc-2.22.tar.gz
find . -maxdepth 1 -name "glibc-*.tar.gz" -exec tar zxf {} \;
SRC_DIR=$(find . -maxdepth 1 -type d -name "glibc*")
pushd "$SRC_DIR"
mkdir build
mkdir $LR/glibc/glibc-2.22
pushd build
LD_LIBRARY_PATH="$LR/gcc/gcc-4.9.3/lib64:$LR/gcc/gcc-4.9.3/lib" CC=gcc-4 ../configure --prefix="$LR/glibc/glibc-2.22"
make
make install
popd
popd
rm -rf "$SRC_DIR"

popd

