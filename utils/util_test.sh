#!/usr/bin/env bash

set -e

source "./utils.sh"

testing::utils::load_vars_from_file() {
    {
        a="$(utils::load_vars_from_file "/etc/os-release" "ID")"
        if [[ "${a}" != "debian" ]]; then
            echo "${a} not equal debian" >&2
            exit 1
        fi
    }
    {
        a="$(utils::load_vars_from_file "/etc/os-release" "VERSION_CODENAME")"
        if [[ "${a}" != "bookworm" ]]; then
            echo "${a} not equal bookworm" >&2
            exit 2
        fi
    }
    echo "All tests passed!"
}

testing() {
    testing::utils::load_vars_from_file
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    testing "$@"
fi
