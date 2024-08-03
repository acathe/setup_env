#!/usr/bin/env bash
#
# Respects the following environment variables:
# - ENABLE_CHINA_MIRROR
#

set -e

terminals::homebrew::install() {
    # Ref. https://brew.sh/zh-cn/
    /bin/bash -c "$(curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh")"
}

terminals::homebrew::set_env() {
    if [ -s "${HOME}/.zprofile" ]; then
        echo >>"${HOME}/.zprofile"
    fi

    eval "$(/opt/homebrew/bin/brew shellenv)"

    tee -a "${HOME}/.zprofile" <<EOF
# Homebrew
eval "\$(/opt/homebrew/bin/brew shellenv)"
EOF

    if [ -n "${ENABLE_CHINA_MIRROR}" ]; then
        # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/#%E6%97%A5%E5%B8%B8%E4%BD%BF%E7%94%A8
        export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
        export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
        export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
        export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
        export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"

        # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/#%E9%95%BF%E6%9C%9F%E6%9B%BF%E6%8D%A2
        export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

        tee -a "${HOME}/.zprofile" <<EOF
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
EOF
    fi
}

terminals::homebrew::upgrade() {
    brew update
    brew upgrade
}

terminals::homebrew::setup() {
    terminals::homebrew::install
    terminals::homebrew::set_env
    terminals::homebrew::upgrade
}
