#!/usr/bin/env bash

utils::sync_config() {
    local pre_config="${1}"
    local cur_config="${2}"

    if [ ! -f "${pre_config}" ]; then
        return
    fi

    if [[ "${pre_config}" =~ ^"${HOME}"/ ]]; then
        pre_config="${pre_config/"${HOME}"/"\${HOME}"}"
    fi

    tee "${HOME}/.tmp.sync" <<EOF
# Sync configuration.
. ${pre_config}
EOF

    if [ -s "${cur_config}" ]; then
        echo >>"${HOME}/.tmp.sync"
        cat "${cur_config}" >>"${HOME}/.tmp.sync"
    fi

    sudo mv "${HOME}/.tmp.sync" "${cur_config}"
}

utils::append_omz_plugins() {
    local plugins_name="${*}"

    if [ ! -f "${HOME}/.zshrc" ]; then
        return 1
    fi

    if [[ "${plugins_name}" == *"/"* ]]; then
        return 1
    fi

    sed -i "/^plugins=(/ s/)/ ${plugins_name})/" "${HOME}/.zshrc"
}
