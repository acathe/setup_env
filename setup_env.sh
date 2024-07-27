#!/usr/bin/env bash
#
# This is a personalized script!
# It is recommended to refer to it and implement your own!
# This script is for Debian Linux machines on Orbstack.
# It is intended for a minimal Debian installation.
# It will eventually install Zsh, Oh-My-Zsh with some plugins.
#
# When using this script, it is recommended to bypass the GFW to install
#  various software from the official repository.
# By running the script with ENABLE_CHINA_MIRROR, You can receive
#  subsequent updates from Chinese mirror.
#
# Respects the following environment variables:
#   ENABLE_CHINA_MIRROR   - enable Chinese mirror for subsequent updates.
#   SET_GIT_USER_NAME     - set the user.name in global gitconfig.
#   SET_GIT_USER_EMAIL    - set the user.email in global gitconfig.
#

set -e

init() {
    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        # Use Tsinghua mirror for Debian APT sources
        # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/debian/
        sudo tee /etc/apt/sources.list <<EOF
# By default, the source repositories are commented out to speed up apt update. You can uncomment them if needed.
deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware

deb https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware

# To prevent update failures from the official sources, the mirror is used by default for secure updates.
deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware
# deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free non-free-firmware
EOF
    fi

    sudo apt-get update &&
        sudo apt-get upgrade -y
}

finalize() {
    sudo apt-get autoremove -y &&
        sudo apt-get clean
}

configure_git() {
    # Install Git using APT if it is not already installed.
    if [ -z "$(command -v git)" ]; then
        # It is theoretically unlikely to reach this point. The script is hosted on github.
        # and it is unlikely that you would be able to use this script without git.
        sudo apt-get install git -y
    fi

    # Configure gitconfig based on environment variables.
    if [ -n "$SET_GIT_USER_NAME" ]; then
        git config --global user.name "$SET_GIT_USER_NAME"
    fi
    if [ -n "$SET_GIT_USER_EMAIL" ]; then
        git config --global user.email "$SET_GIT_USER_EMAIL"
    fi
    git config --global core.editor "code --wait"
}

install_zsh() {
    # Install Zsh using APT if it is not already installed.
    if [ -z "$(command -v zsh)" ]; then
        sudo apt-get install zsh -y
    fi

    # Sync Bash configuration to Zsh.
    echo "source /etc/environment" >"$HOME/.tmp.zsh" && # sync /etc/zsh/zshenv
        cat /etc/zsh/zshenv >>"$HOME/.tmp.zsh" &&
        sudo mv "$HOME/.tmp.zsh" /etc/zsh/zshenv
    echo "source /etc/profile" >"$HOME/.tmp.zsh" && # sync /etc/zsh/zprofile
        cat /etc/zsh/zprofile >>"$HOME/.tmp.zsh" &&
        sudo mv "$HOME/.tmp.zsh" /etc/zsh/zprofile
    echo "shopt() {}" >"$HOME/.tmp.zsh" && # sync /etc/zsh/zshrc
        echo "source /etc/bash.bashrc" >>"$HOME/.tmp.zsh" &&
        echo "unset -f shopt" >>"$HOME/.tmp.zsh" &&
        cat /etc/zsh/zshrc >>"$HOME/.tmp.zsh" &&
        sudo mv "$HOME/.tmp.zsh" /etc/zsh/zshrc
    echo "source $HOME/.bash_logout" >"$HOME/.zlogout" # sync ~/.zlogout
    echo "source $HOME/.profile" >"$HOME/.zprofile"    # sync ~/.zprofile
    echo "shopt() {}" >"$HOME/.zshrc" &&               # sync ~/.zshrc
        echo "source /etc/bash.bashrc" >>"$HOME/.zshrc" &&
        echo "unset -f shopt" >>"$HOME/.zshrc"
}

install_ohmyzsh() {
    if [ -n "$ENABLE_CHINA_MIRROR" ]; then
        # Ref. https://mirrors.tuna.tsinghua.edu.cn/help/ohmyzsh.git/#%E5%88%87%E6%8D%A2%E5%B7%B2%E6%9C%89%20ohmyzsh%20%E8%87%B3%E9%95%9C%E5%83%8F%E6%BA%90
        RUNZSH=no \
            REMOTE=https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git \
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        # Install Oh-My-Zsh from the official.
        # Use RUNZSH=no to skip running Zsh and prevent interrupting the script.
        # Ref. https://ohmyz.sh/#install
        RUNZSH=no \
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    # Sync the previous ~/.zshrc with Oh-My-Zsh.
    cat "$HOME/.zshrc.pre-oh-my-zsh" >"$HOME/.tmp.zsh" &&
        cat "$HOME/.zshrc" >>"$HOME/.tmp.zsh" &&
        mv "$HOME/.tmp.zsh" "$HOME/.zshrc"

    # Remove backup files
    rm "$HOME/.shell.pre-oh-my-zsh" "$HOME/.zshrc.pre-oh-my-zsh"
}

configure_ohmyzsh() {
    # Append plugins.
    sed -i '/^plugins=(/ s/)/ gitignore z vscode)/' "$HOME/.zshrc"

    # It suggests commands as you type based on history and completions.
    # Ref. https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    sed -i '/^plugins=(/ s/)/ zsh-autosuggestions)/' "$HOME/.zshrc"

    # This package provides syntax highlighting for the shell zsh.
    # Ref. https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md/#Oh-my-zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    sed -i '/^plugins=(/ s/)/ zsh-syntax-highlighting)/' "$HOME/.zshrc"

    # Powerlevel10k theme
    # Ref. https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    sed -i 's:^ZSH_THEME=".*":ZSH_THEME="powerlevel10k/powerlevel10k":' "$HOME/.zshrc"
}

main() {
    init
    configure_git
    install_zsh
    install_ohmyzsh
    configure_ohmyzsh
    finalize
}

main "$@"
