#! /bin/sh

backup_path() {
    if [ -z "$LBAK" ] ; then
        export LBAK=1
        export LBAK_PATH="$PATH"
        export LBAK_MANPATH="$MANPATH"
        export LBAK_C_INCLUDE_PATH="$C_INCLUDE_PATH"
        export LBAK_CPLUS_INCLUDE_PATH="$CPLUS_INCLUDE_PATH"
        export LBAK_LD_LIBRARY_PATH="$LD_LIBRARY_PATH"
        export LBAK_LIBRARY_PATH="$LIBRARY_PATH"
        if [ "$CURRENT_OS" = "LINUX" ]; then
            export LBAK_PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
        fi
    fi
}

default() {
    export PATH="$LR/bin:$LR/usr/bin"
    export MANPATH="$LR/share/man"
    export C_INCLUDE_PATH="$LR/include:$C_INCLUDE_PATH"
    export CPLUS_INCLUDE_PATH="$LR/include:$CPLUS_INCLUDE_PATH"
    export LD_LIBRARY_PATH="$LR/lib64:$LR/lib:$LD_LIBRARY_PATH"
    export LIBRARY_PATH="$LR/lib64:$LR/lib:$LIBRARY_PATH"
}

compiler_path() {
    if [ -d "$LR/$1" ] || [  -h "$LR/$1" ] ; then
        export C_INCLUDE_PATH="$LR/$1/include:$C_INCLUDE_PATH"
        export CPLUS_INCLUDE_PATH="$LR/$1/include:$CPLUS_INCLUDE_PATH"
        export LD_LIBRARY_PATH="$LR/$1/lib64:$LR/$1/lib:$LD_LIBRARY_PATH"
        export LIBRARY_PATH="$LR/$1/lib64:$LR/$1/lib:$LIBRARY_PATH"
        export PATH="$LR/$1/bin:$PATH"
    fi
}

library_path() {
    if [ -d "$LR/$1" ] || [ -h "$LR/$1" ] ; then
        export C_INCLUDE_PATH="$LR/$1/include:$C_INCLUDE_PATH"
        export CPLUS_INCLUDE_PATH="$LR/$1/include:$CPLUS_INCLUDE_PATH"
        export LD_LIBRARY_PATH="$LR/$1/lib64:$LR/$1/lib:$LD_LIBRARY_PATH"
        export LIBRARY_PATH="$LR/$1/lib64:$LR/$1/lib:$LIBRARY_PATH"
    fi
    if [ "$CURRENT_OS" = "LINUX" ]; then
        export PKG_CONFIG_PATH="${$(find "$LR/$1" -type d -name "pkgconfig" | xargs | tr ' ' ':')}:$PKG_CONFIG_PATH"
    fi
}

application_path() {
    if [ -d "$LR/$1" ] || [ -h "$LR/$1" ] ; then
        export PATH="$LR/$1/bin:$PATH"
        export MANPATH="$LR/$1/share/man:$MANPATH"
    fi
}

backup_path
# default

application_path git
application_path autotools
application_path tmux

# local mpi
compiler_path mpi

# local gcc 5.2.0
if [ -d "$LR/gcc/gcc-5.2.0" ]; then
    compiler_path "gcc/gcc-5.2.0"
elif [ -d "$LR/gcc/gcc-4.9.3" ]; then
    compiler_path "gcc/gcc-4.9.3"
elif [ -d "$LR/gcc" ]; then
    compiler_path "gcc"
fi

# local llvm
compiler_path llvm
