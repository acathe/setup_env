#!/usr/bin/env bash

langs::rust::install() {
    if [ -n "${ENABLE_CHINA_MIRROR}" ]; then
        # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/rustup/
        tee -a ~/.zprofile <<EOF
# Rust
export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
EOF

        export RUSTUP_UPDATE_ROOT=https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
        export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
    fi

    curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh -s -- -y
}

langs::rust::set_env() {
    if [ -n "${ENABLE_CHINA_MIRROR}" ]; then
        # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/crates.io-index/
        mkdir -p "${CARGO_HOME:-${HOME}/.cargo}"
        tee -a "${CARGO_HOME:-${HOME}/.cargo}/config.toml" <<EOF
[source.crates-io]
replace-with = 'mirror'

[source.mirror]
registry = "sparse+https://mirrors.tuna.tsinghua.edu.cn/crates.io-index/"
EOF
    fi

    sed -i '/^plugins=(/ s/)/ rust)/' "${HOME}/.zshrc"
}

langs::rust::setup() {
    langs::rust::install
    langs::rust::set_env
}