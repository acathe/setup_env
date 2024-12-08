#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_DEBIAN_LANG_CPP_SH}" ]]; then
    return 0
else
    _SETUP_ENV_DEBIAN_LANG_CPP_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_DEBIAN_LANG_CPP_SH
    cd "${_SETUP_ENV_DEBIAN_LANG_CPP_SH}"
fi

source "../util/apt.sh"

lang::cpp::set_env() {
    # Ref. https://clangd.llvm.org/installation
    util::apt::install "clang" "clangd" "lldb" "cmake" "cmake-format"
}

lang::cpp() {
    lang::cpp::set_env
}
