#! /bin/bash

LLVM_ROOT=/usr/local/Cellar/llvm/3.5.1/lib
PYTHON_HOME=/usr/local/Cellar/python/2.7.9/Frameworks/Python.framework/Versions/2.7

cd $HOME
mkdir ycm_build
cd ycm_build
# cmake -DPYTHON_EXECUTABLE=/usr/local/bin/python \
    # -DPYTHON_LIBRARY=$PYTHON_HOME/lib \
    # -DPYTHON_INCLUDE_DIR=$PYTHON_HOME/include/python2.7 \
    # -G "Unix Makefiles" -DUSE_CLANG_COMPLETER=ON -DUSE_SYSTEM_LIBCLANG=ON -DPATH_TO_LLVM_ROOT=$LLVM_ROOT . $HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp

cmake -G "Unix Makefiles" -DUSE_CLANG_COMPLETER=ON -DUSE_SYSTEM_LIBCLANG=ON -DPATH_TO_LLVM_ROOT=$LLVM_ROOT . $HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
make ycm_support_libs

cd $HOME
rm -rf ycm_build

# cd $HOME/.vim/bundle/YouCompleteMe
# for FILE in `ag -l "/usr/bin/env python$"`; do
    # sed -i 's/\/usr\/bin\/env\ python/\/usr\/bin\/env python2/' $FILE
# done
# cd $HOME
