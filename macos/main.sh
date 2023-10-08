#!/usr/bin/env bash

set -e

# shellcheck source-path=..
source "./macos/terminals/homebrew.sh"
# shellcheck source-path=..
source "./macos/terminals/omz.sh"
# shellcheck source-path=..
source "./macos/applications/applications.sh"

main() {
    if [ ! -d "/Library/Developer/CommandLineTools" ]; then
        xcode-select --install
    fi

    if [[ -z "${DISABLE_HOMEBREW}" ]]; then
        macos::terminals::homebrew
    fi

    if [[ -z "${DISABLE_OMZ}" ]]; then
        macos::terminals::omz
    fi

    if [[ -n "${ENABLE_ORBSTACK}" ]]; then
        macos::applications::install_orbstack
    fi

    if [[ -n "${ENABLE_VSCODE}" ]]; then
        macos::applications::install_vscode
    fi

    if [[ -n "${ENABLE_CHATGPT}" ]]; then
        macos::applications::install_chatgpt
    fi

    if [[ -n "${ENABLE_UTM}" ]]; then
        macos::applications::install_utm
    fi

    return 0
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
