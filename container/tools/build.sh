#!/usr/bin/env bash

set -euo pipefail

TOOLS_PROTOBUF="${TOOLS_PROTOBUF:-false}"
TOOLS_THRIFT="${TOOLS_THRIFT:-false}"

parse_args() {
    POSITIONAL=()
    while (($# > 0)); do
        case "$1" in
            --tools-protobuf)
                TOOLS_PROTOBUF=true
                shift # shift once since flags have no values
                ;;
            --tools-thrift)
                TOOLS_THRIFT=true
                shift # shift once since flags have no values
                ;;
            *) # unknown flag/switch
                POSITIONAL+=("${1}")
                shift
                ;;
        esac
    done
}

main() {
    local from="dev-container/terminal:latest"

    if $TOOLS_PROTOBUF && [[ -f "./protobuf/build.sh" ]]; then
        bash ./protobuf/build.sh --from "$from" "$@"
        from="dev-container/tools/protobuf:latest"
    fi

    if $TOOLS_THRIFT && [[ -f "./thrift/build.sh" ]]; then
        bash ./thrift/build.sh --from "$from" "$@"
        from="dev-container/tools/thrift:latest"
    fi

    docker build . \
        -t dev-container/tools \
        --build-arg "from=$from"
}

if [[ $0 == "${BASH_SOURCE[0]}" ]]; then
    cd "$(dirname "${BASH_SOURCE[0]}")"
    parse_args "$@"
    set -- "${POSITIONAL[@]}" # restore positional params
    main "$@"
fi
