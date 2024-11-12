#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_DEBIAN_LANG_RUST_SH}" ]]; then
    return 0
else
    _SETUP_ENV_DEBIAN_LANG_RUST_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_DEBIAN_LANG_RUST_SH
    cd "${_SETUP_ENV_DEBIAN_LANG_RUST_SH}"
fi

source "../util/apt.sh"
source "../util/omz.sh"

lang::rust::install() {
    util::apt::install "curl"

    if [ -s "${HOME}/.profile" ]; then
        echo >>"${HOME}/.profile"
    fi

    echo "# Rust" >>"${HOME}/.profile"

    curl --proto "=https" --tlsv1.2 -sSf "https://sh.rustup.rs" | sh -s -- -y

    if [ -f "${HOME}/.zshenv" ] && [[ "$(cat "${HOME}/.zshenv")" == ". \"\$HOME/.cargo/env\"" ]]; then
        rm "${HOME}/.zshenv"
    fi
}

lang::rust::set_env() {
    util::omz::append_plugin "rust"
}

lang::rust() {
    lang::rust::install
    lang::rust::set_env
}
