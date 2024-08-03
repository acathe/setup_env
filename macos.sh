#!/usr/bin/env bash

set -e

option() {
    export SETUP_TERMINALS_HOMEBREW=1
    export SETUP_TERMINALS_OMZ=1
    export INSTALL_APPLICATIONS_ORBSTACK=1
    export INSTALL_APPLICATIONS_VSCODE=1
    export INSTALL_APPLICATIONS_CHATGPT=1
}

main() {
    if [ -d "./.setup_env" ]; then
        echo "Error: .setup_env directory already exists." >&2
        return 1
    fi

    git -v

    if [[ -z "${_BRANCH}" ]]; then
        _BRANCH="master"
    fi

    git clone --depth 1 --branch "${_BRANCH}" https://github.com/acathe/setup_env.git ./.setup_env
    cd "./.setup_env"

    option
    bash "./macos/main.sh"

    cd ".."
    rm -rf "./.setup_env"

    return 0
}

main "$@"
