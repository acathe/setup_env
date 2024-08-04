#!/usr/bin/env bash

# shellcheck source-path=../..
source "./debian/tools/tools.sh"

debian::terminals::zsh::sync_profile() {
    if [ -z "$(command -v zsh)" ]; then
        return 1
    fi

    if [ -f "/etc/profile" ]; then
        if [ -s "/etc/zsh/zshenv" ]; then
            echo | sudo tee -a "/etc/zsh/zshenv" >/dev/null
        fi

        sudo tee -a "/etc/zsh/zshenv" <<EOF >/dev/null
# Sync /etc/profile
if [[ \$- == *i* ]]; then
    . /etc/profile
fi
EOF
    fi

    if [ -f "${HOME}/.profile" ]; then
        if [ -s "${HOME}/.zshenv" ]; then
            echo >>"${HOME}/.zshenv"
        fi

        tee -a "${HOME}/.zshenv" <<EOF >/dev/null
# Sync \$HOME/.profile
if [[ \$- == *i* ]]; then
    . \$HOME/.profile
fi
EOF
    fi
}

debian::terminals::zsh::setup() {
    debian::tools::install_zsh

    debian::terminals::zsh::sync_profile
}
