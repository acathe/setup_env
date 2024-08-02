#!/usr/bin/env bash

set -e

# shellcheck source-path=..
source "./debian/option.sh"
# shellcheck source-path=..
source "./debian/terminals/apt.sh"
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
