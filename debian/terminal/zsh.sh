#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_LINUX_TERMINAL_ZSH_SH}" ]]; then
    return 0
else
    _SETUP_ENV_LINUX_TERMINAL_ZSH_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_LINUX_TERMINAL_ZSH_SH
fi

# shellcheck source=../util/apt.sh
source "${_SETUP_ENV_LINUX_TERMINAL_ZSH_SH}/../util/apt.sh"

zsh::install() {
    apt::update
    apt::install "zsh"
}

zsh::_sync_profile() {
    local _pre="${1}" _cur="${2}"

    if [ ! -f "${_pre}" ]; then
        echo "No such file: ${_pre}, skip."
        return 0
    fi

    if [[ "${_pre}" =~ ^"${HOME}"/ ]]; then
        _pre="${_pre/"${HOME}"/"\$HOME"}"
    fi

    tee "/tmp/.profile.sync" <<EOF >"/dev/null"
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

zsh::sync_profile() {
    zsh::_sync_profile "/etc/profile" "/etc/zsh/zprofile"
    zsh::_sync_profile "${HOME}/.profile" "${HOME}/.zprofile"
}

main() {
    zsh::install
    zsh::sync_profile
}

if [[ "${0}" == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi
