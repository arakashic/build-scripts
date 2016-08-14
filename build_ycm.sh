#! /bin/bash

LLVM_ROOT=/usr/lib

cd $HOME
mkdir ycm_build
cd ycm_build
cmake -DPYTHON_EXECUTABLE=/usr/bin/python2 -G "Unix Makefiles" -DUSE_CLANG_COMPLETER=ON -DUSE_SYSTEM_LIBCLANG=ON -DPATH_TO_LLVM_ROOT=$LLVM_ROOT . $HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp

make ycm_support_libs

cd $HOME
rm -rf ycm_build

cd $HOME/.vim/bundle/YouCompleteMe
for FILE in `ag -l "/usr/bin/env python$"`; do
    sed -i 's/\/usr\/bin\/env\ python/\/usr\/bin\/env python2/' $FILE
done
cd $HOME
