#!/usr/bin/env bash

# shellcheck source-path=../..
source "./debian/terminals/git.sh"

terminals::omz::install() {
    local remote
    if [ -n "${ENABLE_CHINA_MIRROR}" ]; then
        # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/ohmyzsh.git/#%E5%88%87%E6%8D%A2%E5%B7%B2%E6%9C%89%20ohmyzsh%20%E8%87%B3%E9%95%9C%E5%83%8F%E6%BA%90
        remote="https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git"
    fi

    # Use RUNZSH=no to skip running Zsh and prevent interrupting the script.
    # Ref. https://ohmyz.sh/#install
    RUNZSH="no" REMOTE="${remote}" \
        sh -c "$(curl -fsSL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh")"

    if [ -f "${HOME}/.shell.pre-oh-my-zsh" ]; then
        rm "${HOME}/.shell.pre-oh-my-zsh"
    fi

    if [ -f "${HOME}/.zshrc.pre-oh-my-zsh" ]; then
        cat "${HOME}/.zshrc.pre-oh-my-zsh" >"${HOME}/.tmp.zsh"
        echo >>"${HOME}/.tmp.zsh"
        cat "${HOME}/.zshrc" >>"${HOME}/.tmp.zsh"
        mv "${HOME}/.tmp.zsh" "${HOME}/.zshrc"
        rm "${HOME}/.zshrc.pre-oh-my-zsh"
    fi
}

terminals::omz::install_plugins() {
    sed -i '/^plugins=(/ s/)/ gitignore z vscode)/' "${HOME}/.zshrc"

    # Ref. https://github.com/Pilaton/OhMyZsh-full-autoupdate?tab=readme-ov-file#installing
    git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate"
    sed -i '/^plugins=(/ s/)/ ohmyzsh-full-autoupdate)/' "${HOME}/.zshrc"

    # Ref. https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    sed -i '/^plugins=(/ s/)/ zsh-autosuggestions)/' "${HOME}/.zshrc"

    # Ref. https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md/#Oh-my-zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    sed -i '/^plugins=(/ s/)/ zsh-syntax-highlighting)/' "${HOME}/.zshrc"

    # Ref. https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k"
    sed -i 's:^ZSH_THEME=".*":ZSH_THEME="powerlevel10k/powerlevel10k":' "${HOME}/.zshrc"
}

terminals::omz::setup() {
    if [ -z "$(command -v git)" ]; then
        terminals::git::install
    fi

    terminals::omz::install
    terminals::omz::install_plugins
}
