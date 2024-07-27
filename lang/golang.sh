#!/usr/bin/env bash
# Respects the following environment variables:
#   ENABLE_CHINA_MIRROR -
#

set -e

# Specify the Go version to install to.
# @parameter
#   - $1: go_version
main() {
    local go_version="$1"

    if [[ -z "$go_version" ]]; then
        echo "Error: No Go version was specified." >&2
        return 1
    fi

    local golang_download="https://go.dev/dl/go${go_version}.linux-amd64.tar.gz"
    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        golang_download="https://golang.google.cn/dl/go${go_version}.linux-amd64.tar.gz"
    fi

    curl --proto '=https' --tlsv1.2 -sSfOL "${golang_download}" &&
        rm -rf /usr/local/go &&
        tar -C /usr/local -xzf "./go${go_version}.linux-arm64.tar.gz" &&
        rm "./go${go_version}.linux-arm64.tar.gz"

    # Append Go configuration
    cat <<EOF | tee -a ~/.zshrc
# Golang
export GO111MODULE="on"
export GOPATH="$HOME/Projects/golang"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
EOF

    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        # Append China proxy
        cat <<EOF | tee -a ~/.zshrc
export GOPROXY="https://goproxy.cn,direct"
export GOSUMDB="sum.golang.google.cn"
EOF
    fi
}

main "$@"
