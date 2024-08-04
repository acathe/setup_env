#!/usr/bin/env bash

# shellcheck source-path=../..
source "./debian/tools/tools.sh"
# shellcheck source-path=../..
source "./debian/utils/utils.sh"

langs::golang::_get_package() {
    if [ -z "$(command -v curl)" ] || [ -z "$(command -v jq)" ]; then
        return 1
    fi

    local go_version os_type arch

    go_version="$(
        curl --proto '=https' --tlsv1.2 -sSfL https://go.dev/dl/?mode=json |
            jq -r '.[0].version'
    )"

    os_type="$(uname -s)"

    case "$(uname -m)" in
    "x86_64")
        arch="amd64"
        ;;
    "aarch64")
        arch="arm64"
        ;;
    *)
        return 1
        ;;
    esac

    echo "${go_version}.${os_type,,}-${arch}.tar.gz"
}

langs::golang::install() {
    if [ -z "$(command -v curl)" ]; then
        return 1
    fi

    local go_pkg
    go_pkg="$(langs::golang::_get_package)"

    curl --proto '=https' --tlsv1.2 -sSfOL "https://go.dev/dl/${go_pkg}"
    sudo rm -rf "/usr/local/go"
    sudo tar -C "/usr/local" -xzf "./${go_pkg}"
    rm "./${go_pkg}"
}

langs::golang::set_env() {
    export PATH="/usr/local/go/bin:${PATH}"

    local gopath="${HOME}/Projects/golang"
    go env -w GOPATH="${gopath}"
    export PATH="${gopath}/bin:${PATH}"

    if [ -s "${HOME}/.zshenv" ]; then
        echo >>"${HOME}/.zshenv"
    fi

    tee -a "${HOME}/.zshenv" <<EOF
# Golang
export PATH="/usr/local/go/bin:\${PATH}"
export PATH="\$(go env GOPATH)/bin:\${PATH}"
EOF

    utils::append_omz_plugins golang
}

langs::golang::setup() {
    tools::install_jq
    tools::install_curl

    langs::golang::install
    langs::golang::set_env
}
