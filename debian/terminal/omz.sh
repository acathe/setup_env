#!/usr/bin/env bash

set -euo pipefail

install_omz() {
    if [[ -z "$(command -v git)" ]]; then
        echo "git is not installed." >&2
        return 1
    fi

    if [[ -z "$(command -v curl)" ]]; then
        echo "curl is not installed." >&2
        return 1
    fi

    # Use `RUNZSH="no"` to skip running Zsh and prevent interrupting the script.
    # Ref. https://ohmyz.sh/#install
    RUNZSH="no" sh -c "$(curl --proto "=https" --tlsv1.2 -fsSL "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh")"

    if [[ -s "$HOME/.zshrc.pre-oh-my-zsh" ]]; then
        echo >> "$HOME/.zshrc.pre-oh-my-zsh"
        cat "$HOME/.zshrc" >> "$HOME/.zshrc.pre-oh-my-zsh"
        mv "$HOME/.zshrc.pre-oh-my-zsh" "$HOME/.zshrc"
    elif [[ -f "$HOME/.zshrc.pre-oh-my-zsh" ]]; then
        rm "$HOME/.zshrc.pre-oh-my-zsh"
    fi
}

install_plugin() {
    if [[ -z "$(command -v git)" ]]; then
        echo "git is not installed." >&2
        return 1
    fi

    sed -i '/^plugins=(/s/)/ z sudo vscode)/' "$HOME/.zshrc"

    # Ref. https://github.com/Pilaton/OhMyZsh-full-autoupdate?tab=readme-ov-file#installing
    git clone "https://github.com/Pilaton/OhMyZsh-full-autoupdate.git" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate"
    sed -i '/^plugins=(/s/)/ ohmyzsh-full-autoupdate)/' "$HOME/.zshrc"

    # Ref. https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
    git clone "https://github.com/zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    sed -i '/^plugins=(/s/)/ zsh-autosuggestions)/' "$HOME/.zshrc"

    # Ref. https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md/#Oh-my-zsh
    git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    sed -i '/^plugins=(/s/)/ zsh-syntax-highlighting)/' "$HOME/.zshrc"

    # Ref. https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh
    git clone --depth=1 "https://github.com/romkatv/powerlevel10k.git" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    sed -i 's|^ZSH_THEME=".*"|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$HOME/.zshrc"
}

remove_preshell() {
    if [[ ! -f "$HOME/.shell.pre-oh-my-zsh" ]]; then
        return 0
    fi

    rm "$HOME/.shell.pre-oh-my-zsh"

    sed -i "/export PATH=\$HOME\/bin:\$HOME\/\.local\/bin:\/usr\/local\/bin:\$PATH/s/^# //" "$HOME/.zshrc"

    [[ -f "$HOME/.profile" ]] && rm "$HOME/.profile"
    [[ -f "$HOME/.bashrc" ]] && rm "$HOME/.bashrc"
    [[ -f "$HOME/.bash_logout" ]] && rm "$HOME/.bash_logout"
}

main() {
    install_omz
    install_plugin
    remove_preshell
}

if [[ $0 == "${BASH_SOURCE[0]}" ]]; then
    cd "$(dirname "${BASH_SOURCE[0]}")"
    main "$@"
fi
