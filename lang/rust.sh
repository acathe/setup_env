#!/usr/bin/env bash
#
# Respects the following environment variables:
#   ENABLE_CHINA_MIRROR   - enable Chinese mirror for subsequent updates.
#

set -e

main() {
    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        # https://mirrors.tuna.tsinghua.edu.cn/help/rustup/
        export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
        export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup

        cat <<EOF | tee -a ~/.zprofile
# Rust
export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
EOF
    fi

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        # https://mirrors.tuna.tsinghua.edu.cn/help/crates.io-index/
        mkdir -vp "${CARGO_HOME:-$HOME/.cargo}"
        cat <<EOF | tee -a "${CARGO_HOME:-$HOME/.cargo}/config"
[source.crates-io]
replace-with = 'mirror'

[source.mirror]
registry = "sparse+https://mirrors.tuna.tsinghua.edu.cn/crates.io-index/"
EOF
    fi
}

main "$@"
