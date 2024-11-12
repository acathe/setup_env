#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_DEBIAN_LANG_PYTHON_SH}" ]]; then
    return 0
else
    _SETUP_ENV_DEBIAN_LANG_PYTHON_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_DEBIAN_LANG_PYTHON_SH
    cd "${_SETUP_ENV_DEBIAN_LANG_PYTHON_SH}"
fi

source "../util/apt.sh"
source "../util/omz.sh"

lang::python::set_env() {
    util::apt::install "python3" "python3-pip" "python3-venv"

    util::append_plugin "python"
}

lang::python() {
    lang::python::set_env
}
