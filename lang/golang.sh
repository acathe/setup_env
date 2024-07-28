#!/usr/bin/env bash
# Respects the following environment variables:
#   ENABLE_CHINA_MIRROR -
#

set -e

main() {
    if [ -z "$(command -v jq)" ]; then
        sudo apt-get update
        sudo apt-get install jq -y
        sudo apt-get autoremove -y
        sudo apt-get clean
    fi

    local go_version
    go_version="$(curl --proto '=https' --tlsv1.2 -sSfL https://go.dev/dl/?mode=json | jq -r '.[0].version')"

    local golang_download="https://go.dev/dl/${go_version}.linux-amd64.tar.gz"
    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        golang_download="https://golang.google.cn/dl/${go_version}.linux-amd64.tar.gz"
    fi

    curl --proto '=https' --tlsv1.2 -sSfOL "${golang_download}"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "./${go_version}.linux-amd64.tar.gz"
    rm "./${go_version}.linux-amd64.tar.gz"

    export PATH="/usr/local/go/bin:$PATH"
    go env -w GO111MODULE="on"
    go env -w GOPATH="$HOME/Projects/golang"
    PATH="$(go env GOPATH)/bin:$PATH"
    export PATH

    cat <<EOF | tee -a ~/.zprofile
# Golang
export PATH="/usr/local/go/bin:\$PATH"
export PATH="\$(go env GOPATH)/bin:\$PATH"
EOF

    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        go env -w GOPROXY="https://goproxy.cn,direct"
        go env -w GOSUMDB="sum.golang.google.cn"
    fi

    sed -i '/^plugins=(/ s/)/ golang)/' "$HOME/.zshrc"
}

main "$@"
