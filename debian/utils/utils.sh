#!/usr/bin/env bash

utils::append_omz_plugins() {
    local _plugins_name="${*}"

    if [ ! -f "${HOME}/.zshrc" ]; then
        return 1
    fi

    if [[ "${_plugins_name}" == *"/"* ]]; then
        return 1
    fi

    sed -i "/^plugins=(/ s/)/ ${_plugins_name})/" "${HOME}/.zshrc"
}
