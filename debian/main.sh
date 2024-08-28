#!/usr/bin/env bash

set -e

# shellcheck source-path=..
source "./debian/terminals/git.sh"
# shellcheck source-path=..
source "./debian/terminals/zsh.sh"
# shellcheck source-path=..
source "./debian/terminals/omz.sh"
# shellcheck source-path=..
source "./debian/langs/cpp.sh"
# shellcheck source-path=..
source "./debian/langs/golang.sh"
# shellcheck source-path=..
source "./debian/langs/rust.sh"
# shellcheck source-path=..
source "./debian/langs/python.sh"

main() {
    sudo apt-get update
    sudo apt-get upgrade -y

    if [[ -z "${DISABLE_GIT}" ]]; then
        debian::terminals::git
    fi

    if [[ -z "${DISABLE_ZSH}" ]]; then
        debian::terminals::zsh
    fi

    if [[ -z "${DISABLE_OMZ}" ]]; then
        debian::terminals::omz
    fi

    debian::tools::install_build_essential

    if [[ -n "${ENABLE_CPP}" ]]; then
        debian::langs::cpp
    fi

    if [[ -n "${ENABLE_GOLANG}" ]]; then
        debian::langs::golang
    fi

    if [[ -n "${ENABLE_RUST}" ]]; then
        debian::langs::rust
    fi

    if [[ -n "${ENABLE_PYTHON}" ]]; then
        debian::langs::python
    fi

    sudo apt-get autoremove -y
    sudo apt-get clean
    return 0
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
