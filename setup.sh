#!/usr/bin/env bash

set -ex

install_git() {
    sudo apt-get update
    sudo apt-get install git -y
    sudo apt-get autoremove -y
    sudo apt-get clean
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
        _BRANCH="orbstack_machines/master"
    fi

    git clone --depth 1 --branch "${_BRANCH}" https://github.com/acathe/setup_env.git ./.setup_env
    cd "./.setup_env"

    bash "./main.sh"

    return 0
}

if [[ -z "${NO_SOURCE_SETUP}" ]]; then
    main "$@"
else
    echo "Error: sourced setup.sh is set." >&2
    exit 1
fi
