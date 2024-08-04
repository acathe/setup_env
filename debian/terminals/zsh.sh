#!/usr/bin/env bash

# shellcheck source-path=../..
source "./debian/tools/tools.sh"
# shellcheck source-path=../..
source "./debian/utils/utils.sh"

terminals::zsh::sync_profile() {
    if [ -z "$(command -v zsh)" ]; then
        return 1
    fi

    utils::sync_config "/etc/profile" "/etc/zsh/zprofile"
    utils::sync_config "${HOME}/.profile" "${HOME}/.zprofile"
}

terminals::zsh::setup() {
    tools::install_zsh

    terminals::zsh::sync_profile
}
