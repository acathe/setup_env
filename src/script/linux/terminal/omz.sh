#!/usr/bin/env bash

set -e

if [[ -n "${_SETUP_ENV_DEBIAN_TERMINAL_OMZ_SH}" ]]; then
    return 0
else
    _SETUP_ENV_DEBIAN_TERMINAL_OMZ_SH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    readonly _SETUP_ENV_DEBIAN_TERMINAL_OMZ_SH
    cd "${_SETUP_ENV_DEBIAN_TERMINAL_OMZ_SH}"
fi

source "../util/apt.sh"
source "../util/omz.sh"

terminal::omz::install() {
    util::apt::install "git"
    util::apt::install "curl"

    # Use `RUNZSH="no"` to skip running Zsh and prevent interrupting the script.
    # Ref. https://ohmyz.sh/#install
    RUNZSH="no" sh -c "$(curl -fsSL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh")"

    if [ -s "${HOME}/.zshrc.pre-oh-my-zsh" ]; then
        # If the file is not empty, then append the content to the new `.zshrc`.
        echo >>"${HOME}/.zshrc.pre-oh-my-zsh"
        cat "${HOME}/.zshrc" >>"${HOME}/.zshrc.pre-oh-my-zsh"
        mv "${HOME}/.zshrc.pre-oh-my-zsh" "${HOME}/.zshrc"
    elif [ -f "${HOME}/.zshrc.pre-oh-my-zsh" ]; then
        # If the file is empty, then remove it.
        rm "${HOME}/.zshrc.pre-oh-my-zsh"
    fi
}

terminal::omz::remove_preshell() {
    if [ ! -f "${HOME}/.shell.pre-oh-my-zsh" ]; then
        return 0
    fi

    local _preshell
    _preshell="$(cat "${HOME}/.shell.pre-oh-my-zsh")"
    rm "${HOME}/.shell.pre-oh-my-zsh"

    # Remove the old shell configuration files.
    # XXX: Only works on OrbStack and Bash. Check if running in OrbStack.
    if [[ "$(basename -- "${_preshell}")" != "bash" ]]; then
        return 0
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

terminal::omz::install_plugins() {
    util::apt::install "git"

    util::omz::append_plugin "gitignore" "z" "vscode"

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
}

terminal::omz() {
    terminal::omz::install
    terminal::omz::install_plugins
    terminal::omz::remove_preshell
}
