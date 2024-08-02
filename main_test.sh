#!/usr/bin/env bash

set -ex

source "./langs/golang_test.sh"

testing() {
    testing::langs::golang::_get_package
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    testing "$@"
fi
