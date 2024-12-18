#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_MACOS_UTIL_BREW_SH}" ]]; then
    return 0
else
    _SETUP_ENV_MACOS_UTIL_BREW_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_MACOS_UTIL_BREW_SH
    cd "${_SETUP_ENV_MACOS_UTIL_BREW_SH}"
fi

util::brew::install_cask() {
    local _packages=("${@}")

    brew install --cask "${_packages[@]}"
}
