#!/bin/zsh -xe

source common.sh

pushd "$BUILD_HOME"

# autotools

wget -O autoconf.tar.gz http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz
wget -O automake.tar.gz http://ftp.gnu.org/gnu/automake/automake-1.16.tar.gz
wget -O libtool.tar.gz http://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz
tar zxf autoconf.tar.gz
SRC_DIR=$(find . -maxdepth 1 -type d -name "autoconf*")
pushd "$SRC_DIR"
./configure --prefix="$LR/autotools"
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

export PATH=$LR/autotools/bin:$PATH
tar zxf automake.tar.gz
SRC_DIR=$(find . -maxdepth 1 -type d -name "automake*")
pushd "$SRC_DIR"
./configure --prefix="$LR/autotools"
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

tar zxf libtool.tar.gz
SRC_DIR=$(find . -maxdepth 1 -type d -name "libtool*")
pushd "$SRC_DIR"
./configure --prefix="$LR/autotools"
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
rm -rf "$SRC_DIR"

popd

