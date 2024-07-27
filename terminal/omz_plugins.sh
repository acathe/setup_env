#!/usr/bin/env bash

set -ex

main() {
    sed -i '/^plugins=(/ s/)/ gitignore z vscode)/' "$HOME/.zshrc"

    # Ref. https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    sed -i '/^plugins=(/ s/)/ zsh-autosuggestions)/' "$HOME/.zshrc"

    # Ref. https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md/#Oh-my-zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    sed -i '/^plugins=(/ s/)/ zsh-syntax-highlighting)/' "$HOME/.zshrc"

    # Ref. https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    sed -i 's:^ZSH_THEME=".*":ZSH_THEME="powerlevel10k/powerlevel10k":' "$HOME/.zshrc"
}

main "$@"
