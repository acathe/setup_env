#!/usr/bin/env bash

set -euo pipefail

BRANCH="${BRANCH:-master}"

parse_args() {
    POSITIONAL=()
    while (($# > 0)); do
        case "$1" in
            --branch)
                numOfArgs=1 # number of switch arguments
                if (($# < numOfArgs + 1)); then
                    shift $#
                else
                    BRANCH="$2"
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
    if [[ -z "$(command -v git)" ]]; then
        sudo apt-get update
        sudo apt-get install -y git
    fi

    tmpdir="$(mktemp -du "/tmp/setup_env.XXXXXX")"

    git clone "https://github.com/acathe/setup-env.git" "$tmpdir" \
        --depth 1 \
        --single-branch \
        --branch "$BRANCH"

    bash "$tmpdir/container/main.sh" "$@"
}

parse_args "$@"
set -- "${POSITIONAL[@]}" # restore positional params
main "$@"
