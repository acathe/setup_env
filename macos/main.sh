#!/usr/bin/env bash

set -e

# shellcheck source-path=..
source "./macos/option.sh"
# shellcheck source-path=..
source "./macos/terminals/homebrew.sh"
# shellcheck source-path=..
source "./macos/terminals/git.sh"
# shellcheck source-path=..
source "./macos/terminals/omz.sh"

main() {
    # install git.
    # Ref. https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E5%AE%89%E8%A3%85-Git
    git -v

    if ((SETUP_TERMINALS_HOMEBREW != 0)); then
        terminals::homebrew::setup
    fi

    if ((SETUP_TERMINALS_GIT != 0)); then
        terminals::git::setup
    fi

    if ((SETUP_TERMINALS_OMZ != 0)); then
        terminals::omz::setup
    fi

    return 0
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
