#!/usr/bin/env bash

# shellcheck source-path=../..
source "./debian/tools/tools.sh"
# shellcheck source-path=../..
source "./debian/utils/utils.sh"

debian::langs::golang::_get_package() {
    if [ -z "$(command -v curl)" ] || [ -z "$(command -v jq)" ]; then
        return 1
    fi

    local _go_version _os_type _arch

    _go_version="$(
        curl --proto '=https' --tlsv1.2 -sSfL https://go.dev/dl/?mode=json |
            jq -r '.[0].version'
    )"

    _os_type="$(uname -s)"

    case "$(uname -m)" in
    "x86_64")
        _arch="amd64"
        ;;
    "aarch64")
        _arch="arm64"
        ;;
    *)
        return 1
        ;;
    esac

    echo "${_go_version}.${_os_type,,}-${_arch}.tar.gz"
}

debian::langs::golang::install() {
    if [ -z "$(command -v curl)" ]; then
        return 1
    fi

    local _go_pkg
    _go_pkg="$(debian::langs::golang::_get_package)"

    curl --proto '=https' --tlsv1.2 -sSfOL "https://go.dev/dl/${_go_pkg}"
    sudo rm -rf "/usr/local/go"
    sudo tar -C "/usr/local" -xzf "./${_go_pkg}"
    rm "./${_go_pkg}"
}

debian::langs::golang::set_env() {
    export PATH="/usr/local/go/bin:${PATH}"

    local _gopath="${HOME}/Projects/golang"
    go env -w GOPATH="${_gopath}"
    export PATH="${_gopath}/bin:${PATH}"

    if [ -s "${HOME}/.zshenv" ]; then
        echo >>"${HOME}/.zshenv"
    fi

    tee -a "${HOME}/.zshenv" <<EOF >/dev/null
# Golang
export PATH="/usr/local/go/bin:\$PATH"
export PATH="\$(go env GOPATH)/bin:\$PATH"
EOF

    debian::utils::append_omz_plugins golang
}

debian::langs::golang::setup() {
    debian::tools::install_jq
    debian::tools::install_curl

    debian::langs::golang::install
    debian::langs::golang::set_env
}
