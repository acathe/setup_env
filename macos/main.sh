#!/usr/bin/env bash

set -euo pipefail

main() {
    if [ ! -d "/Library/Developer/CommandLineTools" ]; then
        xcode-select --install
    fi

    cd "$(dirname "${BASH_SOURCE[0]}")"
    bash "./terminal/homebrew.sh"
    bash "./terminal/omz.sh"

    brew bundle --file="./brew_bundle/Brewfile"
}

if [[ $0 == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi
