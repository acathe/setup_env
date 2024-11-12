#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_DEBIAN_MAIN_SH}" ]]; then
    return 0
else
    _SETUP_ENV_DEBIAN_MAIN_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_DEBIAN_MAIN_SH
    cd "${_SETUP_ENV_DEBIAN_MAIN_SH}"
fi

source "./lang/cpp.sh"
source "./lang/golang.sh"
source "./lang/rust.sh"
source "./lang/python.sh"
source "./terminal/git.sh"
source "./terminal/zsh.sh"
source "./terminal/omz.sh"
source "./util/apt.sh"

main() {
    util::apt::update_all_pkg

    if [[ -z "${DISABLE_GIT}" ]]; then
        terminal::git
    fi

    if [[ -z "${DISABLE_ZSH}" ]]; then
        terminal::zsh
    fi

    if [[ -z "${DISABLE_OMZ}" ]]; then
        terminal::omz
    fi

    tools::install_build_essential

    if [[ -n "${ENABLE_CPP}" ]]; then
        lang::cpp
    fi

    if [[ -n "${ENABLE_GOLANG}" ]]; then
        lang::golang
    fi

    if [[ -n "${ENABLE_RUST}" ]]; then
        lang::rust
    fi

    if [[ -n "${ENABLE_PYTHON}" ]]; then
        lang::python
    fi

    util::apt::clean
    return 0
}

if [[ "${0}" == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi
