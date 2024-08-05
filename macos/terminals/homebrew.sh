#!/usr/bin/env bash

set -e

macos::terminals::homebrew::install() {
    if [ -z "$(command -v curl)" ]; then
        return 1
    fi

    # Ref. https://brew.sh/zh-cn/
    /bin/bash -c "$(curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh")"
}

macos::terminals::homebrew::set_env() {
    eval "$(/opt/homebrew/bin/brew shellenv)"

    if [ -s "${HOME}/.zprofile" ]; then
        echo >>"${HOME}/.zprofile"
    fi

    tee -a "${HOME}/.zprofile" <<EOF >/dev/null
# Homebrew
eval "\$(/opt/homebrew/bin/brew shellenv)"
EOF
}

macos::terminals::homebrew::upgrade() {
    brew update
    brew upgrade
}

macos::terminals::homebrew::setup() {
    macos::terminals::homebrew::install
    macos::terminals::homebrew::set_env
    macos::terminals::homebrew::upgrade
}
