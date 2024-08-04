#!/usr/bin/env bash

set -e

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
    bash "./macos/main.sh"
    cd ".."

    rm -rf "./.setup_env"
    return 0
}

main "$@"
