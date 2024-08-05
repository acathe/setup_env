#!/usr/bin/env bash

set -e

debian::utils::sync_profile() {
    local _pre="${1}"
    local _cur="${2}"

    if [ ! -f "${_pre}" ]; then
        return
    fi

    if [[ "${_pre}" =~ ^"${HOME}"/ ]]; then
        _pre="${_pre/"${HOME}"/"\$HOME"}"
    fi

    tee "/tmp/.profile.sync" <<EOF
# Sync ${_pre}.
. ${_pre}
EOF

    if [ -s "${_cur}" ]; then
        echo >>"/tmp/.profile.sync"
        cat "${_cur}" >>"/tmp/.profile.sync"
    fi

    if [ -w "$(dirname -- "${_cur}")" ]; then
        mv "/tmp/.profile.sync" "${_cur}"
    else
        sudo mv "/tmp/.profile.sync" "${_cur}"
    fi
}

debian::utils::append_omz_plugins() {
    local _plugins_name="${*}"

    if [ ! -f "${HOME}/.zshrc" ]; then
        return 1
    fi

    if [[ "${_plugins_name}" == *"/"* ]]; then
        return 1
    fi

    sed -i "/^plugins=(/ s/)/ ${_plugins_name})/" "${HOME}/.zshrc"
}

debian::utils::change_omz_theme() {
    local _theme_name="${*}"

    if [ ! -f "${HOME}/.zshrc" ]; then
        return 1
    fi

    if [[ "${_theme_name}" == *":"* ]]; then
        return 1
    fi

    sed -i "s:^ZSH_THEME=\".*\":ZSH_THEME=\"${_theme_name}\":" "${HOME}/.zshrc"
}
