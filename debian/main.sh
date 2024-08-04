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

    if [[ -z "${DISABLE_TERMINALS_GIT}" ]]; then
        terminals::git::setup
    fi

    if [[ -z "${DISABLE_TERMINALS_ZSH}" ]]; then
        terminals::zsh::setup
    fi

    if [[ -z "${DISABLE_TERMINALS_OMZ}" ]]; then
        terminals::omz::setup
    fi

    if [[ -z "${DISABLE_LANGS_CPP}" ]]; then
        langs::cpp::setup
    fi

    if [[ -z "${DISABLE_LANGS_GOLANG}" ]]; then
        langs::golang::setup
    fi

    if [[ -z "${DISABLE_LANGS_RUST}" ]]; then
        langs::rust::setup
    fi

    if [[ -z "${DISABLE_LANGS_PYTHON}" ]]; then
        langs::python::setup
    fi

    sudo apt-get autoremove -y
    sudo apt-get clean
    return 0
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
