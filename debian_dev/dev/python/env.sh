#!/usr/bin/env bash

set -euo pipefail

if [[ -n "${_DEV_ENV_TERMINAL_ENV_SH}" ]]; then
    return 0
else
    _DEV_ENV_TERMINAL_ENV_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _DEV_ENV_TERMINAL_ENV_SH
fi

install_uv() {
    curl -LsSf https://astral.sh/uv/install.sh | sh

    tee -a "${HOME}/.zshrc" <<EOF >"/dev/null"

# uv/uvx autocompletion
eval "\$(uv generate-shell-completion zsh)"
eval "\$(uvx --generate-shell-completion zsh)"
EOF
}

set_pip_proxy() {
    mkdir -p "${HOME}/.pip"
    tee "${HOME}/.pip/pip.conf" >/dev/null <<EOF
[global]
timeout = 60
index = https://pip.baidu-int.com/search/
index-url = https://pip.baidu-int.com/simple/
trusted-host = pip.baidu-int.com

[list]
format = columns
EOF
}

main() {
    install_uv
    set_pip_proxy
    rm -rf "${HOME}/env.sh"
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
    cd "${_DEV_ENV_TERMINAL_ENV_SH}"
    main "$@"
fi
