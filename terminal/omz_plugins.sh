#!/usr/bin/env bash

set -e

main() {
    sed -i '' '/^plugins=(/ s/git)/z brew vscode)/' "$HOME/.zshrc"

    # Ref. https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    sed -i '' '/^plugins=(/ s/)/ zsh-autosuggestions)/' "$HOME/.zshrc"

    # Ref. https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md/#Oh-my-zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    sed -i '' '/^plugins=(/ s/)/ zsh-syntax-highlighting)/' "$HOME/.zshrc"

    # Ref. https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    sed -i '' 's:^ZSH_THEME=".*":ZSH_THEME="powerlevel10k/powerlevel10k":' "$HOME/.zshrc"
    curl --proto '=https' --tlsv1.2 -sSfLo "$HOME/Downloads/MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    curl --proto '=https' --tlsv1.2 -sSfLo "$HOME/Downloads/MesloLGS NF Bold.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    curl --proto '=https' --tlsv1.2 -sSfLo "$HOME/Downloads/MesloLGS NF Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    curl --proto '=https' --tlsv1.2 -sSfLo "$HOME/Downloads/MesloLGS NF Bold Italic.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
}

main "$@"
