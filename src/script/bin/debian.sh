#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_DEBIAN_SH}" ]]; then
    return 0
else
    _SETUP_ENV_DEBIAN_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_DEBIAN_SH
    cd "${_SETUP_ENV_DEBIAN_SH}"
fi

main() {
    if [ -d "./.setup_env" ]; then
        rm -rf "./.setup_env"
    fi

    if [ -z "$(command -v git)" ]; then
        sudo apt-get update
        sudo apt-get install -y -qq git
    fi

    if [[ -z "${_BRANCH}" ]]; then
        _BRANCH="master"
    fi

    git clone --depth 1 --single-branch --branch "${_BRANCH}" "https://github.com/acathe/setup_env.git" "./.setup_env"

    cd "./.setup_env"
    bash "./debian/main.sh"
    cd ".."

    rm -rf "./.setup_env"
    return 0
}

main "$@"
