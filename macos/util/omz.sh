#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_MACOS_UTIL_OMZ_SH}" ]]; then
    return 0
else
    _SETUP_ENV_MACOS_UTIL_OMZ_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_MACOS_UTIL_OMZ_SH
    cd "${_SETUP_ENV_MACOS_UTIL_OMZ_SH}"
fi

util::omz::change_plugin() {
    local _plugins_name="${*}"

    if [ ! -f "${HOME}/.zshrc" ]; then
        return 1
    fi

    if [[ "${_plugins_name}" == *"/"* ]]; then
        return 1
    fi

    sed -i "" "s/^plugins=(.*)/plugins=(${_plugins_name})/" "${HOME}/.zshrc"
}

util::omz::append_plugin() {
    local _plugins_name="${*}"

    if [ ! -f "${HOME}/.zshrc" ]; then
        return 1
    fi

    if [[ "${_plugins_name}" == *"/"* ]]; then
        return 1
    fi

    sed -i "" "/^plugins=(/s/)/ ${_plugins_name})/" "${HOME}/.zshrc"
}

util::omz::change_theme() {
    local _theme_name="${1}"

    if [ ! -f "${HOME}/.zshrc" ]; then
        return 1
    fi

    if [[ "${_theme_name}" == *":"* ]]; then
        return 1
    fi

    sed -i "" "s:^ZSH_THEME=\".*\":ZSH_THEME=\"${_theme_name}\":" "${HOME}/.zshrc"
}
