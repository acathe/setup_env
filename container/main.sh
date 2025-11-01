#!/usr/bin/env bash

set -euo pipefail

main() {
    [[ -f "./base/build.sh" ]] \
        && bash "./base/build.sh" "$@"

    [[ -f "./terminal/build.sh" ]] \
        && bash "./terminal/build.sh" "$@"

    [[ -f "./dev/build.sh" ]] \
        && bash "./dev/build.sh" "$@"
}

if [[ $0 == "${BASH_SOURCE[0]}" ]]; then
    cd "$(dirname "${BASH_SOURCE[0]}")"
    main "$@"
fi
