#!/usr/bin/env bash

set -euo pipefail

USER="${USER:-}"

parse_args() {
    POSITIONAL=()
    while (($# > 0)); do
        case "$1" in
            --user)
                numOfArgs=1 # number of switch arguments
                if (($# < numOfArgs + 1)); then
                    shift $#
                else
                    USER="$2"
                    POSITIONAL+=("$1" "$2")
                    shift $((numOfArgs + 1)) # shift 'numOfArgs + 1' to bypass switch and its value
                fi
                ;;
            *) # unknown flag/switch
                POSITIONAL+=("$1")
                shift
                ;;
        esac
    done
}

main() {
    [[ -f "./base/build.sh" ]] \
        && bash "./base/build.sh" "$@"

    [[ -f "./terminal/build.sh" ]] \
        && bash "./terminal/build.sh" "$@"

    [[ -f "./dev/build.sh" ]] \
        && bash "./dev/build.sh" "$@"

    [[ -f "./tools/build.sh" ]] \
        && bash "./tools/build.sh" "$@"

    docker build . \
        -t dev-container/main

    [[ ! -d "$HOME/Projects" ]] && mkdir -p "$HOME/Projects"

    docker run -d \
        --name dev-container \
        -v "$HOME/Projects:/home/$USER/Projects" \
        dev-container/main
}

if [[ $0 == "${BASH_SOURCE[0]}" ]]; then
    cd "$(dirname "${BASH_SOURCE[0]}")"
    parse_args "$@"
    set -- "${POSITIONAL[@]}" # restore positional params
    main "$@"
fi
