#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_DEBIAN_LANG_GOLANG_SH}" ]]; then
    return 0
else
    _SETUP_ENV_DEBIAN_LANG_GOLANG_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_DEBIAN_LANG_GOLANG_SH
    cd "${_SETUP_ENV_DEBIAN_LANG_GOLANG_SH}"
fi

source "../util/apt.sh"
source "../util/omz.sh"

lang::golang::_get_package() {
    util::apt::install "curl" "jq"

    local _go_version
    _go_version="$(
        curl --proto "=https" --tlsv1.2 -sSfL "https://go.dev/dl/?mode=json" |
            jq -r ".[0].version"
    )"

    local _os_type _arch
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

lang::golang::install() {
    util::apt::install "curl"

    local _go_pkg
    _go_pkg="$(lang::golang::_get_package)"

    curl --proto "=https" --tlsv1.2 -sSfOL "https://go.dev/dl/${_go_pkg}"
    sudo rm -rf "/usr/local/go"
    sudo tar -C "/usr/local" -xzf "./${_go_pkg}"
    rm "./${_go_pkg}"
}

lang::golang::set_env() {
    export PATH="/usr/local/go/bin:${PATH}"

    local _gopath="${HOME}/Projects/golang"
    go env -w GOPATH="${_gopath}"
    export PATH="${_gopath}/bin:${PATH}"

    if [ -s "${HOME}/.profile" ]; then
        echo >>"${HOME}/.profile"
    fi

    tee -a "${HOME}/.profile" <<EOF >"/dev/null"
# Golang
export PATH="/usr/local/go/bin:\$PATH"
export PATH="\$(go env GOPATH)/bin:\$PATH"
EOF

    util::omz::append_plugin "golang"
}

lang::golang() {
    lang::golang::install
    lang::golang::set_env
}
