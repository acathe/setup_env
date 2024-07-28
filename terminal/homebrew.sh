#!/usr/bin/env bash

set -e

main() {
    # Ref. https://brew.sh/zh-cn/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> >>~/.zprofile

    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/#%E6%97%A5%E5%B8%B8%E4%BD%BF%E7%94%A8
        cat <<EOF | tee -a ~/.zshrc
# Homebrew
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"
EOF

        # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/#%E9%95%BF%E6%9C%9F%E6%9B%BF%E6%8D%A2
        echo 'export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"' >>~/.zprofile

        # eval "$(/opt/homebrew/bin/brew shellenv)"
        export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
        export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
        export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
        export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
        export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"
        export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
    fi

    brew update
    brew upgrade
    brew install --cask visual-studio-code orbstack
}

main "$@"
