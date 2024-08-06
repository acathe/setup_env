#!/usr/bin/env bash

set -e

macos::utils::change_omz_plugins() {
    local _plugins_name="${*}"

    if [ ! -f "${HOME}/.zshrc" ]; then
        return 1
    fi

    if [[ "${_plugins_name}" == *"/"* ]]; then
        return 1
    fi

    sed -i "" "s/^plugins=(.*)/plugins=(${_plugins_name})/" "${HOME}/.zshrc"
}

macos::utils::append_omz_plugins() {
    local _plugins_name="${*}"

    if [ ! -f "${HOME}/.zshrc" ]; then
        return 1
    fi

    if [[ "${_plugins_name}" == *"/"* ]]; then
        return 1
    fi

    sed -i "" "/^plugins=(/s/)/ ${_plugins_name})/" "${HOME}/.zshrc"
}

macos::utils::change_omz_theme() {
    local _theme_name="${*}"

    if [ ! -f "${HOME}/.zshrc" ]; then
        return 1
    fi

    if [[ "${_theme_name}" == *":"* ]]; then
        return 1
    fi

    sed -i "" "s:^ZSH_THEME=\".*\":ZSH_THEME=\"${_theme_name}\":" "${HOME}/.zshrc"
}
