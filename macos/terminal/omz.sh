#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_MACOS_TERMINAL_OMZ_SH}" ]]; then
    return 0
else
    _SETUP_ENV_MACOS_TERMINAL_OMZ_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_MACOS_TERMINAL_OMZ_SH
    cd "${_SETUP_ENV_MACOS_TERMINAL_OMZ_SH}"
fi

source "../util/omz.sh"

terminal::omz::install() {
    if [ -z "$(command -v curl)" ]; then
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

terminal::omz::install_plugin() {
    util::omz::change_plugin "z" "brew" "vscode"

    # Ref. https://github.com/Pilaton/OhMyZsh-full-autoupdate?tab=readme-ov-file#installing
    git clone "https://github.com/Pilaton/OhMyZsh-full-autoupdate.git" "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate"
    util::omz::append_plugin "ohmyzsh-full-autoupdate"

    # Ref. https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
    git clone "https://github.com/zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    util::omz::append_plugin "zsh-autosuggestions"

    # Ref. https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md/#Oh-my-zsh
    git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    util::omz::append_plugin "zsh-syntax-highlighting"

    # Ref. https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh
    git clone --depth=1 "https://github.com/romkatv/powerlevel10k.git" "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k"
    util::omz::change_theme "powerlevel10k/powerlevel10k"
    brew install --cask font-meslo-for-powerlevel10k
}

terminal::omz() {
    terminal::omz::install
    terminal::omz::install_plugin
}
