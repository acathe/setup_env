#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_LINUX_TERMINAL_GIT_SH}" ]]; then
    return 0
else
    _SETUP_ENV_LINUX_TERMINAL_GIT_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_LINUX_TERMINAL_GIT_SH
fi

# shellcheck source=../util/apt.sh
source "${_SETUP_ENV_LINUX_TERMINAL_GIT_SH}/../util/apt.sh"

git::install() {
    apt::update
    apt::install "git"
}

git::set_env() {
    if [ -z "$(command -v git)" ]; then
        echo "git is not installed." >&2
        return 1
    fi

    declare -A _git_env=(
        ["user.name"]="${GIT_USER_NAME}"
        ["user.email"]="${GIT_USER_EMAIL}"
        ["core.editor"]="code --wait"
    )

    for key in "${!_git_env[@]}"; do
        if [[ -z "${_git_env[${key}]}" ]]; then
            continue
        fi

        git config --global "${key}" "${_git_env[${key}]}"
    done
}

main() {
    git::install
    git::set_env
}

if [[ "${0}" == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi
