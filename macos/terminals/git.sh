#!/usr/bin/env bash

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
    terminals::git::set_env
}
