#   (C) 2017 by Argonne National Laboratory.
#       See COPYRIGHT in top-level directory.

if test -z "$BASE_PATH" ; then
    readonly BASE_PATH=${LR:-$HOME/.local}
    export BASE_PATH
fi

if test -z "$ENV_BACKUP_FILE" ; then
    readonly ENV_BACKUP_FILE="$HOME/.path_lib.env.bak"
fi

# Utilities

init() {
    :
}

backup_env() {
    if [ -f "$ENV_BACKUP_FILE" ]; then
        rm "$ENV_BACKUP_FILE"
    fi
    touch "$ENV_BACKUP_FILE"
    {
        echo "export PATH=$PATH"
        echo "export CPATH=$CPATH"
        echo "export INCLUDE=$INCLUDE"
        echo "export C_INCLUDE_PATH=$C_INCLUDE_PATH"
        echo "export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH"
        echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
        echo "export LIBRARY_PATH=$LIBRARY_PATH"
        echo "export LBAK_PKG_CONFIG_PATH=$PKG_CONFIG_PATH"
    } >> "$ENV_BACKUP_FILE"
}

restore_env() {
    . "$ENV_BACKUP_FILE"
}

path_exists() {
    if [ -d "$1" ] || [ -h "$1" ]; then
        return 0
    else
        return 1
    fi
}

clean_path() {
    local _tmp_p=${(P)1}
    export $1="${_tmp_p%:}"
}

check_export_path() {
    local _tmp_p=${(P)1}
    if path_exists "$2"; then
        if [[ ! ":$_tmp_p:" = *":$2:"* ]]; then
            export $1="$2:$_tmp_p"
            clean_path "$1"
        fi
    else
        return 0
    fi
}

abs_or_local_path() {
    if path_exists "$1" ; then
        NEW_PATH="$1"
        return 0
    fi
    if path_exists "$BASE_PATH/$1" ; then
        NEW_PATH="$BASE_PATH/$1"
        return 0
    fi
    echo "path_lib: $1 does not exist"
    return 1
}

# Basic path functions

lib_path() {
    abs_or_local_path "$1"

    check_export_path CPATH "$NEW_PATH/include"
    export INCLUDE="$CPATH"
    export C_INCLUDE_PATH="$CPATH"
    export CPLUS_INCLUDE_PATH="$CPATH"

    check_export_path LIBRARY_PATH "$NEW_PATH/lib"
    check_export_path LIBRARY_PATH "$NEW_PATH/lib64"
    export LD_LIBRARY_PATH="$LIBRARY_PATH"

    check_export_path PKG_CONFIG_PATH "$NEW_PATH/lib/pkgconfig"
    check_export_path PKG_CONFIG_PATH "$NEW_PATH/lib64/pkgconfig"
}

bin_path() {
    abs_or_local_path "$1"

    check_export_path PATH    "$NEW_PATH/bin"
}

# Convenient functions

application_path() {
    bin_path "$1"
}

library_path() {
    lib_path "library/$1"
}

compiler_path() {
    bin_path "$1"
    lib_path "$1"
}

default() {
    if [ -n "$LOCAL_DEF_PATH" ]; then return; fi

    check_export_path PATH    "$LR/usr/bin"
    check_export_path PATH    "$LR/bin"
    bin_path "bin"
    bin_path "usr/bin"

    lib_path "usr"
    lib_path "$BASE_PATH"
    export LOCAL_DEF_PATH=1
}

# vim: syn=zsh
