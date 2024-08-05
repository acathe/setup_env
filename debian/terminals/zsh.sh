#!/usr/bin/env bash

set -e

# shellcheck source-path=../..
source "./debian/tools/tools.sh"
# shellcheck source-path=../..
source "./debian/utils/utils.sh"

debian::terminals::zsh::sync_profile() {
    if [ -z "$(command -v zsh)" ]; then
        return 1
    fi

    debian::utils::sync_profile "/etc/profile" /etc/zsh/zprofile
    debian::utils::sync_profile "${HOME}/.profile" "${HOME}/.zprofile"
}

debian::terminals::zsh::setup() {
    debian::tools::install_zsh

    debian::terminals::zsh::sync_profile
}
