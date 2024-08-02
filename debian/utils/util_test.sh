#!/usr/bin/env bash

# shellcheck source-path=../..
source "./debian/utils/utils.sh"

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
    echo "utils::load_vars_from_file all tests passed!"
}
