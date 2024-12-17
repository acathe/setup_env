#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_MACOS_APP_APP_SH}" ]]; then
    return 0
else
    _SETUP_ENV_MACOS_APP_APP_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_MACOS_APP_APP_SH
    cd "${_SETUP_ENV_MACOS_APP_APP_SH}"
fi

source "../util/brew.sh"

app::orbstack() {
    util::brew::install_cask "orbstack"
}

app::vscode() {
    util::brew::install_cask "visual-studio-code" "font-fira-code"
}

app::chatgpt() {
    util::brew::install_cask "chatgpt"
}

app::utm() {
    util::brew::install_cask "utm"
}
