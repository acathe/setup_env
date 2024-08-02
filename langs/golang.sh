#!/usr/bin/env bash

# shellcheck source-path=..
source "./tools/jq.sh"

langs::golang::_get_package() {
    local go_version os_type arch

    go_version="$(
        curl --proto '=https' --tlsv1.2 -sSfL https://go.dev/dl/?mode=json |
            jq -r '.[0].version'
    )"
    os_type="$(uname -s)"
    arch="$(uname -m | sed 's/x86_64/amd64/')"

    echo "${go_version}.${os_type,,}-${arch}.tar.gz"
}

langs::golang::_get_download() {
    local golang_download="https://go.dev/dl"

    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        golang_download="https://golang.google.cn/dl"
    fi

    echo "${golang_download}"
}

langs::golang::install() {
    local go_pkg golang_download
    go_pkg="$(langs::golang::_get_package)"
    go_download="$(langs::golang::_get_download)"

    curl --proto '=https' --tlsv1.2 -sSfOL "${go_download}/${go_pkg}"
    sudo rm -rf "/usr/local/go"
    sudo tar -C "/usr/local" -xzf "./${go_pkg}"
    rm "./${go_pkg}"
}

langs::golang::set_env() {
    if [ -s "${HOME}/.zprofile" ]; then
        echo >>"${HOME}/.zprofile"
    fi

    tee -a "${HOME}/.zprofile" <<EOF
# Golang
export PATH="/usr/local/go/bin:\${PATH}"
export PATH="\$(go env GOPATH)/bin:\${PATH}"
EOF

    export PATH="/usr/local/go/bin:${PATH}"

    go env -w GO111MODULE="on"
    go env -w GOPATH="${HOME}/Projects/golang"

    PATH="$(go env GOPATH)/bin:${PATH}"
    export PATH

    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        go env -w GOPROXY="https://proxy.golang.com.cn,https://proxy.golang.com,direct"
        go env -w GOSUMDB="sum.golang.google.cn"
    fi

    sed -i '/^plugins=(/ s/)/ golang)/' "${HOME}/.zshrc"
}

langs::golang::setup() {
    if [ -z "$(command -v jq)" ]; then
        tools::jq::install
    fi

    langs::golang::install
    langs::golang::set_env
}
