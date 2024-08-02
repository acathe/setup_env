#!/usr/bin/env bash

utils::load_vars_from_file() {
    local file="${1}"
    local var="${2}"

    if [ ! -f "${file}" ]; then
        return 1
    fi

    echo "$(
        # shellcheck source=/dev/null
        source "${file}"
        echo "${!var}"
    )"
}
