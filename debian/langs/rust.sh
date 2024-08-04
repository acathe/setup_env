#!/usr/bin/env bash

# shellcheck source-path=../..
source "./debian/tools/tools.sh"
# shellcheck source-path=../..
source "./debian/utils/utils.sh"

debian::langs::rust::install() {
    if [ -z "$(command -v curl)" ]; then
        return 1
    fi

    if [ -s "${HOME}/.zshenv" ]; then
        echo >>"${HOME}/.zshenv"
    fi

    echo "# Rust" >>"${HOME}/.zshenv"

    curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh -s -- -y
}

debian::langs::rust::set_env() {
    debian::utils::append_omz_plugins rust
}

debian::langs::rust::setup() {
    debian::tools::install_curl

    debian::langs::rust::install
    debian::langs::rust::set_env
}
