#!/usr/bin/env bash

# shellcheck source-path=../..
source "./debian/tools/tools.sh"

terminals::zsh::sync_profile() {
    if [ -z "$(command -v zsh)" ]; then
        return 1
    fi

    if [ -f "/etc/profile" ]; then
        echo | sudo tee -a "/etc/zsh/zshenv" >/dev/null
        sudo tee -a "/etc/zsh/zshenv" <<EOF >/dev/null
# Sync /etc/profile
if [[ \$- == *i* ]]; then
    . /etc/profile
fi
EOF
    fi

    if [ -f "${HOME}/.profile" ]; then
        echo >>"${HOME}/.zshenv"
        tee -a "${HOME}/.zshenv" <<EOF >/dev/null
# Sync \$HOME/.profile
if [[ \$- == *i* ]]; then
    . \$HOME/.profile
fi
EOF
    fi
}

terminals::zsh::setup() {
    tools::install_zsh

    terminals::zsh::sync_profile
}
