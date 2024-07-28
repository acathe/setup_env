#!/usr/bin/env bash
#
# Respects the following environment variables:
#   ENABLE_CHINA_MIRROR -
#

set -e

main() {

    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        export ENABLE_CHINA_MIRROR=1
    fi

    bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/macos/master/tool/omz.sh")"
    bash -c "$(curl -fsSL "https://raw.githubusercontent.com/acathe/setup_env/macos/master/tool/homebrew.sh")"

    unset ENABLE_CHINA_MIRROR
}

main "$@"
