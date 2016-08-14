#!/bin/zsh -xe

source common.sh

unset C_INCLUDE_PATH
unset CPLUS_INCLUDE_PATH
unset LIBRARY_PATH
unset LD_LIBRARY_PATH

pushd "$BUILD_HOME"

GCC_VERSION="$1"
GCC_TARBALL="gcc-${GCC_VERSION}.tar.bz2"
GCC_URL="ftp://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.bz2"
GCC_PREFIX="$LR/gcc/gcc-${GCC_VERSION}"

# GCC
wget -O "${GCC_TARBALL}" "${GCC_URL}"
tar jxf "${GCC_TARBALL}"
SRC_DIR=$(find . -maxdepth 1 -type d -name "gcc*")
pushd "$SRC_DIR"
./contrib/download_prerequisites
mkdir build
pushd build
../configure --prefix="$GCC_PREFIX" --disable-multilib --enable-language=c,c++,fortran --program-suffix=-${GCC_VERSION%%.*}
make -j "$N_PROCS"
make -j "$N_PROCS" install
popd
popd
rm -rf "$SRC_DIR"
rm -rf "${GCC_TARBALL}"

popd
