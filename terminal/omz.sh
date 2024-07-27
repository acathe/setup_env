#!/usr/bin/env bash
#
# Respects the following environment variables:
#   ENABLE_CHINA_MIRROR -
#

set -e

main() {
    if [ -z "$(command -v git)" ]; then
        sudo apt-get update &&
            sudo apt-get install git -y &&
            sudo apt-get autoremove -y &&
            sudo apt-get clean
    fi

    local remote=""
    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/ohmyzsh.git/#%E5%88%87%E6%8D%A2%E5%B7%B2%E6%9C%89%20ohmyzsh%20%E8%87%B3%E9%95%9C%E5%83%8F%E6%BA%90
        local remote=https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git
    fi

    # Use RUNZSH=no to skip running Zsh and prevent interrupting the script.
    # Ref. https://ohmyz.sh/#install
    RUNZSH=no \
        REMOTE="$remote" \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Sync the previous ~/.zshrc with Oh-My-Zsh.
    cat "$HOME/.zshrc.pre-oh-my-zsh" >"$HOME/.tmp.zsh" &&
        cat "$HOME/.zshrc" >>"$HOME/.tmp.zsh" &&
        mv "$HOME/.tmp.zsh" "$HOME/.zshrc"

    # Remove backup files
    rm "$HOME/.shell.pre-oh-my-zsh" "$HOME/.zshrc.pre-oh-my-zsh"
}

main "$@"
