#!/usr/bin/env bash

set -e

main() {
    if [ -z "$(command -v zsh)" ]; then
        sudo apt-get update
        sudo apt-get install zsh -y
        sudo apt-get autoremove -y
        sudo apt-get clean
    fi

    { # sync /etc/zsh/zshenv
        echo "source /etc/environment"
        cat /etc/zsh/zshenv
    } >"$HOME/.tmp.zsh"
    sudo mv "$HOME/.tmp.zsh" /etc/zsh/zshenv

    { # sync /etc/zsh/zprofile
        echo "source /etc/profile"
        cat /etc/zsh/zprofile
    } >"$HOME/.tmp.zsh"
    sudo mv "$HOME/.tmp.zsh" /etc/zsh/zprofile

    { # sync /etc/zsh/zshrc
        echo "shopt() {}"
        echo "source /etc/bash.bashrc"
        echo "unset -f shopt"
        cat /etc/zsh/zshrc
    } >"$HOME/.tmp.zsh"
    sudo mv "$HOME/.tmp.zsh" /etc/zsh/zshrc

    # sync ~/.zlogout
    echo "source ~/.bash_logout" >"$HOME/.zlogout"

    # sync ~/.zprofile
    echo "source ~/.profile" >"$HOME/.zprofile"

    { # sync ~/.zshrc
        echo "shopt() {}"
        echo "source ~/.bashrc"
        echo "unset -f shopt"
    } >"$HOME/.zshrc"
}

main "$@"
