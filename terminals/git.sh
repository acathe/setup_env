#!/usr/bin/env bash

terminals::git::install() {
    sudo apt-get update
    sudo apt-get install git -y
    sudo apt-get autoremove -y
    sudo apt-get clean
}

terminals::git::set_env() {
    if [[ -n "${GIT_USER_NAME}" ]]; then
        git config --global user.name "${GIT_USER_NAME}"
    fi

    if [[ -n "${GIT_USER_EMAIL}" ]]; then
        git config --global user.email "${GIT_USER_EMAIL}"
    fi

    git config --global core.editor "code --wait"
}

terminals::git::setup() {
    if [ -z "$(command -v git)" ]; then
        terminals::git::install
    fi

    terminals::git::set_env
}
