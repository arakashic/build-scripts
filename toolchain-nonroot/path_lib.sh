
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

recover_path() {
    if [ -n "$LBAK" ] ; then
        export LBAK=1
        export PATH="$LBAK_PATH"
        export MANPATH="$LBAK_MANPATH"
        export C_INCLUDE_PATH="$LBAK_C_INCLUDE_PATH"
        export CPLUS_INCLUDE_PATH="$LBAK_CPLUS_INCLUDE_PATH"
        export LD_LIBRARY_PATH="$LBAK_LD_LIBRARY_PATH"
        export LIBRARY_PATH="$LBAK_LIBRARY_PATH"
        if [ "$CURRENT_OS" = "LINUX" ]; then
            export PKG_CONFIG_PATH="$LBAK_PKG_CONFIG_PATH"
        fi
    fi
}

clear_backup_path() {
    unset LBAK_PATH
    unset LBAK_MANPATH
    unset LBAK_C_INCLUDE_PATH
    unset LBAK_CPLUS_INCLUDE_PATH
    unset LBAK_LD_LIBRARY_PATH
    unset LBAK_PKG_CONFIG_PATH
    unset LBAK
}

has_path() {
    if [ -d "$1" ] || [ -h "$1" ]; then
        return 0
    else
        return 1
    fi
}

lib_path() {
    local BASE_PATH="$LR"
    if has_path "$1" ; then
        BASE_PATH="$1"
    else
        BASE_PATH="$BASE_PATH/$1"
    fi

    export C_INCLUDE_PATH="$BASE_PATH/include:$C_INCLUDE_PATH"
    export CPLUS_INCLUDE_PATH="$BASE_PATH/include:$CPLUS_INCLUDE_PATH"
    export LD_LIBRARY_PATH="$BASE_PATH/lib:$LD_LIBRARY_PATH"
    export LIBRARY_PATH="$BASE_PATH/lib:$LIBRARY_PATH"
    if has_path "$BASE_PATH/lib64" ; then
        export LD_LIBRARY_PATH="$BASE_PATH/lib64:$LD_LIBRARY_PATH"
        export LIBRARY_PATH="$BASE_PATH/lib64:$LIBRARY_PATH"
    fi
    if [ "$CURRENT_OS" = "LINUX" ]; then
        if has_path "$BASE_PATH/lib/pkgconfig" ; then
            export PKG_CONFIG_PATH="$BASE_PATH/lib/pkgconfig:$PKG_CONFIG_PATH"
        fi
    fi
}

application_path() {
    local BASE_PATH="$LR"
    if has_path "$1" ; then
        BASE_PATH="$1"
    else
        BASE_PATH="$BASE_PATH/$1"
    fi

    export PATH="$BASE_PATH/bin:$PATH"
    # fi
    if has_path "$BASE_PATH/share/man" ; then
        export MANPATH="$BASE_PATH/share/man:$MANPATH"
    fi
}

library_path() {
    lib_path "library/$1"
}

compiler_path() {
    application_path "$1"
    lib_path "$1"
}

default() {
    if has_path "$LR/usr/bin" ; then export PATH="$LR/usr/bin:$PATH" ; fi
    if has_path "$LR/bin" ; then export PATH="$LR/bin:$PATH" ; fi
    if has_path "$LR/usr/share/man" ; then export MANPATH="$LR/usr/share/man:$MANPATH" ; fi
    if has_path "$LR/share/man" ; then export MANPATH="$LR/share/man:$MANPATH" ; fi
    if has_path "$LR/usr/include" ; then
        export C_INCLUDE_PATH="$LR/usr/include:$C_INCLUDE_PATH"
        export CPLUS_INCLUDE_PATH="$LR/usr/include:$CPLUS_INCLUDE_PATH"
    fi
    if has_path "$LR/include" ; then
        export C_INCLUDE_PATH="$LR/include:$C_INCLUDE_PATH"
        export CPLUS_INCLUDE_PATH="$LR/include:$CPLUS_INCLUDE_PATH"
    fi
    if has_path "$LR/usr/lib" ; then
        export LIBRARY_PATH="$LR/usr/lib:$LIBRARY_PATH"
        export LD_LIBRARY_PATH="$LR/usr/lib:$LD_LIBRARY_PATH"
    fi
    if has_path "$LR/usr/lib64" ; then
        export LIBRARY_PATH="$LR/usr/lib64:$LIBRARY_PATH"
        export LD_LIBRARY_PATH="$LR/usr/lib64:$LD_LIBRARY_PATH"
    fi
    if has_path "$LR/lib" ; then
        export LIBRARY_PATH="$LR/lib:$LIBRARY_PATH"
        export LD_LIBRARY_PATH="$LR/lib:$LD_LIBRARY_PATH"
    fi
    if has_path "$LR/lib64" ; then
        export LIBRARY_PATH="$LR/lib64:$LIBRARY_PATH"
        export LD_LIBRARY_PATH="$LR/lib64:$LD_LIBRARY_PATH"
    fi
    if [ "$CURRENT_OS" = "LINUX" ]; then
        _pkg_list=$(find "$LR" -type d -name "pkgconfig" | xargs | tr ' ' ':')
        if [ -n "${_pkg_list}" ] ; then
            export PKG_CONFIG_PATH="${_pkg_list}:$PKG_CONFIG_PATH"
        fi
    fi
}

# vim: syn=zsh
