#!/usr/bin/env bash
#
# Respects the following environment variables:
# - ENABLE_CHINA_MIRROR
#

set -e

main() {
    # install git.
    # Ref. https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E5%AE%89%E8%A3%85-Git
    git -v

    local remote
    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/ohmyzsh.git/#%E5%88%87%E6%8D%A2%E5%B7%B2%E6%9C%89%20ohmyzsh%20%E8%87%B3%E9%95%9C%E5%83%8F%E6%BA%90
        local remote=https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git
    fi

    # Use RUNZSH=no to skip running Zsh and prevent interrupting the script.
    # Ref. https://ohmyz.sh/#install
    RUNZSH=no REMOTE="$remote" \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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
