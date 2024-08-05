#!/usr/bin/env bash

set -e

# shellcheck source-path=../..
source "./debian/tools/tools.sh"
# shellcheck source-path=../..
source "./debian/utils/utils.sh"

debian::langs::rust::install() {
    if [ -z "$(command -v curl)" ]; then
        return 1
    fi

    if [ -s "${HOME}/.profile" ]; then
        echo >>"${HOME}/.profile"
    fi

    echo "# Rust" >>"${HOME}/.profile"

    curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh -s -- -y

    if [ -f "${HOME}/.zshenv" ] && [[ "$(cat "${HOME}/.zshenv")" == ". \"\$HOME/.cargo/env\"" ]]; then
        rm "${HOME}/.zshenv"
    fi
}

debian::langs::rust::set_env() {
    debian::utils::append_omz_plugins rust
}

debian::langs::rust::setup() {
    debian::tools::install_curl

    debian::langs::rust::install
    debian::langs::rust::set_env
}
