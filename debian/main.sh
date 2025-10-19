#!/usr/bin/env bash

set -euo pipefail

main() {
    cd "$(dirname "${BASH_SOURCE[0]}")"
    bash "./terminal/zsh.sh"
    bash "./terminal/omz.sh"
}

if [[ $0 == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi
