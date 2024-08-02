#!/usr/bin/env bash

set -e

source "./option.sh"
source "./terminals/apt.sh"
source "./terminals/git.sh"
source "./terminals/zsh.sh"
source "./terminals/omz.sh"
source "./langs/cpp.sh"
source "./langs/golang.sh"
source "./langs/rust.sh"
source "./langs/python.sh"

main() {
    sudo apt-get update

    if ((SETUP_TERMINALS_APT != 0)); then
        terminals::apt::setup
    fi

    if ((SETUP_TERMINALS_GIT != 0)); then
        terminals::git::setup
    fi

    if ((SETUP_TERMINALS_ZSH != 0)); then
        terminals::zsh::setup
    fi

    if ((SETUP_TERMINALS_OMZ != 0)); then
        terminals::omz::setup
    fi

    if ((SETUP_LANGS_CPP != 0)); then
        langs::cpp::setup
    fi

    if ((SETUP_LANGS_GOLANG != 0)); then
        langs::golang::setup
    fi

    if ((SETUP_LANGS_RUST != 0)); then
        langs::rust::setup
    fi

    if ((SETUP_LANGS_PYTHON != 0)); then
        langs::python::setup
    fi

    sudo apt-get autoremove -y
    sudo apt-get clean

    return 0
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
