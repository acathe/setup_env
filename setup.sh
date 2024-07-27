#!/usr/bin/env bash
#
# Respects the following environment variables:
#   ENABLE_CHINA_MIRROR -
#   _BRANCH              -
#

set -e

main() {
    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        export ENABLE_CHINA_MIRROR=1
    fi

    bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/${_BRANCH}/terminal/apt.sh")"
    bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/${_BRANCH}/terminal/zsh.sh")"
    bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/${_BRANCH}/terminal/omz.sh")"
    bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/${_BRANCH}/terminal/omz_plugins.sh")"

    bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/${_BRANCH}/lang/cpp.sh")"
    bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/${_BRANCH}/lang/golang.sh")"
    bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/${_BRANCH}/lang/rust.sh")"
    bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/orbstack_machines/${_BRANCH}/lang/python.sh")"

    unset ENABLE_CHINA_MIRROR
}

main "$@"
