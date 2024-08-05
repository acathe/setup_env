#!/usr/bin/env bash

set -e

# shellcheck source-path=../..
source "./debian/tools/tools.sh"

debian::terminals::git::set_env() {
    if [ -z "$(command -v git)" ]; then
        return 1
    fi

    if [[ -n "${GIT_USER_NAME}" ]]; then
        git config --global user.name "${GIT_USER_NAME}"
    fi

    if [[ -n "${GIT_USER_EMAIL}" ]]; then
        git config --global user.email "${GIT_USER_EMAIL}"
    fi

    git config --global core.editor "code --wait"
}

debian::terminals::git::setup() {
    debian::tools::install_git

    debian::terminals::git::set_env
}
