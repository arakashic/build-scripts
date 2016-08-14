#! /bin/sh

if [[ -z "$LR" ]]; then
    LR="$HOME/.local"
    case "$(hostname)" in
        flogin*)
            echo "On FUSION"
            LR="$HOME/.local-fusion"
            ;;
        blogin*)
            echo "On FUSION"
            LR="$HOME/.local-blues"
            ;;
    esac
fi

if [[ ! -d "$LR" ]]; then
    mkdir -p "$LR"
fi

if [[ -z "$BUILD_HOME" ]]; then
    BUILD_HOME="/tmp/$(whoami)"
fi
if [[ ! -d "$BUILD_HOME" ]]; then
    mkdir -p "$BUILD_HOME"
fi

if [[ -z "$N_PROCS" ]] ; then
    N_PROCS=8
fi

source "path_lib.sh"

