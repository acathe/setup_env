#!/usr/bin/env bash

# shellcheck source-path=..
source "./langs/golang.sh"

testing::langs::golang::_get_package() {
    {
        go_version=go1.22.5
        os_type="$(uname -s)"
        arch="$(uname -m | sed 's/x86_64/amd64/')"

        a="${go_version}.${os_type,,}-${arch}.tar.gz"
        if [[ "${a}" != "go1.22.5.linux-amd64.tar.gz" ]]; then
            echo "${a} not equal go1.22.5.linux-amd64.tar.gz" >&2
            exit 1
        fi
    }
    echo "langs::golang::_get_package all tests passed!"
}
