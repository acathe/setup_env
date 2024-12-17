#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_LINUX_LANG_GO_SH}" ]]; then
    return 0
else
    _SETUP_ENV_LINUX_LANG_GO_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_LINUX_LANG_GO_SH
fi

# shellcheck source=../util/apt.sh
source "${_SETUP_ENV_LINUX_LANG_GO_SH}/../util/apt.sh"
# shellcheck source=../terminal/omz.sh
source "${_SETUP_ENV_LINUX_LANG_GO_SH}/../terminal/omz.sh"

go::_get_package() {
    apt::install "curl" "jq"

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

go::install() {
    apt::install "curl"

    local _go_pkg
    _go_pkg="$(go::_get_package)"

    local _download_dir="/tmp/setup_env/download"
    mkdir -p "${_download_dir}"

    curl --proto "=https" --tlsv1.2 -sSfL "https://go.dev/dl/${_go_pkg}" -o "${_download_dir}/${_go_pkg}"
    sudo rm -rf "/usr/local/go"
    sudo tar -C "/usr/local" -xzf "${_download_dir}/${_go_pkg}"
}

go::set_env() {
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

    omz::append_plugin "golang"
}

main() {
    go::install
    go::set_env
}

if [[ "${0}" == "${BASH_SOURCE[0]}" ]]; then
    main "$@"
fi
