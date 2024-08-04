#!/usr/bin/env bash

# shellcheck source-path=../..
source "./debian/tools/tools.sh"
# shellcheck source-path=../..
source "./debian/utils/utils.sh"

terminals::omz::install() {
    if [ -z "$(command -v git)" ] || [ -z "$(command -v curl)" ]; then
        return 1
    fi

    # Use `RUNZSH="no"` to skip running Zsh and prevent interrupting the script.
    # Ref. https://ohmyz.sh/#install
    RUNZSH="no" sh -c "$(curl -fsSL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh")"

    if [ -s "${HOME}/.zshrc.pre-oh-my-zsh" ]; then
        echo >>"${HOME}/.zshrc.pre-oh-my-zsh"
        cat "${HOME}/.zshrc" >>"${HOME}/.zshrc.pre-oh-my-zsh"
        mv "${HOME}/.zshrc.pre-oh-my-zsh" "${HOME}/.zshrc"
    elif [ -f "${HOME}/.zshrc.pre-oh-my-zsh" ]; then
        rm "${HOME}/.zshrc.pre-oh-my-zsh"
    fi
}

terminals::omz::remove_preshell() {
    if [ ! -f "${HOME}/.shell.pre-oh-my-zsh" ]; then
        return
    fi

    local _preshell
    _preshell="$(cat "${HOME}/.shell.pre-oh-my-zsh")"
    rm "${HOME}/.shell.pre-oh-my-zsh"

    # Just implemented in Bash.
    if [[ "$(basename -- "${_preshell}")" != "bash" ]]; then
        return
    fi

    if [ -f "${HOME}/.bash_profile" ]; then
        rm "${HOME}/.bash_profile"
    fi

    if [ -f "${HOME}/.bash_login" ]; then
        rm "${HOME}/.bash_login"
    fi

    if [ -f "${HOME}/.bashrc" ]; then
        rm "${HOME}/.bashrc"
    fi

    if [ -f "${HOME}/.bash_logout" ]; then
        rm "${HOME}/.bash_logout"
    fi
}

terminals::omz::install_plugins() {
    if [ -z "$(command -v git)" ]; then
        return 1
    fi

    utils::append_omz_plugins gitignore z vscode

    # Ref. https://github.com/Pilaton/OhMyZsh-full-autoupdate?tab=readme-ov-file#installing
    git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate"
    utils::append_omz_plugins ohmyzsh-full-autoupdate

    # Ref. https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    utils::append_omz_plugins zsh-autosuggestions

    # Ref. https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md/#Oh-my-zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    utils::append_omz_plugins zsh-syntax-highlighting

    # Ref. https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k"
    sed -i 's:^ZSH_THEME=".*":ZSH_THEME="powerlevel10k/powerlevel10k":' "${HOME}/.zshrc"
}

terminals::omz::setup() {
    tools::install_git
    tools::install_curl

    terminals::omz::install
    terminals::omz::install_plugins
    terminals::omz::remove_preshell
}
