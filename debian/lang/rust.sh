#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_LINUX_LANG_RUST_SH}" ]]; then
    return 0
else
    _SETUP_ENV_LINUX_LANG_RUST_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_LINUX_LANG_RUST_SH
fi

# shellcheck source=../util/apt.sh
source "${_SETUP_ENV_LINUX_LANG_RUST_SH}/../util/apt.sh"
# shellcheck source=../terminal/omz.sh
source "${_SETUP_ENV_LINUX_LANG_RUST_SH}/../terminal/omz.sh"

rust::install() {
    apt::install "curl"

    if [ -s "${HOME}/.profile" ]; then
        echo >>"${HOME}/.profile"
    fi

    echo "# Rust" >>"${HOME}/.profile"

    curl --proto "=https" --tlsv1.2 -sSfL "https://sh.rustup.rs" | sh -s -- -y

    if [ -f "${HOME}/.zshenv" ] && [[ "$(cat "${HOME}/.zshenv")" == ". \"\$HOME/.cargo/env\"" ]]; then
        rm "${HOME}/.zshenv"
    fi
}

rust::set_env() {
    omz::append_plugin "rust"
}

main() {
    rust::install
    rust::set_env
}

if [[ "${0}" == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi
