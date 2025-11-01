#!/usr/bin/env bash

set -euo pipefail

main() {
    [[ -f "./terminal/git.sh" ]] \
        && bash "./terminal/git.sh" "$@"
    [[ -f "./terminal/zsh.sh" ]] \
        && bash "./terminal/zsh.sh" "$@"
    [[ -f "./terminal/omz.sh" ]] \
        && bash "./terminal/omz.sh" "$@"
    [[ -f "./app/docker.sh" ]] \
        && bash "./app/docker.sh" "$@"
}

if [[ $0 == "${BASH_SOURCE[0]}" ]]; then
    cd "$(dirname "${BASH_SOURCE[0]}")"
    main "$@"
fi
