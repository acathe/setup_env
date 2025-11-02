#!/usr/bin/env bash

set -euo pipefail

FROM="${FROM:-"dev-container/terminal:latest"}"
DEV_BASH="${DEV_BASH:-false}"
DEV_GO="${DEV_GO:-false}"
DEV_PYTHON="${DEV_PYTHON:-false}"
DEV_RUST="${DEV_RUST:-false}"

parse_args() {
    POSITIONAL=()
    while (($# > 0)); do
        case "$1" in
            --from)
                numOfArgs=1 # number of switch arguments
                if (($# < numOfArgs + 1)); then
                    shift $#
                else
                    FROM="$2"
                    shift $((numOfArgs + 1)) # shift 'numOfArgs + 1' to bypass switch and its value
                fi
                ;;
            --dev-bash)
                DEV_BASH=true
                shift # shift once since flags have no values
                ;;
            --dev-go)
                DEV_GO=true
                shift
                ;;
            --dev-python)
                DEV_PYTHON=true
                shift
                ;;
            --dev-rust)
                DEV_RUST=true
                shift
                ;;
            *) # unknown flag/switch
                POSITIONAL+=("${1}")
                shift
                ;;
        esac
    done
}

main() {
    if $DEV_BASH && [[ -f "./bash/build.sh" ]]; then
        bash ./bash/build.sh --from "$FROM" "$@"
        FROM="dev-container/dev/bash:latest"
    fi

    if $DEV_GO && [[ -f "./go/build.sh" ]]; then
        bash ./go/build.sh --from "$FROM" "$@"
        FROM="dev-container/dev/go:latest"
    fi

    if $DEV_PYTHON && [[ -f "./python/build.sh" ]]; then
        bash ./python/build.sh --from "$FROM" "$@"
        FROM="dev-container/dev/python:latest"
    fi

    if $DEV_RUST && [[ -f "./rust/build.sh" ]]; then
        bash ./rust/build.sh --from "$FROM" "$@"
        FROM="dev-container/dev/rust:latest"
    fi

    docker build . \
        -t dev-container/dev \
        --build-arg "from=$FROM"
}

if [[ $0 == "${BASH_SOURCE[0]}" ]]; then
    cd "$(dirname "${BASH_SOURCE[0]}")"
    parse_args "$@"
    set -- "${POSITIONAL[@]}" # restore positional params
    main "$@"
fi
