#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_MACOS_TERMINAL_HOMEBREW_SH}" ]]; then
    return 0
else
    _SETUP_ENV_MACOS_TERMINAL_HOMEBREW_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_MACOS_TERMINAL_HOMEBREW_SH
    cd "${_SETUP_ENV_MACOS_TERMINAL_HOMEBREW_SH}"
fi

terminal::homebrew::install() {
    if [ -n "$(command -v brew)" ]; then
        return 0
    fi

    if [ -z "$(command -v curl)" ]; then
        return 1
    fi

    # Ref. https://brew.sh/zh-cn/
    /bin/bash -c "$(curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh")"
}

terminal::homebrew::set_env() {
    if [ ! -d "/opt/homebrew" ]; then
        return 0
    fi

    eval "$(/opt/homebrew/bin/brew shellenv)"

    if [ -s "${HOME}/.zprofile" ]; then
        echo >>"${HOME}/.zprofile"
    fi

    tee -a "${HOME}/.zprofile" <<EOF >"/dev/null"
# Homebrew
eval "\$(/opt/homebrew/bin/brew shellenv)"
EOF
}

terminal::homebrew::upgrade() {
    brew update
    brew upgrade
}

terminal::homebrew() {
    terminal::homebrew::install
    terminal::homebrew::set_env
    terminal::homebrew::upgrade
}
