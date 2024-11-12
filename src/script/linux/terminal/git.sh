#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_DEBIAN_TERMINAL_GIT_SH}" ]]; then
    return 0
else
    _SETUP_ENV_DEBIAN_TERMINAL_GIT_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_DEBIAN_TERMINAL_GIT_SH
    cd "${_SETUP_ENV_DEBIAN_TERMINAL_GIT_SH}"
fi

source "../util/apt.sh"

terminal::git::set_env() {
    util::apt::install "git"

    if [[ -n "${GIT_USER_NAME}" ]]; then
        git config --global user.name "${GIT_USER_NAME}"
    fi

    if [[ -n "${GIT_USER_EMAIL}" ]]; then
        git config --global user.email "${GIT_USER_EMAIL}"
    fi

    git config --global core.editor "code --wait"
}

terminal::git() {
    terminal::git::set_env
}
