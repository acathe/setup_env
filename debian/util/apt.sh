#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_LINUX_UTIL_APT_SH}" ]]; then
    return 0
else
    _SETUP_ENV_LINUX_UTIL_APT_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_LINUX_UTIL_APT_SH
fi

apt::install() {
    local _packages=("${@}")

    if (("${#_packages[@]}" == 0)); then
        echo "No package to install."
        return 0
    fi

    local _uninstalled=()
    for _package in "${_packages[@]}"; do
        if [ -n "$(command -v "${_package}")" ]; then
            continue
        fi

        _uninstalled+=("${_package}")
    done

    if (("${#_uninstalled[@]}" == 0)); then
        echo "All packages are already installed."
        return 0
    fi

    sudo apt-get install -y -qq "${_uninstalled[@]}"
}

apt::update() {
    sudo apt-get update -qq
}

apt::upgrade() {
    local _packages=("${@}")

    if (("${#_packages[@]}" == 0)); then
        echo "No package to upgrade."
        return 0
    fi

    local _installed=()
    for _package in "${_packages[@]}"; do
        if [ -z "$(command -v "${_package}")" ]; then
            continue
        fi

        _installed+=("${_package}")
    done

    if (("${#_installed[@]}" == 0)); then
        echo "None of the specified packages are installed."
        return 0
    fi

    sudo apt-get upgrade -y -qq "${_installed[@]}"
}

apt::clean() {
    sudo apt-get autoremove -y
    sudo apt-get clean
}
