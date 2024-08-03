#!/usr/bin/env bash

set -e

install_git() {
    sudo apt-get update
    sudo apt-get install git -y
}

option() {
    export SETUP_TERMINALS_APT=1
    export SETUP_TERMINALS_GIT=1
    export SETUP_TERMINALS_ZSH=1
    export SETUP_TERMINALS_OMZ=1
    export SETUP_LANGS_CPP=1
    export SETUP_LANGS_GOLANG=0 # default disable
    export SETUP_LANGS_RUST=1
    export SETUP_LANGS_PYTHON=1
}

main() {
    if [ -d "./.setup_env" ]; then
        echo "Error: .setup_env directory already exists." >&2
        return 1
    fi

    if [ -z "$(command -v git)" ]; then
        install_git
    fi

    if [[ -z "${_BRANCH}" ]]; then
        _BRANCH="master"
    fi

    git clone --depth 1 --branch "${_BRANCH}" https://github.com/acathe/setup_env.git ./.setup_env
    cd "./.setup_env"

    option
    bash "./debian/main.sh"

    cd ".."
    rm -rf "./.setup_env"

    return 0
}

main "$@"
