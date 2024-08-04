#!/usr/bin/env bash

# shellcheck source-path=../..
source "./debian/tools/tools.sh"
# shellcheck source-path=../..
source "./debian/utils/utils.sh"

langs::rust::install() {
    if [ -z "$(command -v curl)" ]; then
        return 1
    fi

    if [ -s "${HOME}/.zshenv" ]; then
        echo >>"${HOME}/.zshenv"
    fi

    echo "# Rust" >>"${HOME}/.zshenv"

    curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh -s -- -y
}

langs::rust::set_env() {
    utils::append_omz_plugins rust
}

langs::rust::setup() {
    tools::install_curl

    langs::rust::install
    langs::rust::set_env
}
